`timescale 1ns / 1ps
module fapg (
    input x,
    input y,
    input c,
    output p,
    output g,
    output s
);

assign #1 p = x ^ y; //XOR
assign #1 s = p ^ c; //XOR
assign #1 g = x & y; //AND

endmodule