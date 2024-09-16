module CLA4b(
    input [3:0] X,
    input [3:0] Y,
    input Ci,

    output [3:0] S,
    output Co
);

    wire [4:0] C_wire;
    wire [3:0] G, P;

    assign C_wire[0] = Ci;
    assign Co = C_wire[4];

    genvar i;

    generate 
        for(i=0; i<4; i=i+1) begin : FA_PG
            FA_PG FA_PG_inst(.X(X[i]), .Y(Y[i]), .Ci(C_wire[i]), .S(S[i]), .G(G[i]), .P(P[i]));
        end
    endgenerate

    CLL4b CLL4b_inst( .G(G), .P(P), .Ci(Ci), .C(C_wire[4:1]));

endmodule
