`timescale 1ns/10ps
`define CYCLE      10.0          	  // Modify your clock period here
`define SDFFILE    "../SYN/DT_syn.sdf"	  // Modify your sdf file name
`define End_CYCLE  100000000             // Modify cycle times once your design need more cycle times!
`define TB1

`ifdef TB1
	`define ORI        "D:/QR_CORDIC/RTL_old/QR_CORDIC/matrix_ori.txt"
	`define EXP        "D:/QR_CORDIC/RTL_old/QR_CORDIC/matrix_exp.txt"
`endif

module tb;

  parameter length = 13;
  parameter N_PAT = 32;

  reg  signed  [length-1:0]   exp  [0:N_PAT];
  initial
    $readmemb (`EXP, exp);

`ifdef SDF

  initial
    $sdf_annotate(`SDFFILE, u_dut);
`endif

  wire                 done;
  wire  signed  [length-1:0] ori_di;
  wire           [4:0] ori_addr;
  wire                 ori_rd;
  wire  signed [length-1:0]  matr_di;
  wire  signed [length-1:0]  matr_do;
  wire         [4:0]   matr_rd_addr;
  wire         [4:0]   matr_wr_addr;
  wire                 matr_wr;
  wire                 matr_rd;

  integer		i, fw_err, bc_err;

  reg	 pass_chk;
  reg	signed [length-1:0]	exp_pat, rel_pat;
  reg  start=0;
  reg  [8:0] counter=0;
  reg		clk = 0;
  reg		reset;


  QR_CORDIC qr(		.clk( clk ), .reset( reset ),
                 .done( done ),
                 .ori_di( ori_di ),
                 .ori_addr( ori_addr ),
                 .ori_rd( ori_rd ),
                 .matr_di( matr_di ),
                 .matr_do( matr_do ),
                 .matr_rd_addr( matr_rd_addr),
                 .matr_wr_addr(matr_wr_addr),
                 .matr_wr( matr_wr ),
                 .matr_rd( matr_rd ) );

  ori_ROM  u_ori_ROM(.ori_rd(ori_rd), .ori_data(ori_di), .ori_addr(ori_addr), .clk(clk), .reset(reset));
  matr_RAM  u_matr_RAM(.matr_rd(matr_rd), .matr_wr(matr_wr), .matr_rd_addr(matr_rd_addr), .matr_wr_addr(matr_wr_addr), .matr_datain(matr_do), .matr_dataout(matr_di), .clk(clk));


  always
  begin
    #(`CYCLE/2) clk = ~clk;
  end
  /*
          initial
          begin
  `ifdef FSDB
            $fsdbDumpfile("DT.fsdb");
            $fsdbDumpvars;
            $fsdbDumpMDA(u_sti_ROM.sti_M);
            $fsdbDumpMDA(u_res_RAM.res_M);
            `elsif VCD
                   $dumpfile("DT.vcd");
            $dumpvars;
  `endif
          end
          */

  initial
  begin  // data input
    $display("-----------------------------------------------------\n");
    $display("START!!! Simulation Start .....\n");
    $display("-----------------------------------------------------\n");
    #1;
    reset = 1'b1;
    @(negedge clk) #1;
    reset = 1'b0;
    #(`CYCLE*3);
    @(negedge clk) #1;
    reset = 1'b1;
  end

  initial
  begin
    #(`End_CYCLE);
    $display("-----------------------------------------------------\n");
    $display("Error!!! There is something wrong with your code ...!\n");
    $display("------The test result is .....FAIL ------------------\n");
    $display("-----------------------------------------------------\n");
    $finish;
  end

  integer f;
/*
  initial
  begin
    f = $fopen("D:/QR_CORDIC/output.txt","w");
  end
  initial
  begin
    wait( done ) ;
    for (i = 0; i < N_PAT ;i=i+1 )
    begin
      $fwrite(f,"%b\n",u_matr_RAM.matr_M[i]);
    end
  end
  initial
  begin
    wait( done ) ;
    $fclose(f);
  end
*/
  initial begin
    wait( done ) ;
    for (i=0; i <N_PAT ; i=i+1)
    begin
      $display("%f",u_matr_RAM.matr_M[i]);
    end
  end


  initial
  begin // PASS result compare
    pass_chk = 0;
    #(`CYCLE*3);
    start = 1;
    wait( done ) ;
    pass_chk = 1;
    bc_err = 0;
    for (i=0; i <N_PAT ; i=i+1)
    begin
      exp_pat = exp[i];
      rel_pat = u_matr_RAM.matr_M[i];
      if (exp_pat == rel_pat)
      begin
        bc_err = bc_err;
      end
      else
      begin
        bc_err = bc_err+1;
        if (bc_err <= 30)
          $display(" Output pixel %d are wrong!the real output is %f, but expected result is %f", i, rel_pat, exp_pat);
        if (bc_err == 31)
        begin
          $display(" Find the wrong pixel reached a total of more than 30 !, Please check the code .....\n");
        end
      end
      if(i == 31)
      begin
        if ( bc_err === 0)
          $display(" Output pixel: 0 ~ %d are correct!\n", i);
        else
          $display(" Output Pixel: 0 ~ %d are wrong ! The wrong pixel reached a total of %d or more ! \n", i, bc_err);

      end

    end
  end

  initial
  begin
    @(posedge pass_chk)  #1;
    if( bc_err == 0 )
    begin
      $display("-------------------------------------------------------------\n");
      $display("Congratulations!!! All data have been generated successfully!\n");
      $display("---------- The test result is ..... PASS --------------------\n");
      $display("---------- The calculation time is ..... %d --------------------\n",counter);
      $display("                                                     \n");
    end
    else
    begin
      //$display("FAIL! There are %d errors at forward-pass run!\n", fw_err);
      $display("FAIL! There are %d errors at functional simulation !\n", bc_err);
      $display("---------- The test result is .....FAIL -------------\n");
      $display("---------- The calculation time is ..... %d --------------------\n",counter);
    end
    $display("-----------------------------------------------------\n");
    #(`CYCLE/3);
    $finish;
  end

  always @(posedge clk) begin
    if(start) begin
      counter <= counter + 'd1;
    end
  end

endmodule



//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
module ori_ROM (ori_rd, ori_data, ori_addr, clk, reset);
  parameter length = 13;
  input		ori_rd;
  input	[4:0] 	ori_addr;
  output signed	[length-1:0]	ori_data;
  input		clk, reset;

  reg signed [length-1:0] ori_M [0:31];
  integer i;
  integer data_file;

  reg	signed [length-1:0]	ori_data;

  /*
  initial
  begin
    data_file = $fopen("D:/QR_CORDIC/matrix_ori.txt","r");
    for(i=0;i<32;i=i+1)
    begin
      $fscanf(data_file,"%f",ori_M[i]);
    end
    $fclose(data_file);
  end
  */
  initial
  begin
    @ (negedge reset) $readmemb (`ORI , ori_M);
  end

  always@(negedge clk)
    if (ori_rd)
      ori_data <= ori_M[ori_addr];

endmodule



//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
module matr_RAM (matr_rd, matr_wr, matr_rd_addr, matr_wr_addr ,matr_datain, matr_dataout, clk);
  parameter length = 13;
  input		matr_rd, matr_wr;
  input	[4:0] 	matr_rd_addr;
  input [4:0]   matr_wr_addr;
  input signed	[length-1:0]	matr_datain;
  output signed	[length-1:0]	matr_dataout;
  input		clk;

  reg signed [length-1:0] matr_M [0:31];

  integer i;

  initial
    for(i=0;i<=31;i=i+1)
      matr_M[i] = 13'd0;

  reg signed [length-1:0] matr_dataout;
  always@(negedge clk)   // read data at negedge clock
    if (matr_rd)
      matr_dataout <= matr_M[matr_rd_addr];

  always@(negedge clk)   // write data at negedge clock
    if (matr_wr)
      matr_M[matr_wr_addr] <= matr_datain;

endmodule
