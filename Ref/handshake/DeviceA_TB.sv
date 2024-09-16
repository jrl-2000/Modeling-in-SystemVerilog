module DeviceA_tb;
    logic  			clk=0, rst=0;
	logic 			gntA=1'b1, acceptedB=1'b0, start=1'b0;
	logic [15:0] 	in_A;
	wire  [63:0] 	out_A;
	wire 			readyA, reqA;
 
    int i;
	DeviceA_TOP UUT1(clk, rst, start, gntA, acceptedB, in_A, out_A, readyA, reqA);
	
    always #50  clk = ~clk;
	
    initial begin
	#15 rst = 1;
	#15 rst = 0;
	#15 start=1;
		for  (i = 0; i < 4; i = i + 1) begin
			@(negedge clk) begin
				in_A <= $random;
			end
		end
	# 50 acceptedB=1'b1;
	# 205 acceptedB=1'b0;
	end
	
endmodule