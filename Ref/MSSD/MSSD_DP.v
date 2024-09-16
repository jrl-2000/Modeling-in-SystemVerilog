// Negin Safari --- hw1 solution
module MSSD_DP(

	input clk,
	input rst,
	input serIn,
	
	output p0,
	output p1,
	output p2,
	output p3,
	
	output [1:0] d,
	
	input en_out,
	input shiftEnDreg,
	input shiftEnNreg,
	input [1:0] selLimit,
	input init0,
	input cen,
	output endCnt
);

	wire [3:0] n;
	wire [11:0] limit;
	
	shift_register #(2) Dreg(
		.clk(clk),
		.rst(rst),
		.serInp(serIn),
		.shiftEnable(shiftEnDreg),
		.data(d)
	);
	
	shift_register #(4) Nreg(
		.clk(clk),
		.rst(rst),
		.serInp(serIn),
		.shiftEnable(shiftEnNreg),
		.data(n)
	);
	
	assign limit = (selLimit == 1) ? ((n<<3)-1) :
				   (selLimit == 2) ? (2-1) :
				   (selLimit == 3) ? (4-1) : 12'bz;
				   
	
	counter #(12) Cntr(
		.clk(clk),
		.rst(rst),
		.cen(cen),
		.init0(init0),
		.limit(limit),
		.endCnt(endCnt)
	);	
	
	assign {p0, p1, p2, p3} = (en_out&&(d == 0)) ? {serIn, 1'bz, 1'bz, 1'bz} :
							  (en_out&&(d == 1)) ? {1'bz, serIn, 1'bz, 1'bz} :
							  (en_out&&(d == 2)) ? {1'bz, 1'bz, serIn, 1'bz} : 
							  (en_out&&(d == 3)) ? {1'bz, 1'bz, 1'bz, serIn} : 4'bz;
							  
							  
endmodule
	
	
