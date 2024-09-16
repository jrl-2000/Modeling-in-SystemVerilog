`timescale 1ns / 1ps
module carrryLookAhead(
    input c,
    input [3:0] x, //for the 4 FAPG Modules 4 bit numbers
    input [3:0] y, //for the 4 FAPG Modules 4 bit numbers
    output c4,
    output [3:0] carry
    );

    //Wires
wire [3:0] p;
wire [3:0] g;
wire [3:0] s;
wire [2:0] c_i;

//Module Instantiation
//
    fapg fapg0(
        .x(x[0]),
        .y(y[0]),
        .c(c),
        .p(p[0]),
        .g(g[0]),
        .s(s[0])
);
    fapg fapg1(
        .x(x[1]),
        .y(y[1]),
        .c(c_i[0]),
        .p(p[1]),
        .g(g[1]),
        .s(s[1])
);
    fapg fapg2(
        .x(x[2]),
        .y(y[2]),
        .c(c_i[1]),
        .p(p[2]),
        .g(g[2]),
        .s(s[2])
);
    fapg fapg3(
        .x(x[3]),
        .y(y[3]),
        .c(c_i[2]),
        .p(p[3]),
        .g(g[3]),
        .s(s[3])
);

//The carry output Boolean function of each stage in a 4 stage carry lookahead adder
assign c_i[0] = g[0] | (p[0] & c);
assign c_i[1] = g[1] | (p[1] & c_i[0]);
assign c_i[2] = g[2] | (p[2] & c_i[1]);
assign c4 = g[3] | (p[3] & c_i[2]);
//carry output is s logic
assign carry = s;

endmodule