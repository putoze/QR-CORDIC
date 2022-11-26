module ROTATION_MODE
  #(parameter K = 10'b1001101110)
   (ori_X,ori_Y,start,reset,clk,rot_X,rot_Y,sign_d,done);

  input signed [12:0] ori_X;
  input signed [12:0] ori_Y;
  input start;
  input reset;
  input clk;
  output signed [12:0] rot_X;
  output signed [12:0] rot_Y;
  input [7:0] sign_d;
  output done;

  localparam  IDLE = 2'd0;
  localparam  EXE = 2'd1;
  localparam  DONE = 2'd2;

  reg [2:0] iter_reg;
  reg signed [12:0] cal_X_reg;
  reg signed [12:0] cal_Y_reg;
  reg [7:0] sign_d_reg;
  reg [1:0] current_state,next_state;
  reg signed [13:0] rot_X_temp;
  reg signed [13:0] rot_Y_temp;
  reg signed [13:0] cal_X_temp_wire;
  reg signed [13:0] cal_Y_temp_wire;

  wire state_IDLE = current_state == IDLE;
  wire state_EXE = current_state == EXE;
  wire state_DONE = current_state == DONE;
  wire [2:0] iter_temp_wire = state_EXE ? iter_reg + 'd1 : 'd0;
  wire exe_done_flag = iter_reg == 'd6;
  wire signed [24:0] rot_X_temp_wire =  cal_X_reg*$signed({1'b0,K}) ;
  wire signed [24:0] rot_Y_temp_wire =  cal_Y_reg*$signed({1'b0,K}) ;
  wire signed [12:0] cal_X_trac_wire = {cal_X_temp_wire[13],cal_X_temp_wire[11:0]};
  wire signed [12:0] cal_Y_trac_wire = {cal_Y_temp_wire[13],cal_Y_temp_wire[11:0]};


  //output
  assign done = state_DONE;
  assign rot_X = state_DONE ? {rot_X_temp_wire[24],rot_X_temp_wire[21:10]} : 'd0;
  assign rot_Y = state_DONE ? {rot_Y_temp_wire[24],rot_Y_temp_wire[21:10]} : 'd0;


  always @(posedge clk or negedge reset)
  begin
    current_state <= !reset ? IDLE : next_state;
  end

  always @(*)
  begin
    case(current_state)
      IDLE:
        next_state = start ? EXE : IDLE;
      EXE:
        next_state = exe_done_flag ? DONE : EXE;
      DONE:
        next_state = IDLE;
      default :
        next_state = IDLE;
    endcase
  end

  //cal_X_reg + cal_Y_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      cal_X_reg <= 'd0;
      cal_Y_reg <= 'd0;
    end
    else
    begin
      case (current_state)
        IDLE:
        begin
          cal_X_reg <= ori_X;
          cal_Y_reg <= ori_Y;
        end
        EXE:
        begin
          cal_X_reg <= {rot_X_temp[13],rot_X_temp[11:0]};
          cal_Y_reg <= {rot_Y_temp[13],rot_Y_temp[11:0]};
        end
        default:
        begin
          cal_X_reg <= 'd0;
          cal_Y_reg <= 'd0;
        end
      endcase
    end
  end

  //iter_reg
  always@(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      iter_reg <= 'd0;
    end
    else
    begin
      iter_reg <= state_EXE ? iter_reg + 'd2 : 'd0;
    end
  end

  //sign_d_reg
  always@(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      sign_d_reg <= 'd0;
    end
    else
    begin
      sign_d_reg <= state_IDLE ? sign_d : sign_d_reg;
    end
  end

  //cal_X_temp_wire
  always@(*)
  begin
    if(state_EXE)
    begin
      case (iter_reg)
        'd0:
          cal_X_temp_wire = sign_d_reg[0] ? cal_X_reg - cal_Y_reg : cal_X_reg + cal_Y_reg;
        'd2:
          cal_X_temp_wire = sign_d_reg[2] ? cal_X_reg - (cal_Y_reg >>> 2) : cal_X_reg + (cal_Y_reg >>> 2);
        'd4:
          cal_X_temp_wire = sign_d_reg[4] ? cal_X_reg - (cal_Y_reg >>> 4) : cal_X_reg + (cal_Y_reg >>> 4);
        'd6:
          cal_X_temp_wire = sign_d_reg[6] ? cal_X_reg - (cal_Y_reg >>> 6) : cal_X_reg + (cal_Y_reg >>> 6);
        default:
          cal_X_temp_wire = 'd0;
      endcase
    end
    else
    begin
      cal_X_temp_wire = 'd0;
    end
  end

  //cal_Y_temp_wire
  always@(*)
  begin
    if(state_EXE)
    begin
      case (iter_reg)
        'd0:
          cal_Y_temp_wire = sign_d_reg[0] ? cal_Y_reg + cal_X_reg : cal_Y_reg - cal_X_reg;
        'd2:
          cal_Y_temp_wire = sign_d_reg[2] ? cal_Y_reg + (cal_X_reg >>> 2) : cal_Y_reg - (cal_X_reg >>> 2);
        'd4:
          cal_Y_temp_wire = sign_d_reg[4] ? cal_Y_reg + (cal_X_reg >>> 4) : cal_Y_reg - (cal_X_reg >>> 4);
        'd6:
          cal_Y_temp_wire = sign_d_reg[6] ? cal_Y_reg + (cal_X_reg >>> 6) : cal_Y_reg - (cal_X_reg >>> 6);
        default:
          cal_Y_temp_wire = 'd0;
      endcase
    end
    else
    begin
      cal_Y_temp_wire = 'd0;
    end
  end

  //rot_X_temp
  always@(*)
  begin
    if(state_EXE)
    begin
      case (iter_temp_wire)
        'd1:
          rot_X_temp = sign_d_reg[1] ? cal_X_trac_wire - (cal_Y_trac_wire >>> 1) : cal_X_trac_wire + (cal_Y_trac_wire >>> 1);
        'd3:
          rot_X_temp = sign_d_reg[3] ? cal_X_trac_wire - (cal_Y_trac_wire >>> 3) : cal_X_trac_wire + (cal_Y_trac_wire >>> 3);
        'd5:
          rot_X_temp = sign_d_reg[5] ? cal_X_trac_wire - (cal_Y_trac_wire >>> 5) : cal_X_trac_wire + (cal_Y_trac_wire >>> 5);
        'd7:
          rot_X_temp = sign_d_reg[7] ? cal_X_trac_wire - (cal_Y_trac_wire >>> 7) : cal_X_trac_wire + (cal_Y_trac_wire >>> 7);
        default:
          rot_X_temp = 'd0;
      endcase
    end
    else
    begin
      rot_X_temp = 'd0;
    end
  end


  //rot_Y_temp
  always@(*)
  begin
    if(state_EXE)
    begin
      case (iter_temp_wire)
        'd1:
          rot_Y_temp = sign_d_reg[1] ? cal_Y_trac_wire + (cal_X_trac_wire >>> 1) : cal_Y_trac_wire- (cal_X_trac_wire >>> 1);
        'd3:
          rot_Y_temp = sign_d_reg[3] ? cal_Y_trac_wire + (cal_X_trac_wire >>> 3) : cal_Y_trac_wire - (cal_X_trac_wire >>> 3);
        'd5:
          rot_Y_temp = sign_d_reg[5] ? cal_Y_trac_wire + (cal_X_trac_wire >>> 5) : cal_Y_trac_wire - (cal_X_trac_wire >>> 5);
        'd7:
          rot_Y_temp = sign_d_reg[7] ? cal_Y_trac_wire + (cal_X_trac_wire >>> 7) : cal_Y_trac_wire - (cal_X_trac_wire >>> 7);
        default:
          rot_Y_temp = 'd0;
      endcase
    end
    else
    begin
      rot_Y_temp = 'd0;
    end
  end

endmodule
