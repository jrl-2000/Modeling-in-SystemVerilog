`timescale 1ns / 1ps

module controller (
    input clkA,
    input reset,
    input reqA,
    input [63:0] sharedBus,
    output reg gntA
);
    
    arbiter instArbiter(
        .clkA(clkA),
        .reset(reset),
        .reqA(reqA),
        .sharedBus(sharedBus),
        .gntA(gntA)
    );

endmodule