`timescale 1ns / 1ps
//Jonathan Lopez
//ECE 5720
//Homework 2: Structural Description of Combinational Components
//16-bit adder

module top(
    input c, //starting carry value
    input [15:0] x, //1st number to add
    input [15:0] y, //2nd number to add
    output c16, //
    output [16:0] finResult
    );

wire [2:0] c_i; //intermediate c only need a 3 bits as we start with one as the input
wire [15:0] s;

carrryLookAhead carrryLookAhead0(
    .c(c),
    .x(x[3:0]),
    .y(y[3:0]),
    .c4(c_i[0]),
    .carry(s[3:0])
);
carrryLookAhead carrryLookAhead1(
    .c(c_i[0]),
    .x(x[7:4]),
    .y(y[7:4]),
    .c4(c_i[1]),
    .carry(s[7:4])
);
carrryLookAhead carrryLookAhead2(
    .c(c_i[1]),
    .x(x[11:8]),
    .y(y[11:8]),
    .c4(c_i[2]),
    .carry(s[11:8])
);
carrryLookAhead carrryLookAhead3(
    .c(c_i[2]),
    .x(x[15:12]),
    .y(y[15:12]),
    .c4(c16),
    .carry(s[15:12])
);

//concatenate the answer in carry16 (c16) and add s for the overflow of two 16-bit numbers being added
//returns a 17-bit number
assign finResult = {c16, s};

endmodule