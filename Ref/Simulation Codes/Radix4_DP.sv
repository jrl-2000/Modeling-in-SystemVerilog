
module Datapath	(clk, rst, A, B, ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, sel_MUX, op, ready, result);

	input	clk, rst;
	input  [15:0] A, B;
	
	input  ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, ready;	 //come from controller part
	input  [1:0] sel_MUX;										//come from controller part
	
	output [31:0] result;
	output [2:0] op; 										//go to controller part	
	
	reg [16:0] A_reg;
	reg [15:0] B_reg;
	reg [15:0] P_reg;
	reg [15:0] AS_out;
	reg [15:0] in2_AS;
	wire [15:0] B2;
	reg [15:0] sum_LSB;
	reg cout;
	wire cin;
	
	
//A register: 
	always  @( posedge rst, posedge clk ) begin
		if( rst )
			A_reg <= 16'b0;
		else if( ld_A )
			A_reg <= {A, 1'b0};
		else if( sh_A )
			A_reg <= {AS_out[1:0], A_reg[16:2]};			
	end

	
//B register: 
	always  @( posedge rst, posedge clk ) begin
		if( rst )
			B_reg <= 16'b0;
		else if( ld_B )
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
			in2_AS <= 15'b0;
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
	assign result = ready ? {AS_out, sum_LSB}: 32'b0;

	
endmodule
	  
	  