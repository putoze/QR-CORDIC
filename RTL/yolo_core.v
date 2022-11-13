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
//rst_n change into negedge reset
wire rst_n = ~rst;
//state
reg [STATE_NUM-1:0] curr_state, next_state;
//counter
reg [2:0] counter;
//data_delay_buffer
reg [DATA_LENGTH*4-1:0] data_temp;
//in_valid delay buffer
reg in_valid_d,in_valid_d2;

//==========  parameter ========== //
parameter DATA_LENGTH = 13;
//state
localparam IDLE = 2'b00;
localparam READ = 2'b01;
localparam CAL  = 2'b10;
localparam WB   = 2'b11;
//state num
localparam STATE_NUM = 2;

//state wire
wire READ_state = curr_state == READ;

//flag
wire read_done  = counter == 'd7 && curr_state == READ;
wire wb_done    = counter == 'd7 && curr_state == WB  ;
wire read_start = ;
wire wb_start   = ;

//==========  OUTPUT  ========== //
assign isif_read     = curr_state == IDLE && isif_empty_n;
assign osif_data_din;
assign osif_strb_din;
assign osif_last_din;
assign osif_user_din;
assign osif_write;

//==========  QR_CORDIC IO  ========== //
wire [DATA_LENGTH*4-1:0] qr_data_out;
wire qr_out_valid;
wire qr_in_valid = in_valid_d2;

//==========  FSM  ========== //
always @(posedge clk or negedge rst_n) begin 
        if(~rst_n) begin
             curr_state <= IDLE;
        end else begin
             curr_state <= next_state;
        end
end

always @(*) begin
        case (curr_state)
                IDLE: next_state = isif_empty_n ? READ : IDLE;
                READ: next_state = read_start   ? CAL  : READ;
                CAL : next_state = wb_start     ? WB   : CAL ;
                WB  : next_state = wb_done      ? IDLE : WB  ;
                default : next_state = IDLE;
        endcase
end

//==========  DESIGN  ========== //
always @(posedge clk or negedge rst_n) begin 
        if(rst_n) begin
                counter <= 'd0;
        end
        else if(curr_state == READ) begin
                counter <= counter + 'd1;
        end
        else if(curr_state == WB) begin
                counter <= counter + 'd1;
        end
end

//data_temp

//==========  Module  ========== //
        QR_CORDIC 
        #(.DATA_LENGTH(DATA_LENGTH)
        )
        inst_QR_CORDIC(
                .clk        (clk),
                .rst_n      (rst_n),
                .valid      (READ_state),
                .out_vallid (qr_out_valid),
                .in         (data_temp),
                .out        (qr_data_out)
        );


endmodule  

