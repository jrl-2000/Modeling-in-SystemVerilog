`timescale 1ns / 1ps
module toptb(
    );
    //Regs
    reg [3:0] parIn;
    reg clk = 1;
    reg rst = 0;
    reg ld;
    reg cen;
    reg co;
    reg [3:0] parOut;
    reg ci;
    
    //Simulate CLK
    always #1
    clk = ~clk;
        
    //UUT
    fourbitupc uut(
        .clk(clk),
        .rst(rst),
        .ld(ld),
        .ci(ci),
        .cen(cen),
        .parIn(parIn),
        .parOut(parOut),
        .co(co));
        
        initial begin
        //test reset functionality
        //Intialization of 1 to reset
        rst = 1'b1;
        co = 1'b1;
        ld = 1'b1;
        ci= 1'b1;
        parIn = 4'b1111;
        parOut = 4'b1111;
        cen = 1'b1;
        #2;
        rst = 1'b0;
        #2;
        //Reset ^^^^^^^
        rst = 1'b1;
        co = 1'b0;
        cen = 1'b1;
        ci = 1'b0;
        parIn = 4'b0101;
        ld = 1'b1;
        #1;
        ld = 1'b0;
        #22;
        cen = 1'b0;
        #2;
        //Start at 5 count until 0xf ^^^^^^^^^^^^^^
        rst = 1'b0;
        #2;
        rst = 1'b1;
        parIn = 4'b0110;
        ld = 1'b1;
        #2;
        ld = 1'b0;
        cen = 1'b1;
        #10;
        cen = 1'b0;
        #2;
        //Start at 6 count to 0xB ^^^^^^^^^^^
        rst = 1'b0;
        #2;
        rst = 1'b1;
        parIn = 4'b0000;
        ld = 1'b1;
        #2;
        ld = 1'b0;
        cen = 1'b1;
        #40;
        cen = 1'b0;
        //Start at 0 and countil until overflow 0x4 ^^^^^^^^^^^
  end  
endmodule
