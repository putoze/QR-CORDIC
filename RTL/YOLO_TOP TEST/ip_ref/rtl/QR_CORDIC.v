//`include "ROTATION_MODE.v"
//`include "VECTOR_MODE.v"

module QR_CORDIC
  #(
    DATA_LENGTH = 13
    )
  (
    input                        clk,
    input                        rst,
    input                        valid,
    output                       out_vallid,
    input    [DATA_LENGTH*4-1:0] in,
    output   [DATA_LENGTH*4-1:0] out
  );

//integer
integer i;

//========== parameter ========== //
//constant
localparam signed K = 11'b01001101110;

//state
localparam IDLE = 2'b00;
localparam CAL  = 2'b01;
localparam OUT  = 2'b10;

//bit length parameter
localparam K_LENGTH  = 11;
localparam ROW_INDEX = 3; //8 row
localparam NUM_COL   = 4; //also number of GG, NUM_GR=3+2+1
localparam NUM_ROW   = 8; //2^ROW_INDEX
localparam ITER_IDX  = 3; //iterate 8 times
localparam NUM_STATE = 2; //number of state
localparam NUM_SIGN  = 2; //folded cordic with 2 times

//========== reg ========== //
reg [NUM_STATE-1:0] cur_state;
reg [ROW_INDEX-1:0] counter;

//iterate 8 times
reg [ITER_IDX-1:0] iter_num_r_gg1,iter_num_r_gg2,iter_num_r_gg3,iter_num_r_gg4;
reg [ITER_IDX-1:0] iter_num_r_gg1_d,iter_num_r_gg2_d,iter_num_r_gg3_d;
reg [ITER_IDX-1:0] iter_num_r_gg1_d2,iter_num_r_gg2_d2;
reg [ITER_IDX-1:0] iter_num_r_gg1_d3;

//row_index of X
reg [ROW_INDEX-1:0] row_index_gg1,row_index_gg2,row_index_gg3,row_index_gg4;
reg [ROW_INDEX-1:0] row_index_gg1_d,row_index_gg2_d,row_index_gg3_d;
reg [ROW_INDEX-1:0] row_index_gg1_d2,row_index_gg2_d2;
reg [ROW_INDEX-1:0] row_index_gg1_d3;

//row_index of Y
reg [ROW_INDEX-1:0] row_index_gg1_sub1_d,row_index_gg2_sub1_d,row_index_gg3_sub1_d;
reg [ROW_INDEX-1:0] row_index_gg1_sub1_d2,row_index_gg2_sub1_d2;
reg [ROW_INDEX-1:0] row_index_gg1_sub1_d3;

//data
reg signed [DATA_LENGTH-1:0] in_reg[0:NUM_ROW-1][0:NUM_COL-1]; //data storage

//controll
reg [NUM_COL-1:0] enable_gg;//0:enable_gg1/1:enable_gg2/2:enable_gg3/3:enable_gg4
reg [NUM_COL-2:0] enable_d; //0:enable_gr1/1:enable_gr2/2:enable_gr3
reg [NUM_COL-3:0] enable_d2;//0:enable_gr4/1:enable_gr5
reg [NUM_COL-4:0] enable_d3;//enable_gr6

reg [NUM_COL-1:0] stall_gg;//0:stall gg1/1:stall gg2/2:stall gg3/3:stall gg4
reg [NUM_COL-2:0] stall_d; //0:stall gr1/1:stall gr2/2:stall gr3
reg [NUM_COL-3:0] stall_d2;//0:stall gr4/1:stall gr5
reg [NUM_COL-4:0] stall_d3;//stall gr6

//========== IO ========== //
reg signed [DATA_LENGTH-1:0] in_m1_w;
reg signed [DATA_LENGTH-1:0] in_m2_w;
reg signed [DATA_LENGTH-1:0] in_m3_w;
reg signed [DATA_LENGTH-1:0] in_m4_w;

//GG
reg signed [DATA_LENGTH-1:0] in_gg1_X_w;
reg signed [DATA_LENGTH-1:0] in_gg2_X_w;
reg signed [DATA_LENGTH-1:0] in_gg3_X_w;
reg signed [DATA_LENGTH-1:0] in_gg4_X_w;

reg signed [DATA_LENGTH-1:0] in_gg1_Y_w;
reg signed [DATA_LENGTH-1:0] in_gg2_Y_w;
reg signed [DATA_LENGTH-1:0] in_gg3_Y_w;
reg signed [DATA_LENGTH-1:0] in_gg4_Y_w;

wire signed [DATA_LENGTH-1:0] out_gg1_X_w;
wire signed [DATA_LENGTH-1:0] out_gg2_X_w;
wire signed [DATA_LENGTH-1:0] out_gg3_X_w;
wire signed [DATA_LENGTH-1:0] out_gg4_X_w;

wire signed [DATA_LENGTH-1:0] out_gg1_Y_w;
wire signed [DATA_LENGTH-1:0] out_gg2_Y_w;
wire signed [DATA_LENGTH-1:0] out_gg3_Y_w;
wire signed [DATA_LENGTH-1:0] out_gg4_Y_w;

wire [NUM_SIGN-1:0] sign_gg1,sign_gg2,sign_gg3,sign_gg4;
reg  [NUM_SIGN-1:0] sign_gg1_d,sign_gg2_d,sign_gg3_d;//delay
reg  [NUM_SIGN-1:0] sign_gg1_d2,sign_gg2_d2;//delay2
reg  [NUM_SIGN-1:0] sign_gg1_d3;//delay3

//GR
reg  signed [DATA_LENGTH-1:0] in_gr1_X_w,in_gr2_X_w,in_gr3_X_w,in_gr4_X_w,in_gr5_X_w,in_gr6_X_w;
reg  signed [DATA_LENGTH-1:0] in_gr1_Y_w,in_gr2_Y_w,in_gr3_Y_w,in_gr4_Y_w,in_gr5_Y_w,in_gr6_Y_w;

wire signed [DATA_LENGTH-1:0] out_gr1_X_w,out_gr2_X_w,out_gr3_X_w,out_gr4_X_w,out_gr5_X_w,out_gr6_X_w;
wire signed [DATA_LENGTH-1:0] out_gr1_Y_w,out_gr2_Y_w,out_gr3_Y_w,out_gr4_Y_w,out_gr5_Y_w,out_gr6_Y_w;

//flag
wire cal_start = valid          && counter       == 'd0;
wire cal_done  = stall_gg[3]    && row_index_gg4 == 'd4;
wire out_done  = counter == 'd0 && cur_state[1];

//==========  operator  ========== //
wire signed [DATA_LENGTH+K_LENGTH-1:0] out_m1_w = in_m1_w * K;
wire signed [DATA_LENGTH+K_LENGTH-1:0] out_m2_w = in_m2_w * K;
wire signed [DATA_LENGTH+K_LENGTH-1:0] out_m3_w = in_m3_w * K;
wire signed [DATA_LENGTH+K_LENGTH-1:0] out_m4_w = in_m4_w * K;

wire [ROW_INDEX-1:0] row_index_gg1_sub1 = row_index_gg1 - 'd1;
wire [ROW_INDEX-1:0] row_index_gg2_sub1 = row_index_gg2 - 'd1;
wire [ROW_INDEX-1:0] row_index_gg3_sub1 = row_index_gg3 - 'd1;
wire [ROW_INDEX-1:0] row_index_gg4_sub1 = row_index_gg4 - 'd1;

wire [ITER_IDX-1:0] iter_num_r_gg1_add2 = iter_num_r_gg1 + 'd2;
wire [ITER_IDX-1:0] iter_num_r_gg2_add2 = iter_num_r_gg2 + 'd2;
wire [ITER_IDX-1:0] iter_num_r_gg3_add2 = iter_num_r_gg3 + 'd2;
wire [ITER_IDX-1:0] iter_num_r_gg4_add2 = iter_num_r_gg4 + 'd2;

//==========  output  ========== //
assign out_vallid = cur_state[1];
assign out        = cur_state[1] ? {in_reg[counter][3],in_reg[counter][2],in_reg[counter][1],in_reg[counter][0]} : 'd0;

//==========  FSM  ========== //
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    cur_state <= IDLE;
  end 
  else begin
    if     (cal_start) cur_state <= CAL;
    else if(cal_done)  cur_state <= cur_state << 1;
    else if(out_done)  cur_state <= IDLE;
  end
end

//==========  DESIGN  ========== //
//counter
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     counter <= NUM_ROW - 1;
   end 
   else if(valid) begin
     counter <= counter - 'd1;
   end
   else if(cur_state[1]) begin
     counter <= counter - 'd1;
   end
end 

//in_reg col 0 
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    for(i=0;i<NUM_ROW;i=i+1) begin
      in_reg[i][0] <= 'd0;
    end
  end 
  else if(valid) begin
    in_reg[counter][0] <= $signed(in[12:0] );
  end
  else begin 
    if(enable_gg[0]) begin
      in_reg[row_index_gg1       ][0] <= (stall_gg[0] ? {out_m1_w[23],out_m1_w[21:10]} : out_gg1_X_w); //gg1
      in_reg[row_index_gg1_sub1  ][0] <= (stall_gg[0] ? {out_m2_w[23],out_m2_w[21:10]} : out_gg1_Y_w); //gg1
    end
  end
end

//in_reg col 1
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    for(i=0;i<NUM_ROW;i=i+1) begin
      in_reg[i][1] <= 'd0;
    end
  end 
  else if(valid) begin
    in_reg[counter][1] <= $signed(in[25:13] );
  end
  else begin
    if(enable_gg[1]) begin
      in_reg[row_index_gg2       ][1]  <=  (stall_gg[1] ? {out_m3_w[23],out_m3_w[21:10]} : out_gg2_X_w); //gg2
      in_reg[row_index_gg2_sub1  ][1]  <=  (stall_gg[1] ? {out_m4_w[23],out_m4_w[21:10]} : out_gg2_Y_w); //gg2
    end
    if(enable_d [0]) begin
      in_reg[row_index_gg1_d     ][1]  <=  (stall_d [0] ? {out_m1_w[23],out_m1_w[21:10]} : out_gr1_X_w); //gr1
      in_reg[row_index_gg1_sub1_d][1]  <=  (stall_d [0] ? {out_m2_w[23],out_m2_w[21:10]} : out_gr1_Y_w); //gr1
    end
  end
end

//in_reg col 2
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    for(i=0;i<NUM_ROW;i=i+1) begin
      in_reg[i][2] <= 'd0;
    end
  end 
  else if(valid) begin
    in_reg[counter][2] <= $signed(in[38:26] );
  end
  else begin
    if(enable_gg[2]) begin
      in_reg[row_index_gg3        ][2]  <= (stall_gg[2] ? {out_m3_w[23],out_m3_w[21:10]} : out_gg3_X_w); //gg3
      in_reg[row_index_gg3_sub1   ][2]  <= (stall_gg[2] ? {out_m4_w[23],out_m4_w[21:10]} : out_gg3_Y_w); //gg3 
    end
    if(enable_d [1]) begin
      in_reg[row_index_gg2_d      ][2]  <= (stall_d [1] ? {out_m3_w[23],out_m3_w[21:10]} : out_gr4_X_w); //gr4
      in_reg[row_index_gg2_sub1_d ][2]  <= (stall_d [1] ? {out_m4_w[23],out_m4_w[21:10]} : out_gr4_Y_w); //gr4
    end
    if(enable_d2[0]) begin
      in_reg[row_index_gg1_d2     ][2]  <= (stall_d2[0] ? {out_m1_w[23],out_m1_w[21:10]} : out_gr2_X_w); //gr2
      in_reg[row_index_gg1_sub1_d2][2]  <= (stall_d2[0] ? {out_m2_w[23],out_m2_w[21:10]} : out_gr2_Y_w); //gr2
    end
  end
end

//in_reg col 3
always @(posedge clk or posedge rst) begin 
  if(rst) begin
    for(i=0;i<NUM_ROW;i=i+1) begin
      in_reg[i][3] <= 'd0;
    end
  end 
  else if(valid) begin
    in_reg[counter][3] <= $signed(in[51:39] );
  end
  else begin
    if(enable_gg[3]) begin
      in_reg[row_index_gg4        ][3]  <= (stall_gg[3] ? {out_m1_w[23],out_m1_w[21:10]} : out_gg4_X_w); //gg4
      in_reg[row_index_gg4_sub1   ][3]  <= (stall_gg[3] ? {out_m2_w[23],out_m2_w[21:10]} : out_gg4_Y_w); //gg4
    end
    if(enable_d [2]) begin
      in_reg[row_index_gg3_d      ][3]  <= (stall_d [2] ? {out_m3_w[23],out_m3_w[21:10]} : out_gr6_X_w); //gr6
      in_reg[row_index_gg3_sub1_d ][3]  <= (stall_d [2] ? {out_m4_w[23],out_m4_w[21:10]} : out_gr6_Y_w); //gr6
    end
    if(enable_d2[1]) begin
      in_reg[row_index_gg2_d2     ][3]  <= (stall_d2[1] ? {out_m3_w[23],out_m3_w[21:10]} : out_gr5_X_w); //gr5
      in_reg[row_index_gg2_sub1_d2][3]  <= (stall_d2[1] ? {out_m4_w[23],out_m4_w[21:10]} : out_gr5_Y_w); //gr5
    end
    if(enable_d3   ) begin
      in_reg[row_index_gg1_d3     ][3]  <= (stall_d3    ? {out_m1_w[23],out_m1_w[21:10]} : out_gr3_X_w); //gr3
      in_reg[row_index_gg1_sub1_d3][3]  <= (stall_d3    ? {out_m2_w[23],out_m2_w[21:10]} : out_gr3_Y_w); //gr3
    end
  end
end

//stall_gg
always @(posedge clk or posedge rst) begin 
   if(rst)                     stall_gg    <=  4'b0000;
   else if(iter_num_r_gg1 == 'd6) stall_gg    <=  4'b0001;
   else if(iter_num_r_gg2 == 'd6) stall_gg    <=  4'b0010;
   else if(iter_num_r_gg3 == 'd6) stall_gg    <=  4'b0100;
   else if(iter_num_r_gg4 == 'd6) stall_gg    <=  4'b1000;
   else                           stall_gg    <=  4'b0000;
end 

//stall_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     stall_d <= 'd0;
   end 
   else begin
     stall_d <= stall_gg[2:0];
   end
end 

//stall_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     stall_d2 <= 'd0;
   end 
   else begin
     stall_d2 <= stall_d[1:0];
   end
end 

//stall_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     stall_d3 <= 'd0;
   end 
   else begin
     stall_d3 <= stall_d2[0];
   end
end

//enable_gg
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     enable_gg <= 'd0;
   end 
   else if(cal_start) begin
     enable_gg[0] <= 1;
   end
   else if(cur_state[0]) begin
     if     (row_index_gg1 == 'd5 && iter_num_r_gg1 == 'd0 && !stall_gg[0]) enable_gg[1] <= 1;
     else if(row_index_gg2 == 'd5 && iter_num_r_gg2 == 'd4                ) enable_gg[2] <= 1;
     else if(row_index_gg1 == 'd1 && stall_gg[0]) enable_gg    <= 4'b1110;
     else if(row_index_gg2 == 'd2 && stall_gg[1]) enable_gg[1] <= 0;
     else if(row_index_gg3 == 'd3 && stall_gg[2]) enable_gg[2] <= 0;
     else if(row_index_gg4 == 'd4 && stall_gg[3]) enable_gg[3] <= 0;
   end
end 

//enable_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     enable_d <= 'd0;
   end 
   else begin
     enable_d <= enable_gg[2:0];
   end
end 

//enable_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     enable_d2 <= 'd0;
   end 
   else begin
     enable_d2 <= enable_d[1:0];
   end
end 

//enable_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     enable_d3 <= 'd0;
   end 
   else begin
     enable_d3 <= enable_d2[0];
   end
end

//sign_gg_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {sign_gg1_d,sign_gg2_d,sign_gg3_d} <= 'd0;
   end 
   else begin
     {sign_gg1_d,sign_gg2_d,sign_gg3_d} <= {sign_gg1,sign_gg2,sign_gg3};
   end
end

//sign_gg_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {sign_gg1_d2,sign_gg2_d2} <= 'd0;
   end 
   else begin
     {sign_gg1_d2,sign_gg2_d2} <= {sign_gg1_d,sign_gg2_d};
   end
end

//sign_gg_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     sign_gg1_d3 <= 'd0;
   end 
   else begin
     sign_gg1_d3 <= sign_gg1_d2;
   end
end

//iter_num_r_gg1
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     iter_num_r_gg1 <= 'd0;
   end 
   else if(cur_state[0]) begin
     iter_num_r_gg1 <= enable_gg[0] ? (stall_gg[0] ? iter_num_r_gg1 : iter_num_r_gg1_add2) : 'd0;
   end
end 

//iter_num_r_gg2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     iter_num_r_gg2 <= 'd0;
   end 
   else if(cur_state[0]) begin
     iter_num_r_gg2 <= enable_gg[1] ? (stall_gg[1] ? iter_num_r_gg2 : iter_num_r_gg2_add2) : 'd0;
   end
end

//iter_num_r_gg3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     iter_num_r_gg3 <= 'd0;
   end 
   else if(cur_state[0]) begin
     iter_num_r_gg3 <= enable_gg[2] ? (stall_gg[2] ? iter_num_r_gg3 : iter_num_r_gg3_add2) : 'd0;
   end
end

//iter_num_r_gg4
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     iter_num_r_gg4 <= 'd0;
   end 
   else if(cur_state[0]) begin
     iter_num_r_gg4 <= enable_gg[3] ? (stall_gg[3] ? iter_num_r_gg4 : iter_num_r_gg4_add2) : 'd0;
   end
end

//iter_num_r_gg_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {iter_num_r_gg1_d,iter_num_r_gg2_d,iter_num_r_gg3_d} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {iter_num_r_gg1_d,iter_num_r_gg2_d,iter_num_r_gg3_d} <= {iter_num_r_gg1,iter_num_r_gg2,iter_num_r_gg3};
   end
end

//iter_num_r_gg_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {iter_num_r_gg1_d2,iter_num_r_gg2_d2} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {iter_num_r_gg1_d2,iter_num_r_gg2_d2} <= {iter_num_r_gg1_d,iter_num_r_gg2_d};
   end
end

//iter_num_r_gg_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     iter_num_r_gg1_d3 <= 'd0;
   end 
   else if(cur_state[0]) begin
     iter_num_r_gg1_d3 <= iter_num_r_gg1_d2;
   end
end

//row_index_gg1
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg1 <= 'd7;
   end 
   else if(stall_gg[0] & enable_gg[0]) begin
     row_index_gg1 <= row_index_gg1_sub1;
   end
end 

//row_index_gg2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg2 <= 'd7;
   end 
   else if(stall_gg[1] & enable_gg[1]) begin
     row_index_gg2 <= row_index_gg2_sub1;
   end
end 

//row_index_gg3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg3 <= 'd7;
   end 
   else if(stall_gg[2] & enable_gg[2]) begin
     row_index_gg3 <= row_index_gg3_sub1;
   end
end 

//row_index_gg4
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg4 <= 'd7;
   end 
   else if(stall_gg[3] & enable_gg[3]) begin
     row_index_gg4 <= row_index_gg4_sub1;
   end
end 

//row_index_gg_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {row_index_gg1_d,row_index_gg2_d,row_index_gg3_d} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {row_index_gg1_d,row_index_gg2_d,row_index_gg3_d} <= {row_index_gg1,row_index_gg2,row_index_gg3};
   end
end

//row_index_gg_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {row_index_gg1_d2,row_index_gg2_d2} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {row_index_gg1_d2,row_index_gg2_d2} <= {row_index_gg1_d,row_index_gg2_d};
   end
end

//row_index_gg_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg1_d3 <= 'd0;
   end 
   else if(cur_state[0]) begin
     row_index_gg1_d3 <= row_index_gg1_d2;
   end
end

//row_index_gg_sub1_d
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {row_index_gg1_sub1_d,row_index_gg2_sub1_d,row_index_gg3_sub1_d} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {row_index_gg1_sub1_d,row_index_gg2_sub1_d,row_index_gg3_sub1_d} <= {row_index_gg1_sub1,row_index_gg2_sub1,row_index_gg3_sub1};
   end
end

//row_index_gg_sub1_d2
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     {row_index_gg1_sub1_d2,row_index_gg2_sub1_d2} <= 'd0;
   end 
   else if(cur_state[0]) begin
     {row_index_gg1_sub1_d2,row_index_gg2_sub1_d2} <= {row_index_gg1_sub1_d,row_index_gg2_sub1_d};
   end
end

//row_index_gg_sub1_d3
always @(posedge clk or posedge rst) begin 
   if(rst) begin
     row_index_gg1_sub1_d3 <= 'd0;
   end 
   else if(cur_state[0]) begin
     row_index_gg1_sub1_d3 <= row_index_gg1_sub1_d2;
   end
end

// --------Module IO------------
//in_gg1_X_w in_gg2_X_w in_gg3_X_w in_gg4_X_w
//in_gg1_Y_w in_gg2_Y_w in_gg3_Y_w in_gg4_Y_w
always @(*) begin
  if(cur_state[0]) begin
    in_gg1_X_w = in_reg[row_index_gg1][0];
    in_gg2_X_w = in_reg[row_index_gg2][1];
    in_gg3_X_w = in_reg[row_index_gg3][2];
    in_gg4_X_w = in_reg[row_index_gg4][3];
    in_gg1_Y_w = in_reg[row_index_gg1_sub1][0];
    in_gg2_Y_w = in_reg[row_index_gg2_sub1][1];
    in_gg3_Y_w = in_reg[row_index_gg3_sub1][2];
    in_gg4_Y_w = in_reg[row_index_gg4_sub1][3];
  end
  else begin
    in_gg1_X_w = 'd0;
    in_gg2_X_w = 'd0;
    in_gg3_X_w = 'd0;
    in_gg4_X_w = 'd0;
    in_gg1_Y_w = 'd0;
    in_gg2_Y_w = 'd0;
    in_gg3_Y_w = 'd0;
    in_gg4_Y_w = 'd0;
  end
end

always @(*) begin
  if(cur_state[0]) begin
    in_gr1_X_w = in_reg[row_index_gg1_d ][1];
    in_gr2_X_w = in_reg[row_index_gg1_d2][2];
    in_gr3_X_w = in_reg[row_index_gg1_d3][3];
    in_gr4_X_w = in_reg[row_index_gg2_d ][2];
    in_gr5_X_w = in_reg[row_index_gg2_d2][3];
    in_gr6_X_w = in_reg[row_index_gg3_d ][3];
    in_gr1_Y_w = in_reg[row_index_gg1_sub1_d ][1];
    in_gr2_Y_w = in_reg[row_index_gg1_sub1_d2][2];
    in_gr3_Y_w = in_reg[row_index_gg1_sub1_d3][3];
    in_gr4_Y_w = in_reg[row_index_gg2_sub1_d ][2];
    in_gr5_Y_w = in_reg[row_index_gg2_sub1_d2][3];
    in_gr6_Y_w = in_reg[row_index_gg3_sub1_d ][3];
  end
  else begin
    in_gr1_X_w = 'd0;
    in_gr2_X_w = 'd0;
    in_gr3_X_w = 'd0;
    in_gr4_X_w = 'd0;
    in_gr5_X_w = 'd0;
    in_gr6_X_w = 'd0;
    in_gr1_Y_w = 'd0;
    in_gr2_Y_w = 'd0;
    in_gr3_Y_w = 'd0;
    in_gr4_Y_w = 'd0;
    in_gr5_Y_w = 'd0;
    in_gr6_Y_w = 'd0;
  end
end

//in_m1_w
always @(*) begin
  if     (stall_gg[0]) in_m1_w = in_reg[row_index_gg1   ][0];
  else if(stall_d [0]) in_m1_w = in_reg[row_index_gg1_d ][1];
  else if(stall_d2[0]) in_m1_w = in_reg[row_index_gg1_d2][2];
  else if(stall_d3[0]) in_m1_w = in_reg[row_index_gg1_d3][3];
  else if(stall_gg[3]) in_m1_w = in_reg[row_index_gg4   ][3];
  else                 in_m1_w = 'd0;
end

//in_m2_w
always @(*) begin
  if     (stall_gg[0]) in_m2_w = in_reg[row_index_gg1_sub1   ][0];
  else if(stall_d [0]) in_m2_w = in_reg[row_index_gg1_sub1_d ][1];
  else if(stall_d2[0]) in_m2_w = in_reg[row_index_gg1_sub1_d2][2];
  else if(stall_d3[0]) in_m2_w = in_reg[row_index_gg1_sub1_d3][3];
  else if(stall_gg[3]) in_m2_w = in_reg[row_index_gg4_sub1   ][3];
  else                 in_m2_w = 'd0;
end

//in_m3_w
always @(*) begin
  if     (stall_gg[1]) in_m3_w = in_reg[row_index_gg2   ][1];
  else if(stall_d [1]) in_m3_w = in_reg[row_index_gg2_d ][2];
  else if(stall_d2[1]) in_m3_w = in_reg[row_index_gg2_d2][3];
  else if(stall_gg[2]) in_m3_w = in_reg[row_index_gg3   ][2];
  else if(stall_d [2]) in_m3_w = in_reg[row_index_gg3_d ][3];
  else                 in_m3_w = 'd0;
end

//in_m4_w
always @(*) begin
  if     (stall_gg[1]) in_m4_w = in_reg[row_index_gg2_sub1   ][1];
  else if(stall_d [1]) in_m4_w = in_reg[row_index_gg2_sub1_d ][2];
  else if(stall_d2[1]) in_m4_w = in_reg[row_index_gg2_sub1_d2][3];
  else if(stall_gg[2]) in_m4_w = in_reg[row_index_gg3_sub1   ][2];
  else if(stall_d [2]) in_m4_w = in_reg[row_index_gg3_sub1_d ][3];
  else                 in_m4_w = 'd0;
end

//==========  Module  ==========//
// Module GG
    VECTOR_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GG1(
      .in_X     (in_gg1_X_w),
      .in_Y     (in_gg1_Y_w),
      .iter_num (iter_num_r_gg1),
      .sign_d   (sign_gg1),
      .out_X    (out_gg1_X_w),
      .out_Y    (out_gg1_Y_w)
    );
    VECTOR_MODE
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      ) 
    inst_GG2(
      .in_X     (in_gg2_X_w),
      .in_Y     (in_gg2_Y_w),
      .iter_num (iter_num_r_gg2),
      .sign_d   (sign_gg2),
      .out_X    (out_gg2_X_w),
      .out_Y    (out_gg2_Y_w)
    );
    VECTOR_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GG3(
      .in_X     (in_gg3_X_w),
      .in_Y     (in_gg3_Y_w),
      .iter_num (iter_num_r_gg3),
      .sign_d   (sign_gg3),
      .out_X    (out_gg3_X_w),
      .out_Y    (out_gg3_Y_w)
    );
    VECTOR_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GG4(
      .in_X     (in_gg4_X_w),
      .in_Y     (in_gg4_Y_w),
      .iter_num (iter_num_r_gg4),
      .sign_d   (sign_gg4),
      .out_X    (out_gg4_X_w),
      .out_Y    (out_gg4_Y_w)
    );

  //Module GR
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR1(
      .in_X     (in_gr1_X_w),
      .in_Y     (in_gr1_Y_w),
      .iter_num (iter_num_r_gg1_d),
      .sign_d   (sign_gg1_d),
      .out_X    (out_gr1_X_w),
      .out_Y    (out_gr1_Y_w)
    );
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR2(
      .in_X     (in_gr2_X_w),
      .in_Y     (in_gr2_Y_w),
      .iter_num (iter_num_r_gg1_d2),
      .sign_d   (sign_gg1_d2),
      .out_X    (out_gr2_X_w),
      .out_Y    (out_gr2_Y_w)
    );
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR3(
      .in_X     (in_gr3_X_w),
      .in_Y     (in_gr3_Y_w),
      .iter_num (iter_num_r_gg1_d3),
      .sign_d   (sign_gg1_d3),
      .out_X    (out_gr3_X_w),
      .out_Y    (out_gr3_Y_w)
    );
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR4(
      .in_X     (in_gr4_X_w),
      .in_Y     (in_gr4_Y_w),
      .iter_num (iter_num_r_gg2_d),
      .sign_d   (sign_gg2_d),
      .out_X    (out_gr4_X_w),
      .out_Y    (out_gr4_Y_w)
    );
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR5(
      .in_X     (in_gr5_X_w),
      .in_Y     (in_gr5_Y_w),
      .iter_num (iter_num_r_gg2_d2),
      .sign_d   (sign_gg2_d2),
      .out_X    (out_gr5_X_w),
      .out_Y    (out_gr5_Y_w)
    );
    ROTATION_MODE 
    #(
      .DATA_LENGTH(DATA_LENGTH),
      .ITER_IDX(ITER_IDX),
      .NUM_SIGN(NUM_SIGN)
      )
    inst_GR6(
      .in_X     (in_gr6_X_w),
      .in_Y     (in_gr6_Y_w),
      .iter_num (iter_num_r_gg3_d),
      .sign_d   (sign_gg3_d),
      .out_X    (out_gr6_X_w),
      .out_Y    (out_gr6_Y_w)
    );


endmodule

