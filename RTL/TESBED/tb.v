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

reg              S_AXIS_MM2S_TVALID = 0;
wire             S_AXIS_MM2S_TREADY;
reg  [TBITS-1:0] S_AXIS_MM2S_TDATA = 0;
reg  [TBYTE-1:0] S_AXIS_MM2S_TKEEP = 0;
reg  [1-1:0]     S_AXIS_MM2S_TLAST = 0;

wire             M_AXIS_S2MM_TVALID;
reg              M_AXIS_S2MM_TREADY = 0;
wire [TBITS-1:0] M_AXIS_S2MM_TDATA;
wire [TBYTE-1:0] M_AXIS_S2MM_TKEEP;
wire [1-1:0]     M_AXIS_S2MM_TLAST;

reg              aclk = 0;
reg              aresetn = 1;

//image
reg [63:0]  ifmap   [0:7];
//cexp
reg [63:0]  ofmap   [0:7];


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
        $readmemh(`ifmap, ifmap);
        $readmemh(`ofmap, ofmap);
    end 
end

initial begin   
    S_AXIS_MM2S_TKEEP = 'hff;
    #(`CYCLE*2);
    aresetn = 0;
    #(`CYCLE*3);
    aresetn = 1;

    #(`CYCLE*2);

    for(i=0; i<2048; i=i+1)begin //image
        @(posedge aclk);    
        S_AXIS_MM2S_TVALID=1;
        S_AXIS_MM2S_TDATA=ifmap[i];
        
        #0.1;
        wait(S_AXIS_MM2S_TREADY);
    end

    S_AXIS_MM2S_TVALID = 0;
    S_AXIS_MM2S_TDATA  = 'd0;
    S_AXIS_MM2S_TLAST  = 0;
    M_AXIS_S2MM_TREADY=1;

    wait ( M_AXIS_S2MM_TVALID ) ;
    wait (!M_AXIS_S2MM_TVALID) ;
    M_AXIS_S2MM_TREADY = 0;    
    @(negedge M_AXIS_S2MM_TVALID);
    #(`CYCLE*15);
    $finish;
end

integer f,l,m,n,o;
/*
initial
begin
  f = $fopen("D:/SOC_final/ip_ref/pattern/output_LL.txt","w");
  l = $fopen("D:/SOC_final/ip_ref/pattern/output_LH.txt","w");
  m = $fopen("D:/SOC_final/ip_ref/pattern/output_HL.txt","w");
  n = $fopen("D:/SOC_final/ip_ref/pattern/output_HH.txt","w");
end
*/

/*
initial
  begin
    wait ( M_AXIS_S2MM_TVALID ) ;
        f = $fopen("D:/SOC_final/ip_ref/pattern/output_LL.txt","w");
        for(i=0;i<1024;i=i+1) begin
            @(posedge aclk)
            $fwrite(f,"%h\n",M_AXIS_S2MM_TDATA);
        end
        $fclose(f);
        l = $fopen("D:/SOC_final/ip_ref/pattern/output_LH.txt","w");
        for(i=1024;i<2048;i=i+1) begin
            @(posedge aclk)
            $fwrite(l,"%h\n",M_AXIS_S2MM_TDATA);
        end
        $fclose(l);
        m = $fopen("D:/SOC_final/ip_ref/pattern/output_HL.txt","w");
        for(i=2048;i<3072;i=i+1) begin
            @(posedge aclk)
            $fwrite(m,"%h\n",M_AXIS_S2MM_TDATA);
        end
        $fclose(m);
        n = $fopen("D:/SOC_final/ip_ref/pattern/output_HH.txt","w");
        for(i=3072;i<4096;i=i+1) begin
            @(posedge aclk)
            $fwrite(n,"%h\n",M_AXIS_S2MM_TDATA);
        end
        $fclose(n);
    $finish;
  end
*/

always begin #(`CYCLE/2) aclk = ~aclk; end

endmodule 