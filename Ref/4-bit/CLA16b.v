module CLA16b(
    input [15:0] X,
    input [15:0] Y,
    input Ci,

    output [15:0] S,
    output Co
);

    wire [4:0] C_wire;

    assign C_wire[0] = Ci;
    assign Co = C_wire[4];

    genvar i;

    generate 
        for(i=0; i<4; i=i+1) begin : CLA4b
            CLA4b CLA4b_inst(.X(X[((i*4)+3):(i*4)]), .Y(Y[((i*4)+3):(i*4)]), .Ci(C_wire[i]), .S(S[((i*4)+3):(i*4)]), .Co(C_wire[i+1]));
        end
    endgenerate

endmodule
