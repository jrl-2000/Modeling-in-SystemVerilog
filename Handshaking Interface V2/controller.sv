`timescale 1ns / 1ps

module controller (
    input reqA1,
    input reqA2,
    output reg gntA1,
    output reg gntA2
);

Arbiter arb1(
    .reqA1(reqA1),
    .reqA2(reqA2),
    .gntA1(gntA1),
    .gntA2(gntA2)
);
    
endmodule