module CLL4b(
    input Ci,
    input [3:0] G,
    input [3:0] P,

    output [3:0] C
);

    assign C[0] = G[0] | (P[0] & Ci);
    assign C[1] = G[1] | (P[1] & C[0]);
    assign C[2] = G[2] | (P[2] & C[1]);
    assign C[3] = G[3] | (P[3] & C[2]);

endmodule



