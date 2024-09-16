module freqDiv (
			input clk, rst,
			output clkOut   
		);

	upCounter upCounter_inst(.parIn(4'b1111 - 4'b0110), .clk(clk), .rst(rst), .ci(1'b0), .ld(ld), .cen(1'b1), .parOut(), .co(clkOut));	
	
	assign ld = (clkOut) ? 1 : 0;

endmodule
