`timescale 1ns / 1ps

module toptb(
    );

reg clk = 1;
reg rst;
reg [31:0] bus32;
reg startSignal;
reg [31:0] rsltW;
reg readyPulse;

top UUT(
    .clk(clk),
    .rst(rst),
    .bus32(bus32),
    .startSignal(startSignal),
    .rsltW(rsltW),
    .readyPulse(readyPulse)
);


always #1
    clk = ~clk;

initial begin
    rst = 1'b1;
    startSignal = 1'b0;
    #2;
    rst = 1'b0;
    #2;
    rst = 1'b1;
    #2;
    //              opndA           opndB           
    bus32 = 32'b0000000011110000_0000000110000110;
    #2;
    startSignal = 1'b1;
    #2;
    startSignal = 1'b0;
    #200;

    // //              opndA           opndB           
    // bus32 = 32'b1000100101100000_0000000000000110;
    // #2;
    // startSignal = 1'b1;
    // #2;
    // startSignal = 1'b0;
    // #200;

    
    // //              opndA           opndB           
    // bus32 = 32'b0000000000010110_1000100101100000;
    // #2;
    // startSignal = 1'b1;
    // #2;
    // startSignal = 1'b0;
    // #200;

    // //              opndA           opndB           
    // bus32 = 32'b0000010000000000_0000100000000000;
    // #2;
    // startSignal = 1'b1;
    // #2;
    // startSignal = 1'b0;
    // #200;
    $finish;

end
endmodule