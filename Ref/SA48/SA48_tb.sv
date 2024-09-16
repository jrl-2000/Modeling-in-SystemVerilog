`timescale 1ns / 1ps

module SA48_tb();

	reg clk = 0;
	reg rst;
	reg [11:0] inBusA;
	reg [11:0] inBusB;
	reg startChunks;
	wire resultReady;

	wire [47:0] outBus;


	SA48 uut(
		.clk(clk),
		.rst(rst),
		.inBusA(inBusA),
		.inBusB(inBusB),
		.startChunks(startChunks),
		.outBus(outBus),
		.resultReady(resultReady)
	);



	always #5 clk = ~clk;


	initial begin
		startChunks = 1'b0;
		rst = 1'b1;
		#22; // FFFFFA000003 + FFFFFB001004 = FFFF F500 1007
		rst = 1'b0;
		startChunks = 1'b1; 
		#10;
		startChunks = 1'b0;
		#10;
		inBusA = 12'h003;
		inBusB = 12'h004;
		#10;
		inBusA = 12'h000;
		inBusB = 12'h001;
		#10;
		inBusA = 12'hFFA;
		inBusB = 12'hFFB;
		#10;
		inBusA = 12'hFFF;
		inBusB = 12'hFFF;
		
		#50;
		
		// 00000D000003 + FFFFFB001005 = 0000 0800 1008
		startChunks = 1'b1; 
		#10;
		startChunks = 1'b0;
		#10;
		inBusA = 12'h003;
		inBusB = 12'h005;
		#10;
		inBusA = 12'h000;
		inBusB = 12'h001;
		#10;
		inBusA = 12'h00D;
		inBusB = 12'hFFB;
		#10;
		inBusA = 12'h000;
		inBusB = 12'hFFF;
		
		#50;
		$stop; 
	end
	
endmodule