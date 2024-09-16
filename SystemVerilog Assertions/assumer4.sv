`timescale 1ns / 1ps

// Jonathan Lopez
// ECE 5720 Homework # 5
// Spring 2023
//Modified Controller and top module for SW input

//Top Module

module assumer4(
    input clk,
    input rst,
    input [7:0] swData,
    input startAR4,
	 input GetA,
	 input GetX,
	 output reg [6:0]displ0,
	 output reg [6:0]displ1,
	 output reg [6:0]displ2,
	 output reg [6:0]displ3,
	 output reg [6:0]displ4,
	 output reg [6:0]displ5,
    output reg readyAR4
    //output reg signed [31:0] outAR4
    );

    reg setRAR4;
    reg beginAR4;
	 //reg [6:0]displ0;
	 //reg [6:0]displ1;
	 //reg [6:0]displ2;
	 //reg [6:0]displ3;
	 //reg [6:0]displ4;
	 //reg [6:0]displ5;
	 reg signed [31:0] outAR4;
	 
    //reg startAR4;
	 
    
    assumer4Datapath instDP(
        .clk(clk),
        .rst(rst),
        .startAR4(startAR4),
        .setRAR4(setRAR4),
        .beginAR4(beginAR4),
        .readyAR4(setRAR4)
    );

    assumer4Controller instCNTRLR(
        .clk(clk),
        .rst(rst),
        .beginAR4(beginAR4),
        .swData(swData),
        .GetA(GetA),
		  .GetX(GetX),
        .setRAR4(readyAR4),
        .outAR4(outAR4)
    );
	 
	 Hexdisplay Hex0(
		  .digit(outAR4[3:0]),
		  .displ(displ0)
	 );
	 Hexdisplay Hex1(
		  .digit(outAR4[7:4]),
		  .displ(displ1)
	 );
	 Hexdisplay Hex2(
		  .digit(outAR4[11:8]),
		  .displ(displ2)
	 );
	 Hexdisplay Hex3(
		  .digit(outAR4[15:12]),
		  .displ(displ3)
	 );
	 Hexdisplay Hex4(
		  .digit(outAR4[19:16]),
		  .displ(displ4)
	 );
	 Hexdisplay Hex5(
		  .digit(outAR4[23:20]),
		  .displ(displ5)
	 );
	 
endmodule