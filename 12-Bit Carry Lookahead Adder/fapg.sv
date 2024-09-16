`timescale 1ns / 1ps
module fapg (
    input x,
    input y,
    input c,
    output p,
    output g,
    output s
);

assign p = x ^ y; //XOR
assign s = p ^ c; //XOR
assign g = x & y; //AND

endmodule