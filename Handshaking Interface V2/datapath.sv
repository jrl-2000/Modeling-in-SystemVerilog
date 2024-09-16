`timescale 1ns / 1ps

module datapath(
    input clkA1,
    input clkA2,
    input clkB,
    input clkC,
    input rst,
    input gntA1,
    input gntA2,
    output reg reqA1,
    output reg reqA2,
    output reg [63:0] sharedBusTop    
    );

reg [7:0] sharedBus;
reg [63:0] sharedBus64;
wire readyA1;
wire readyA2;
wire readyB;
wire acceptedB;
wire acceptedC;



DevAone DA1(
    .clkA1(clkA1),
    .rst(rst),
    .gntA1(gntA1),
    .acceptedB(acceptedB),
    .sharedBus(sharedBus),
    .reqA1(reqA1),
    .readyA1(readyA1)
);


DevAtwo DA2(
    .clkA2(clkA2),
    .rst(rst),
    .gntA2(gntA2),
    .acceptedB(acceptedB),
    .sharedBus(sharedBus),
    .reqA2(reqA2),
    .readyA2(readyA2)
);

DevB DB1(
    .clkB(clkB),
    .rst(rst),
    .sharedBus(sharedBus),
    .readyA1(readyA1),
    .readyA2(readyA2),
    .acceptedC(acceptedC),
    .acceptedB(acceptedB),
    .sharedBus64(sharedBus64),
    .readyB(readyB)
);

DevC DC1(
    .clkC(clkC),
    .rst(rst),
    .sharedBus64(sharedBus64),
    .readyB(readyB),
    .acceptedC(acceptedC),
    .sharedBusTop(sharedBusTop)
);


endmodule
