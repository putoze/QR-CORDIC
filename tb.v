`timescale 1ns/10ps
`define CYCLE      10.0             // Modify your clock period here
`define SDFFILE    "Netlist/QR_CORDIC_SYN.sdf"    // Modify your sdf file name
`define End_CYCLE  10000000             // Modify cycle times once your design need more cycle times!

`define ORI        "D:/QR_CORDIC/TESBED/matrix_ori.txt"
`define EXP        "D:/QR_CORDIC/TESBED/matrix_exp.txt"

`ifdef RTL
  `include "QR_CORDIC.v"
`endif

`ifdef GATE
  `include "./Netlist/QR_CORDIC_SYN.v"
`endif

  /*
  `ifdef FSDB
     $fsdbDumpfile("DT.fsdb");
     $fsdbDumpvars;
     $fsdbDumpMDA(u_sti_ROM.sti_M);
     $fsdbDumpMDA(u_res_RAM.res_M);
     `elsif VCD
            $dumpfile("DT.vcd");
     $dumpvars;
  `endif
  */

module tb;

  parameter LENGTH = 13;
  parameter BUS = 4;
  parameter N_PAT = 32;

  reg  [LENGTH-1:0]   exp  [0:N_PAT-1];
  reg  [LENGTH-1:0]   ori  [0:N_PAT-1];

  reg                 valid;
  wire                out_vallid;
  reg  [51:0]         in;
  wire [51:0]         out;

  integer   i,f,s;

  reg  pass_chk,start;
  reg  [8:0] count;

  reg   clk = 0;
  reg   rst_n;

initial begin
  `ifdef GATE
      $sdf_annotate(`SDFFILE, inst_QR_CORDIC);
  `endif
end

  QR_CORDIC
  #(
    .DATA_LENGTH(LENGTH)
    ) 
  inst_QR_CORDIC (
      .clk        (clk),
      .rst_n      (rst_n),
      .valid      (valid),
      .out_vallid (out_vallid),
      .in         (in),
      .out        (out)
    );

  always
  begin
    #(`CYCLE/2) clk = ~clk;
  end

  initial
  begin  // data input
    //s=$fscanf (`ORI,"%f",number);
    $readmemb (`EXP, exp);
    $readmemb (`ORI, ori);
    $display("-----------------------------------------------------\n");
    $display("START!!! Simulation Start .....\n");
    $display("Your input matrix is : \n");
    for(i=8;i>0;i=i-1) begin
      $display("%13f %13f %13f %13f",$signed(ori[4*i-4]),$signed(ori[4*i-3]),$signed(ori[4*i-2]),$signed(ori[4*i-1]));
    end
    $display("-----------------------------------------------------\n");
    rst_n = 1'b0;
    valid = 0;
    count = 'd0;
    pass_chk = 0;
    start = 0;
    //f = $fopen("D:/QR_CORDIC/output.txt","w");
    #(`CYCLE*3);
    @(negedge clk) #1;
      rst_n = 1'b1;
    // data input
    for(i=0;i<9;i=i+1) begin
      @(negedge clk)
        valid = 1;
        in = {ori[4*i+3],ori[4*i+2],ori[4*i+1],ori[4*i]} ;
    end
    start = 1;
    valid = 0;
    //check if out right
    wait(out_vallid)
    pass_chk = 1;
    start = 0;
    for(i=8;i>0;i=i-1) begin
      @(negedge clk) begin
          $display("Your matrix[%1d][0] is %8d, expect matrix[%1d][0] is %8d",i,$signed(out[12:0] ),i,$signed(exp[4*(8-i)+0]));
          $display("Your matrix[%1d][1] is %8d, expect matrix[%1d][1] is %8d",i,$signed(out[25:13]),i,$signed(exp[4*(8-i)+1]));
          $display("Your matrix[%1d][2] is %8d, expect matrix[%1d][2] is %8d",i,$signed(out[38:26]),i,$signed(exp[4*(8-i)+2]));
          $display("Your matrix[%1d][3] is %8d, expect matrix[%1d][3] is %8d",i,$signed(out[51:39]),i,$signed(exp[4*(8-i)+3]));
          $display("------------------------------------------------------");
          if(out != {exp[4*(8-i)+3],exp[4*(8-i)+2],exp[4*(8-i)+1],exp[4*(8-i)+0]}) begin
            pass_chk = 0;
            fail_task;
          end
          //$fwrite(f,"%b\n",out[12:0] );
          //$fwrite(f,"%b\n",out[25:13]);
          //$fwrite(f,"%b\n",out[38:26]);
          //$fwrite(f,"%b\n",out[51:39]);
      end
    end
    if(pass_chk) begin
        $display("\n---------------------Congratulations!------------------------");
        $display("------------- The test result is ..... PASS -----------------\n");
        $display("Your output matrix is : \n");
        for(i=8;i>0;i=i-1) begin
          $display("%13f %13f %13f %13f",$signed(exp[4*i-4]),$signed(exp[4*i-3]),$signed(exp[4*i-2]),$signed(exp[4*i-1]));
        end
        $display("\n The delta result is %.4f, calculation time is %2d clk\n",0.0039,count);
        $display("-----------------------------------------------------\n");
        //$fclose(f);
        $finish;
    end
    //fail
    #(`End_CYCLE);
    fail_task;
  end

  always @(negedge clk) begin 
    if(start)
      count = count + 1;
  end

  task fail_task();
  begin
    $display("-----------------------------------------------------\n");
    $display("Error!!! There is something wrong with your code ...!\n");
    $display("------The test result is .....FAIL ------------------\n");
    $display("-----------------------------------------------------\n");
    $finish;
  end 
  endtask

endmodule