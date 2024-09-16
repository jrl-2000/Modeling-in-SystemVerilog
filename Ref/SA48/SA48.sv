module SA48(
	input clk,
	input rst,
	
	input startChunks,
	output resultReady,
	
	input [11:0] inBusA,
	input [11:0] inBusB,
	output[47:0] outBus
);

	wire init0, shift_12bR;

	controller CU(
		.clk(clk),
		.rst(rst),
		.startChunks(startChunks),
		.resultReady(resultReady),
		.init0(init0),
		.shift_12bR(shift_12bR)
	);

	datapath DP(
		.clk(clk),
		.rst(rst),
		.inBusA(inBusA),
		.inBusB(inBusB),
		.outBus(outBus),
		.init0(init0),
		.shift_12bR(shift_12bR)
	);
	
endmodule