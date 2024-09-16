`timescale 1ns/1ns
module CLL_3b(
    input Cin,
    input [2:0] G,
    input [2:0] P,

    output [2:0] C
);


    assign #1 C[0] = G[0] | (P[0] & Cin);
    assign #1 C[1] = G[1] | (P[1] & C[0]);
    assign #1 C[2] = G[2] | (P[2] & C[1]);


endmodule
