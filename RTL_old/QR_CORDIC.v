module QR_CORDIC
  (
    input                   clk,
    input                   reset,
    output                  done,
    input    signed  [12:0] ori_di,
    output   reg      [4:0] ori_addr,
    output   reg            ori_rd,
    input    signed [12:0]  matr_di,
    output   signed [12:0]  matr_do,
    output   reg    [4:0]   matr_rd_addr,
    output   reg    [4:0]   matr_wr_addr,
    output   reg            matr_wr,
    output   reg            matr_rd
  );

  parameter   K = 10'b1001101110;
  localparam  IDLE = 'b000001;
  localparam  VEC_PRO = 'b000010;
  localparam  VEC = 'b000100;
  localparam  ROT_PRO = 'b001000;
  localparam  ROT = 'b010000;
  localparam  DONE = 'b100000;

  reg [5:0] current_state,next_state;
  reg [2:0] counter_vec_reg;
  reg [1:0] col_index_reg;
  reg [1:0] rot_col_index_reg;
  reg delay_reg;
  reg signed [12:0] ori_X_reg;
  reg signed [12:0] ori_Y_reg;
  reg [7:0] sign_d_reg;
  reg change_col_flag;

  //state
  wire IDLE_state = current_state[0];
  wire VEC_PRO_state = current_state[1];
  wire VEC_state = current_state[2];
  wire ROT_PRO_state = current_state[3];
  wire ROT_state = current_state[4];
  wire DONE_state = current_state[5];

  //flag
  wire vec_pro_done = VEC_PRO_state & delay_reg;
  wire vec_done;
  wire rot_pro_done = ROT_PRO_state & delay_reg;
  wire rot_done;
  wire vec_pro_start = rot_col_index_reg == 'd3 && rot_done == 1 ;
  wire first_vec_pro = counter_vec_reg == 'd6 && col_index_reg == 'd0 ;

  wire only_vec_flag = rot_col_index_reg == 'd0 ;

  wire [2:0] counter_vec_wire = counter_vec_reg + 'd1;
  wire [2:0] col_temp = col_index_reg + 'd1;
  wire signed [12:0] ori_X_wire = ori_X_reg;
  wire signed [12:0] ori_Y_wire = ori_Y_reg;
  wire [7:0] sign_d;
  wire [7:0] sign_d_in = sign_d_reg;
  wire signed [12:0] rot_X_vec;
  wire signed [12:0] rot_Y_vec;
  wire signed [12:0] rot_X_rot;
  wire signed [12:0] rot_Y_rot;

  VECTOR_MODE #(.K(K))
              vec (.ori_X(ori_X_wire),.ori_Y(ori_Y_wire),.start(VEC_state),.reset(reset),.clk(clk),.rot_X(rot_X_vec),.rot_Y(rot_Y_vec),.sign_d(sign_d),.done(vec_done));
  ROTATION_MODE #(.K(K))
                rot (.ori_X(ori_X_wire),.ori_Y(ori_Y_wire),.start(ROT_state),.reset(reset),.clk(clk),.rot_X(rot_X_rot),.rot_Y(rot_Y_rot),.sign_d(sign_d_in),.done(rot_done));

  //current_state
  always @(posedge clk or negedge reset)
  begin
    current_state <= !reset ? IDLE : next_state;
  end

  //next_state
  always @(*)
  begin
    case(current_state)
      IDLE:
        next_state = VEC_PRO;
      VEC_PRO :
        next_state = vec_pro_done ? VEC : VEC_PRO;
      VEC :
        next_state = done ? DONE : vec_done ? only_vec_flag ? VEC_PRO : ROT_PRO : VEC;
      ROT_PRO:
        next_state = rot_pro_done ? ROT : ROT_PRO;
      ROT:
        next_state = rot_done ? vec_pro_start ? VEC_PRO : ROT_PRO : ROT;
      DONE:
        next_state = IDLE;
      default :
        next_state = IDLE;
    endcase
  end

  //change_col_flag
  always @(*)
  begin
    case (col_index_reg)
      'd0:
        change_col_flag = vec_pro_start ? counter_vec_reg == 'd0 : 'd0 ;
      'd1:
        change_col_flag = vec_pro_start ? counter_vec_reg == 'd1 : 'd0 ;
      'd2:
        change_col_flag = vec_pro_start ? counter_vec_reg == 'd2 : 'd0 ;
      'd3:
        change_col_flag = vec_pro_start ? counter_vec_reg == 'd3 : 'd0 ;
      default:
        change_col_flag = 0;
    endcase
  end

  //matr_do
assign matr_do = matr_wr ? delay_reg ? ori_Y_reg : ori_X_reg : 'd0;

  //done
  assign done = vec_done & (counter_vec_reg == 'd1 && col_index_reg == 'd3);

  //matr_rd
  always @(*)
  begin
    if(col_index_reg=='d0)
    begin
      if(counter_vec_reg != 'd6)
      begin
        matr_rd = vec_pro_done | rot_pro_done;
      end
      else
      begin
        matr_rd = 0;
      end
    end
    else
    begin
      matr_rd = VEC_PRO_state | ROT_PRO_state;
    end
  end

  //matr_wr
  always @(*)
  begin
    if(VEC_PRO_state)
    begin
      matr_wr = first_vec_pro ? 0 : 1;
    end
    else
    begin
      matr_wr = ROT_PRO_state;
    end
  end

  //ori_rd
  always @(*)
  begin
    if(col_index_reg=='d0)
    begin
      if(counter_vec_reg == 'd6)
      begin
        ori_rd = VEC_PRO_state | ROT_PRO_state;
      end
      else
      begin
        ori_rd = (VEC_PRO_state & !delay_reg) | (ROT_PRO_state & !delay_reg);
      end
    end
    else
    begin
      ori_rd = 0;
    end
  end

  //delay_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      delay_reg <= 0;
    end
    else if(vec_pro_done | rot_pro_done)
    begin
      delay_reg <= 0 ;
    end
    else
    begin
      delay_reg <= VEC_PRO_state | ROT_PRO_state ;
    end
  end

  //sign_d_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      sign_d_reg <= 'd0;
    end
    else
    begin
      sign_d_reg <= vec_done ? sign_d : sign_d_reg;
    end
  end

  //ori_X_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      ori_X_reg <= 'd0;
    end
    else
    begin
      if(ROT_PRO_state | VEC_PRO_state)
      begin
        if(matr_rd)
        begin
          ori_X_reg <= delay_reg ? ori_X_reg : matr_di ;
        end
        else if(ori_rd)
        begin
          ori_X_reg <= delay_reg ? ori_X_reg : ori_di ;
        end
        else
        begin
          ori_X_reg <= ori_X_reg;
        end
      end
      else if(vec_done)
      begin
        ori_X_reg <= rot_X_vec;
      end
      else if(rot_done)
      begin
        ori_X_reg <= rot_X_rot;
      end
      else
      begin
        ori_X_reg <= ori_X_reg;
      end
    end
  end

  // ori_Y_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      ori_Y_reg <= 'd0;
    end
    else
    begin
      if(ROT_PRO_state | VEC_PRO_state)
      begin
        if(matr_rd)
        begin
          ori_Y_reg <= delay_reg ? matr_di : ori_Y_reg;
        end
        else if(ori_rd)
        begin
          ori_Y_reg <= delay_reg ?  ori_di : ori_Y_reg;
        end
        else
        begin
          ori_Y_reg <= ori_Y_reg;
        end
      end
      else if(vec_done)
      begin
        ori_Y_reg <= rot_Y_vec;
      end
      else if(rot_done)
      begin
        ori_Y_reg <= rot_Y_rot;
      end
      else
      begin
        ori_Y_reg <= ori_Y_reg;
      end
    end
  end


  //counter_vec_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      counter_vec_reg <= 'd6;
    end
    else
    begin
      if(change_col_flag)
      begin
        counter_vec_reg <= 'd6;
      end
      else if(vec_done & only_vec_flag)
      begin
        counter_vec_reg <= counter_vec_reg - 'd1;
      end
      else
      begin
        counter_vec_reg <= vec_pro_start ? counter_vec_reg - 'd1 : counter_vec_reg;
      end
    end
  end


  //rot_col_index_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      rot_col_index_reg <= 'd1;
    end
    else
    begin
      if(change_col_flag)
      begin
        rot_col_index_reg <= col_temp + 'd1 ;
      end
      else if(vec_pro_start)
      begin
        rot_col_index_reg <= col_temp;
      end
      else if(rot_done)
      begin
        rot_col_index_reg <= rot_col_index_reg + 'd1 ;
      end
      else
      begin
        rot_col_index_reg <= rot_col_index_reg;
      end
    end
  end

  //col_index_reg
  always @(posedge clk or negedge reset)
  begin
    if(!reset)
    begin
      col_index_reg <= 'd0;
    end
    else
    begin
      col_index_reg <= change_col_flag ? col_temp : col_index_reg;
    end
  end


  //ori_addr
  always @(*)
  begin
    case (current_state)
      VEC_PRO:
      begin
        ori_addr[4:3] = col_index_reg;
        ori_addr[2:0] = vec_pro_done ? counter_vec_wire : counter_vec_reg;
      end
      ROT_PRO:
      begin
        ori_addr[4:3] = rot_col_index_reg;
        ori_addr[2:0] = rot_pro_done ? counter_vec_wire : counter_vec_reg;
      end
      default:
        ori_addr = 'd0;
    endcase
  end

  //matr_wr_addr
  always @(*)
  begin
    case (current_state)
      VEC_PRO:
      begin
        matr_wr_addr[4:3] = first_vec_pro ? 'd0 : 'd3;
        if(counter_vec_reg == 'd6)
        begin
          matr_wr_addr[2:0] = vec_pro_done ? col_index_reg : col_index_reg - 'd1;
        end
        else
        begin
          matr_wr_addr[2:0] = vec_pro_done ? counter_vec_wire + 'd1: counter_vec_reg + 'd1;
        end
      end
      ROT_PRO:
      begin
        matr_wr_addr[4:3] = rot_col_index_reg - 'd1;
        matr_wr_addr[2:0] = rot_pro_done ? counter_vec_wire : counter_vec_reg;
      end
      default:
        matr_wr_addr = 'd0;
    endcase
  end

  //matr_rd_addr
  always @(*)
  begin
    case (current_state)
      VEC_PRO:
      begin
        matr_rd_addr[4:3] = col_index_reg;
        matr_rd_addr[2:0] = vec_pro_done ? counter_vec_wire : counter_vec_reg ;
      end
      ROT_PRO:
      begin
        matr_rd_addr[4:3] = rot_col_index_reg;
        matr_rd_addr[2:0] = rot_pro_done ? counter_vec_wire : counter_vec_reg  ;
      end
      default:
        matr_rd_addr = 'd0;
    endcase
  end


endmodule
