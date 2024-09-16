module adder_12b(

    input [11:0] X,
    input [11:0] Y,
    input Cin,

    output [11:0] S,
    output Co
);

    wire [4:0] C;


    genvar i;

    generate 
        for(i=0; i<4; i=i+1) begin : CLA_3bs
            CLA_3b CLA_3b_inst(.A(X[((i*3)+2):(i*3)]), .B(Y[((i*3)+2):(i*3)]), .Cin(C[i]), .S(S[((i*3)+2):(i*3)]), .Co(C[i+1]));
        end
    endgenerate
    
    assign C[0] = Cin;
    assign Co = C[4];

endmodule


