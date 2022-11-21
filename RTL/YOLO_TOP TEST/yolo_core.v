// ============================================================================
// Copyright (C) 2019 NARLabs TSRI. All rights reserved.
//
// Designer : Liu Yi-Jun
// Date     : 2019.10.31
// Ver      : 1.2
// Module   : yolo_core
// Func     : 
//            1.) Bypass  
//            2.) adder: incoming every two operand, output one result
//
//
// ============================================================================

`timescale 1 ns / 1 ps

module yolo_core #(
        parameter TBITS = 32 ,
        parameter TBYTE = 4
) (

        //
        input  wire [TBITS-1:0] isif_data_dout ,  // {last,user,strb,data}
        input  wire [TBYTE-1:0] isif_strb_dout ,
        input  wire [1 - 1:0]   isif_last_dout ,  // 
        input  wire [1 - 1:0]   isif_user_dout ,  // 
        input  wire             isif_empty_n ,
        output wire             isif_read ,

        //
        output wire [TBITS-1:0] osif_data_din ,
        output wire [TBYTE-1:0] osif_strb_din ,
        output wire [1 - 1:0]   osif_last_din ,
        output wire [1 - 1:0]   osif_user_din ,
        input  wire             osif_full_n ,
        output wire             osif_write ,

        //
        input  wire             rst ,
        input  wire             clk
);  

//==========  parameter ========== //
localparam DATA_LENGTH = 13;
//state
localparam IDLE = 2'b00;
localparam READ = 2'b01;
localparam CAL  = 2'b10;
localparam WB   = 2'b11;
//state num
localparam STATE_NUM = 2;
localparam NUM_COL = 8;
localparam EXTEND = TBITS-DATA_LENGTH;

//state
reg [STATE_NUM-1:0] curr_state, next_state;
//counter
reg [2:0] counter;
//data_delay_buffer
reg [DATA_LENGTH*4-1:0] data_temp;

//state wire
wire READ_state = curr_state == READ;
wire WB_state   = curr_state == WB;

//flag
wire read_done  = counter == 'd0 && curr_state == READ;
wire wb_done    = counter == 'd0 && curr_state == WB  ;

//==========  OUTPUT  ========== //
assign isif_read     = READ_state;
assign osif_data_din = WB_state ? {{EXTEND{1'b0}},data_temp} : 'd0;
assign osif_strb_din = {TBYTE{1'b1}};
assign osif_last_din = read_done;
assign osif_user_din = 0;
assign osif_write    = WB_state;

//==========  QR_CORDIC IO  ========== //
wire [DATA_LENGTH*4-1:0] qr_data_out;
wire qr_out_valid;
wire qr_in_valid  = READ_state;

//==========  FSM  ========== //
always @(posedge clk or posedge rst) begin 
        if(rst) begin
             curr_state <= IDLE;
        end else begin
             curr_state <= next_state;
        end
end

always @(*) begin
        case (curr_state)
                IDLE: next_state = isif_empty_n ? READ : IDLE;
                READ: next_state = read_done    ? CAL  : READ;
                CAL : next_state = qr_out_valid ? WB   : CAL ;
                WB  : next_state = wb_done      ? IDLE : WB  ;
                default : next_state = IDLE;
        endcase
end

//==========  DESIGN  ========== //
always @(posedge clk or posedge rst) begin 
        if(rst) begin
                counter <= NUM_COL - 1;
        end
        else if(curr_state == READ) begin
                counter <= counter - 'd1;
        end
        else if(curr_state == WB) begin
                counter <= counter - 'd1;
        end
end

//data_temp
always @(posedge clk or posedge rst) begin
        if(rst) begin
            data_temp <= 'd0;
        end 
        else if(qr_out_valid) begin
            data_temp <= qr_data_out;
        end
end

//==========  Module  ========== //
        QR_CORDIC 
        inst_QR_CORDIC(
                .clk        (clk),
                .rst        (rst),
                .valid      (READ_state),
                .out_vallid (qr_out_valid),
                .in         (isif_data_dout[DATA_LENGTH*4-1:0]),
                .out        (qr_data_out)
        );

endmodule  

