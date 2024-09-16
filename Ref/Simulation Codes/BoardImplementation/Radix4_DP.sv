// **************************************************************************************
//	Filename:	Radix4_DP.v
//	Project:	Homework 3
//  Version:	1.0
//	History:
//	Date:		12 April 2021
// *************************************************************************************
module Datapath	(clk, rst, in, putout, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh,  sh_A, ld_P, zero_P, sel_AS, sel_MUX, op, ready, result);

	input	clk, rst;
	input  [7:0] in;
	wire [15:0] A,B;
	input   sh_A, ld_P, zero_P, sel_AS, ready,ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh, putout ;	 //come from controller part
	input  [1:0] sel_MUX;										//come from controller part
	
	output reg [31:0] result;
	output [2:0] op; 										//go to controller part	
	wire [31:0]	temp;
	reg [16:0] A_reg;
	reg [15:0] B_reg;
	reg [15:0] P_reg;
	reg [15:0] AS_out;
	reg [15:0] in2_AS;
	wire [15:0] B2;
	reg [15:0] sum_LSB;
	reg cout;
	wire cin;
	
	assign A[7:0] = (ld_Alow) ? in : A[7:0];
	assign A[15:8] = (ld_Ahigh) ? in : A[15:8];
	assign B[7:0] = (ld_Blow) ? in : B[7:0];
	assign B[15:8] = (ld_Bhigh) ? in : B[15:8];
	
//A register: 
	always  @( posedge rst, posedge clk ) begin
		if( rst )
			A_reg <= 16'b0;
		else if( ld_Ahigh )
			A_reg <= {A, 1'b0};
		else if( sh_A )
			A_reg <= {AS_out[1:0], A_reg[16:2]};			
	end

	
//B register: 
	always  @( posedge rst, posedge clk ) begin
		if( rst )
			B_reg <= 16'b0;
		else if( ld_Bhigh )
			B_reg <= B;		
	end


//P register: 
	always  @( posedge rst, posedge clk ) begin
		if( rst )
			P_reg <= 16'b0;
		else if( zero_P )
			P_reg <= 16'b0;
		else if( ld_P )
			P_reg <= {AS_out[15], AS_out[15], AS_out[15:2]};
	end
	
	assign B2 = {B_reg[14:0], 1'b0};
	
	
//MUX for in1_mul	
	always @(sel_MUX, B_reg, B2) begin
		if( sel_MUX == 2'b00 )
			in2_AS = 15'b0;
		else if( sel_MUX == 2'b01 )
			in2_AS = B_reg;
		else if( sel_MUX == 2'b10 )
			in2_AS = B2;
		else if( sel_MUX == 2'b11 )
			in2_AS = 15'b0;
	end
	
	
//AddSub
	always @(sel_AS, P_reg, in2_AS, cin) begin
		if(~sel_AS)
			AS_out = P_reg + in2_AS ;
		else
			AS_out = P_reg - in2_AS;
	end
	
	always @(A_reg) begin
		{cout, sum_LSB} =  {1'B0, A_reg[16:1]};
	end


	assign op = A_reg[2:0];
	assign temp =  {AS_out, sum_LSB};
	
	always @(putout,temp ) begin
		if(~putout)
		result =  {16'B0, temp[31:15]};
		else
		result =  temp;
	end

	
endmodule
	  
	  