module DeviceAB_tb;
    logic  			clk=0, rst=0;
	logic 			gntA=1'b1, start=1'b0;
	logic [15:0] 	in_A;
	wire  [63:0] 	out_A;
	wire  [15:0] 	out_B;
	wire 			readyA, reqA;
	logic 			acceptedC = 1'b1;
	wire 			readyB;
	wire			acceptedB;
 
    int i;
	DeviceA_TOP UUT1(clk, rst, start, gntA, acceptedB, in_A, out_A, readyA, reqA);
	DeviceB_TOP	UUT2(clk, rst, readyA, acceptedC, out_A, out_B, readyB, acceptedB);
	
	
    always #50  clk = ~clk;
	always  begin
		for  (i = 0; i < 4; i = i + 1) begin
			@(negedge clk) begin
				in_A <= $random;
			end
		end
	end
    initial begin
	#15 rst = 1;
	#15 rst = 0;
	#15 start=1;
	
	end
	
endmodule