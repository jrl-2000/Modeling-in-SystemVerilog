module DeviceABCD_tb;
    logic  			clk1=0,clk2=0,clk3=0,clk4=0, rst=0;
	logic 			gntA=1'b1, start=1'b0;
	logic [15:0] 	in_A;
	wire  [63:0] 	out_A;
	wire  [15:0] 	out_B;
	wire  [7: 0] 	out_C;
	wire 			readyA, reqA, readyC;
	wire 			acceptedC;
	wire 			acceptedD;
	wire 			readyB;
	wire			acceptedB;
 
    int i;
	wire [7:0] out_D;
	

	DeviceA_TOP UUT1(clk1, rst, start, gntA, acceptedB, in_A, out_A, readyA, reqA);
	DeviceB_TOP	UUT2(clk2, rst, readyA, acceptedC, out_A, out_B, readyB, acceptedB);
	DeviceC_TOP UUT3(clk3, rst, readyB, acceptedD, out_B, out_C, readyC, acceptedC);
	DeviceD_TOP UUT4(clk4, rst, readyC, out_C, out_D, acceptedD);
	
    always #10  clk1 = ~clk1;
	always #11  clk2 = ~clk2;
	always #12  clk3 = ~clk3;
	always #13  clk4 = ~clk4;
	always  begin
		for  (i = 0; i < 8; i = i + 1) begin
			@(negedge clk1) begin
				in_A <= $random;
			end
		end
	end
	
	always  @(posedge  readyA) begin
				$display ("data sent to Device B is %b" , out_A);
	end
	
	always  @(posedge  acceptedD) begin
				$display ("data recieved at Device D is %b"  , out_D);
	end
	
	
	
	
    initial begin
	#15 rst = 1;
	#15 rst = 0;
	#15 start=1;

	#2500;
	$stop;

	end
	
	
	
endmodule