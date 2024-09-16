`timescale 1ns / 1ps

module tb4(
    
    );
    reg [2:0] X;
    reg [2:0] Y;
    reg Ci;

    wire [2:0] S;
    wire Co;

cla cla_inst(.c(Ci), .x(X), .y(Y), .c12(Co), .s(S));

initial begin
    X = 2;
    Y = 3;
    Ci = 0;
    #200;

//    X = -4;
//    Y = 7;
//    Ci = 0;
//    #200; 



end
endmodule
