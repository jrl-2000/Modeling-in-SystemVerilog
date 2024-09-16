// Negin Safari --- hw1 solution
module MSSD(

	input clk,
	input rst,
	input serIn,
	
	output p0,
	output p1,
	output p2,
	output p3,
	
	output [1:0] d,
	
	output error,
	output outValid
	
);
	wire shiftEnDreg;
	wire shiftEnNreg;
	wire [1:0] selLimit;
	wire init0;
	wire cen;
	wire endCnt;
	wire en_out;
	
	
	MSSD_DP DP(
		.clk(clk),
		.rst(rst),
		.serIn(serIn),
		.p0(p0),
		.p1(p1),
		.p2(p2),
		.p3(p3),
		.d(d),
		.en_out(en_out),
		.shiftEnDreg(shiftEnDreg),
		.shiftEnNreg(shiftEnNreg),
		.selLimit(selLimit),
		.init0(init0),
		.cen(cen),
		.endCnt(endCnt)
	);
	
	
	MSSD_CU CU(
		.clk(clk),
		.rst(rst),
		.serIn(serIn),
		.error(error),
		.outValid(outValid),
		.shiftEnDreg(shiftEnDreg),
		.shiftEnNreg(shiftEnNreg),
		.selLimit(selLimit),
		.init0(init0),
		.cen(cen),
		.en_out(en_out),
		.endCnt(endCnt)
	);


endmodule
