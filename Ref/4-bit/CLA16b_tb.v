`timescale 1ns/1ns
module CLA16b_tb();

    reg [15:0] X;
    reg [15:0] Y;
    reg Ci;

    wire [15:0] S;
    wire Co;

CLA16b CLA16b_inst(.X(X), .Y(Y), .Ci(Ci), .S(S), .Co(Co));

initial begin
    X = 7;
    Y = 13;
    Ci = 1;
    #200;

    X = -14;
    Y = 22;
    Ci = 0;
    #200; 



end




endmodule

