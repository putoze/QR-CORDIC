module ROTATION_MODE
   #(
      DATA_LENGTH = 13,
      ITER_IDX    = 3 ,
      NUM_SIGN    = 2
      )
   (in_X,in_Y,iter_num,sign_d,out_X,out_Y);

  input signed  [DATA_LENGTH-1:0]  in_X;
  input signed  [DATA_LENGTH-1:0]  in_Y;
  input         [ITER_IDX-1:0] iter_num;
  input         [NUM_SIGN-1:0]   sign_d;
  output signed [DATA_LENGTH-1:0] out_X;
  output signed [DATA_LENGTH-1:0] out_Y;

wire [ITER_IDX-1:0] iter_num_add1 = iter_num + 'd1;

wire signed [12:0] cal_X_temp_w = sign_d[0] ? in_X  + (in_Y >>> iter_num) : in_X  - (in_Y >>> iter_num);
wire signed [12:0] cal_Y_temp_w = sign_d[0] ? in_Y  - (in_X >>> iter_num) : in_Y  + (in_X >>> iter_num);

assign out_X = sign_d[1] ? cal_X_temp_w  + (cal_Y_temp_w >>> iter_num_add1) : cal_X_temp_w  - (cal_Y_temp_w >>> iter_num_add1);
assign out_Y = sign_d[1] ? cal_Y_temp_w  - (cal_X_temp_w >>> iter_num_add1) : cal_Y_temp_w  + (cal_X_temp_w >>> iter_num_add1);

endmodule
