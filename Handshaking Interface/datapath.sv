`timescale 1ns / 1ps

module datapath(
    input clkA,
    input clkB,
    input clkC,
    input clkD,
    input reset,
    input gntA,
    output reg reqA,
    output reg [63:0] sharedBus,
    output reg [7:0] printd0,
    output reg [7:0] printd1
    );

    
    reg readyA;
    //reg [63:0] sharedBus;
    reg acceptedB;
    reg readyB;
    reg [15:0] sharedBusBC;
    reg acceptedC;
    reg readyC;
    reg [7:0] sharedBusCD;
    reg acceptedD;
    // reg [7:0] printd0;
    // reg [7:0] printd1;

    deviceA instA(
        .clkA(clkA),
        .reset(reset),
        .gntA(gntA),
        .acceptedB(acceptedB),
        .sharedBus(sharedBus),
        .reqA(reqA),
        .readyA(readyA)
    );

    deviceB instB(
        .clkB(clkB),
        .reset(reset),
        .sharedBus(sharedBus),
        .readyA(readyA),
        .acceptedC(acceptedC),
        .acceptedB(acceptedB),
        .readyB(readyB),
        .sharedBusBC(sharedBusBC)
    );

    deviceC instC(
        .clkC(clkC),
        .reset(reset),
        .sharedBusBC(sharedBusBC),
        .readyB(readyB),
        .acceptedD(acceptedD),
        .acceptedC(acceptedC),
        .readyC(readyC),
        .sharedBusCD(sharedBusCD)
    );

    deviceD instD(
        .clkD(clkD),
        .reset(reset),
        .readyC(readyC),
        .sharedBusCD(sharedBusCD),
        .acceptedD(acceptedD),
        .printd0(printd0),
        .printd1(printd1)
    );




endmodule
