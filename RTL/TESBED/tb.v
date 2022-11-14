//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/08 20:42:27
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale  1ns/1ps
`define CYCLE   50.0

//picture
`define ifmap   "D:/QR_CORDIC/RTL/TESBED/matrix_ori.dat"
//exp
`define ofmap   "D:/QR_CORDIC/RTL/TESBED/matrix_exp.dat"

module tb();
parameter TBITS = 64;
parameter TBYTE = 8;

localparam NUM_COL = 8;

reg              S_AXIS_MM2S_TVALID;
wire             S_AXIS_MM2S_TREADY;
reg  [TBITS-1:0] S_AXIS_MM2S_TDATA ;
reg  [TBYTE-1:0] S_AXIS_MM2S_TKEEP ;
reg  [1-1:0]     S_AXIS_MM2S_TLAST ;

wire             M_AXIS_S2MM_TVALID;
reg              M_AXIS_S2MM_TREADY;
wire [TBITS-1:0] M_AXIS_S2MM_TDATA;
wire [TBYTE-1:0] M_AXIS_S2MM_TKEEP;
wire [1-1:0]     M_AXIS_S2MM_TLAST;

reg              aclk = 0;
reg              aresetn;

//image
reg [TBITS-1:0]  ifmap   [0:NUM_COL-1];
//cexp
reg [TBITS-1:0]  ofmap   [0:NUM_COL-1];


//yolo_top----------------------------------------
yolo_top
#(
        .TBITS(TBITS),
        .TBYTE(TBYTE)
) top_inst (
        .S_AXIS_MM2S_TVALID(S_AXIS_MM2S_TVALID),
        .S_AXIS_MM2S_TREADY(S_AXIS_MM2S_TREADY),
        .S_AXIS_MM2S_TDATA(S_AXIS_MM2S_TDATA),
        .S_AXIS_MM2S_TKEEP(S_AXIS_MM2S_TKEEP),
        .S_AXIS_MM2S_TLAST(S_AXIS_MM2S_TLAST),
        
        .M_AXIS_S2MM_TVALID(M_AXIS_S2MM_TVALID),
        .M_AXIS_S2MM_TREADY(M_AXIS_S2MM_TREADY),
        .M_AXIS_S2MM_TDATA(M_AXIS_S2MM_TDATA),
        .M_AXIS_S2MM_TKEEP(M_AXIS_S2MM_TKEEP),
        .M_AXIS_S2MM_TLAST(M_AXIS_S2MM_TLAST),  // EOL      
        
        .S_AXIS_MM2S_ACLK(aclk),
        .M_AXIS_S2MM_ACLK(aclk),
        .aclk(aclk),
        .aresetn(aresetn)
);

integer i,j;

initial begin // initial pattern and expected result
    wait(aresetn==1);
    begin
        $readmemb(`ifmap, ifmap);
        $readmemb(`ofmap, ofmap);
    end 
end

initial begin   
    S_AXIS_MM2S_TKEEP  = {TBYTE{1'b1}};
    S_AXIS_MM2S_TVALID = 0;
    S_AXIS_MM2S_TDATA  = 0;
    S_AXIS_MM2S_TKEEP  = 0;
    S_AXIS_MM2S_TLAST  = 0;
    M_AXIS_S2MM_TREADY = 0;
    aresetn = 0;//reset
    #(`CYCLE*2);
    aresetn = 1; 
    //READ image input
    #(`CYCLE*2);
    S_AXIS_MM2S_TVALID=1;
    for(i=0; i<=NUM_COL; i=i+1)begin 
        @(negedge aclk);    
        S_AXIS_MM2S_TDATA=ifmap[i];
        
        #0.1;
        wait(S_AXIS_MM2S_TREADY);
    end

    S_AXIS_MM2S_TVALID = 0;
    S_AXIS_MM2S_TDATA  = 'd0;
    S_AXIS_MM2S_TLAST  = 0;
    M_AXIS_S2MM_TREADY = 1;
    wait ( M_AXIS_S2MM_TVALID ) ;
    for(i=0; i<=NUM_COL; i=i+1)begin //image
        @(negedge aclk);    
        if(M_AXIS_S2MM_TDATA != ofmap[i]) begin
            M_AXIS_S2MM_TREADY = 0;
            fail_task;
        end
    end
    M_AXIS_S2MM_TREADY = 0;
    pass_task;
    #(`CYCLE*15);
    $finish;
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

  task pass_task ();
  begin
    $display("\n---------------------Congratulations!------------------------");
    $display("------------- The test result is ..... PASS -----------------\n");
  end
  endtask

always begin #(`CYCLE/2) aclk = ~aclk; end

endmodule 