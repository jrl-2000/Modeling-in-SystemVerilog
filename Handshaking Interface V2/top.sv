`timescale 1ns / 1ps

module top (
    input clkA1,
    input clkA2,
    input clkB,
    input clkC,
    input rst,
    output reg [63:0] sharedBusTop
);

wire reqA1;
wire reqA2;
wire gntA1;
wire gntA2;


controller ctrl1(
    .reqA1(reqA1),
    .reqA2(reqA2),
    .gntA1(gntA1),
    .gntA2(gntA2)
);



datapath dp1(
    .clkA1(clkA1),
    .clkA2(clkA2),
    .clkB(clkB),
    .clkC(clkC),
    .rst(rst),
    .gntA1(gntA1),
    .gntA2(gntA2),
    .reqA1(reqA1),
    .reqA2(reqA2),
    .sharedBusTop(sharedBusTop)
);
    
endmodule