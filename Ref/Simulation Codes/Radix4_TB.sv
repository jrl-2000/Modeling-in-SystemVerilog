
module Radix4_TB ();
		
	reg	clk = 1'b1;
	reg rst;
	reg startAR4=1'b0;
	reg [15:0] A, B;

	wire [31:0] outAR4;
	wire busy, readyAR4;
	
	Radix4 MUT (clk, rst, startAR4, A, B, busy, outAR4, readyAR4);
	
	always #19 clk = ~clk;
	
	initial begin
		
		rst = 1'b1;
		#100; rst = 1'b0;			
			A = 16'b1111111111110110; 		// A = 10
			B = 16'b1111111111101111;		// B = 17
		# 5 startAR4=1'b1;
		# 20 startAR4=1'b0;
		#1000 			
			A = 16'b0000000000001010; 		
			B = 16'b1100001111100001;		
		# 5 startAR4=1'b1;
		# 20 startAR4=1'b0;
		#400
		$stop;
		
	end

endmodule
	  
	  