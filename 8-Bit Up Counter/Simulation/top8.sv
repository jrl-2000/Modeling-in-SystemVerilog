`timescale 1ns / 1ps


module top8(
    input clk,
    input rst,
    input [7:0]parIn,
    input ci,
    input ld,
    input cen,
    output reg [7:0] parOut,
    output reg co
    );


    wire ld_w;
    wire cnt_w;


onePulser onepulser0(
	.clk(clk),
	.rst(rst),
	.btnIn(ld),
	.pulser(ld_w)//
	);
	
	onePulser onepulser1(
	.clk(clk),
	.rst(rst),
	.btnIn(ci),
	.pulser(cnt_w)//
	);
	
	upCounter inst0(
		.parIn(parIn),
		.clk(clk),
		.rst(rst),
		.ci(cnt_w),
		.ld(ld_w),
		.cen(cen),
		.parOut(parOut),
		.co(co)
		);
		

endmodule   
