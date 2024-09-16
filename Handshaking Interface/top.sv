`timescale 1ns / 1ps

module top(
    input clkA,
    input clkB,
    input clkC,
    input clkD,
    input reset,
    output reg [7:0] printd0,   
    output reg [7:0] printd1 
    );

    //Regs
    reg gntA;
    reg reqA;
    reg [63:0] sharedBus;

    datapath instDP(
        .clkA(clkA),
        .clkB(clkB),
        .clkC(clkC),
        .clkD(clkD),
        .reset(reset),
        .gntA(gntA),
        .reqA(reqA),
        .sharedBus(sharedBus),
        .printd0(printd0),
        .printd1(printd1)
    );

    controller instCTRLR(
        .clkA(clkA),
        .reset(reset),
        .reqA(reqA),
        .sharedBus(sharedBus),
        .gntA(gntA)
    );


endmodule
