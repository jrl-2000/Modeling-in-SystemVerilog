// **************************************************************************************
//	Filename:	Radix4.v
//	Project:	Homework 3
//  Version:	1.0
//	History:
//	Date:		12 April 2021
// *************************************************************************************
module Radix4	(clk, rst, startAR4, getA, getB, in, busy, outAR4, readyAR4, putout, HEX0, HEX1, HEX2, HEX3);

	input  clk, rst, startAR4, getA, getB, putout;
	input  [7:0] in;

	output busy, readyAR4;
	output [31:0] outAR4;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	
	wire sh_A, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh, ld_P, zero_P, sel_AS, ld_MAC, busy,readyAR4;
	wire [1:0] sel_MUX;
	wire [2:0] op;
		
			
	Datapath DP (clk, rst, in, putout, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh, sh_A, ld_P, zero_P, sel_AS, sel_MUX, op, readyAR4, outAR4);

	Controller CU (clk, rst, startAR4, getA, getB, op, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh, sh_A, ld_P, zero_P, sel_AS, sel_MUX, busy, readyAR4);
	
	Hexdisplay HD1 (outAR4[3:0], HEX0);
	Hexdisplay HD2 (outAR4[7:4], HEX1);
	Hexdisplay HD3 (outAR4[11:8], HEX2);
	Hexdisplay HD4 (outAR4[15:12], HEX3);
	
endmodule
	  
	  