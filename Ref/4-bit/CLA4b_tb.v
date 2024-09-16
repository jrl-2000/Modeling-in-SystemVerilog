`timescale 1ns/1ns
module CLA4b_tb();

    reg [3:0] X;
    reg [3:0] Y;
    reg Ci;

    wire [3:0] S;
    wire Co;

CLA4b CLA4b_inst(.X(X), .Y(Y), .Ci(Ci), .S(S), .Co(Co));

initial begin
    X = 2;
    Y = 3;
    Ci = 1;
    #200;

    X = -4;
    Y = 7;
    Ci = 0;
    #200; 



end




endmodule
