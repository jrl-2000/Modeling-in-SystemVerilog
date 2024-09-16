// Negin Safari --- hw1 solution
`timescale 1ns/1ns
module MSSD_TB();

	reg clk = 0;  
	reg rst;
	reg serIn;
	wire p0;
	wire p1;
	wire p2;
	wire p3;
	wire [1:0] d;
	wire error;
    wire outValid;
	
	reg [1:0] D_value = 2'b11; 
	reg [3:0] N_value = 4'h2; 
	
	reg [7:0] Data0 = {8'hAB};
	reg [7:0] Data1 = {8'hC9};
	
	MSSD uut(
		.clk   	(clk   	 ),
		.rst   	(rst   	 ),
		.serIn 	(serIn 	 ),
		.p0   	(p0   	 ),
		.p1   	(p1   	 ),
		.p2   	(p2   	 ),
		.p3   	(p3   	 ),
		.d    	(d    	 ),
		.error 	(error 	 ),
		.outValid (outValid)
	);
	
	initial repeat(500) #5 clk = ~clk; 
	
	integer i;
	
	initial begin
		serIn = 1;
		rst = 1;
		#10;
		rst = 0;
		#20;
		serIn = 0;
		#10; //

		for(i=1; i>=0; i=i-1) begin
			serIn = D_value[i];
			#10;
		end
		
		for(i=3; i>=0; i=i-1) begin
			serIn = N_value[i];
			#10;
		end
		
		for(i=7; i>=0; i=i-1) begin
			serIn = Data0[i];
			#10;
		end
		
		for(i=7; i>=0; i=i-1) begin
			serIn = Data1[i];
			#10;
		end
		
		
		#100;
		
		D_value = 2'b10;
		N_value = 4'h2; 
		
		Data0 = {8'hAB};
		Data1 = {8'hCE};
		
		#100;
		
		serIn = 0;
		#10; //

		for(i=1; i>=0; i=i-1) begin
			serIn = D_value[i];
			#10;
		end
		
		for(i=3; i>=0; i=i-1) begin
			serIn = N_value[i];
			#10;
		end
		
		for(i=7; i>=0; i=i-1) begin
			serIn = Data0[i];
			#10;
		end
		
		for(i=7; i>=0; i=i-1) begin
			serIn = Data1[i];
			#10;
		end
		
	
	end
	
	
	
endmodule

