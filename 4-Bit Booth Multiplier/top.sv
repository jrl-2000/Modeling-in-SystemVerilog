`timescale 1ns / 1ps

module top(
    input clk,
    input reset,
    input signed [3:0] multiplicandM,
    input signed [3:0] multiplierQ,
    output [7:0] finproduct
    );

wire [7:0] product;
wire load;
wire add;
wire sub;
wire shift;
wire dc;
wire [1:0] count;
wire qzero;
wire qneg1;
wire [3:0] q;


datapath dp0(
    .clk(clk),
    .reset(reset),
    .load(load),
    .add(add),
    .sub(sub),
    .shift(shift),
    .dc(dc),
    .multiplicandM(multiplicandM [3:0]),
    .multiplierQ(multiplierQ [3:0]),
    .qzero(qzero),
    .q(q [3:0] ),
    .qneg1(qneg1),
    .count(count [1:0]),
    .product(product [7:0])
    );

controller ctrl0(
    .clk(clk),
    .reset(reset),
    .qzero(qzero),
    .q(q [3:0]),
    .qneg1(qneg1),
    .count(count [1:0]),
    .load(load),
    .add(add),
    .sub(sub),
    .shift(shift),
    .dc(dc)
    );

//return the product
assign finproduct = product;



endmodule
