module FA_PG(
    input X,
    input Y,
    input Ci,

    output S,
    output G,
    output P
);

    assign P = X ^ Y;
    assign G = X & Y;
    assign S = P ^ Ci;

endmodule

