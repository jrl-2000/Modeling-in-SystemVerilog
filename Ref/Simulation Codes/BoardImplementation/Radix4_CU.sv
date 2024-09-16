// **************************************************************************************
//	Filename:	Radix4_CU.v
//	Project:	Homework 3
//  Version:	1.0
//	History:
//	Date:		12 April 2021
// *************************************************************************************

module Controller (clk, rst, start, getA, getB,  op, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh, sh_A, ld_P, zero_P, sel_AS, sel_MUX, busy, ready);

	input  clk, rst, start, getA, getB;
	input [2:0] op;															//comes from datapath part
	
	output busy,ready;
	output sh_A, ld_P, zero_P, sel_AS, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh;    //go to datapath part
	output [1:0] sel_MUX;												 //go to datapath part
	
	reg busy, ready;
	reg sh_A, ld_B, ld_P, zero_P, sel_AS, ld_Alow, ld_Ahigh, ld_Blow, ld_Bhigh;
	reg [1:0] sel_MUX;
	reg [2:0] p_state, n_state;
	reg zero_cntr, en_cntr;
	wire co;
	reg [2:0] cntr = 3'b000;
	parameter [2:0] IDLE = 3'b000, LOADAlow = 3'b001, Wait4ahi = 3'b010, LOADAhigh = 3'b011, LOADBlow = 3'b100, Wait4bhi = 3'b101, LOADBhigh = 3'b110, COUNT = 3'b111;
	
	
	always @( p_state, start, co, op,getA, getB) begin
	
		n_state = IDLE;
		busy = 1'b1;
		ready = 1'b0;
		ld_Alow= 1'b0; ld_Ahigh= 1'b0; ld_Blow= 1'b0; ld_Bhigh = 1'b0; sh_A = 1'b0; ld_B = 1'b0; ld_P = 1'b0; zero_P = 1'b0; sel_AS = 1'b0;  sel_MUX = 2'b00;
		en_cntr = 1'b0; zero_cntr = 1'b0;

		case ( p_state )
			IDLE : begin
				busy = 1'b0;
				ready = 1'b1;
				zero_cntr = 1'b1;		
				ld_Alow= 1'b0;
				ld_Ahigh= 1'b0;
				ld_Blow= 1'b0;
				ld_Bhigh = 1'b0;
		
				
				if( start )
					n_state = LOADAlow;
				else
					n_state = IDLE;
			end
			
			LOADAlow : begin			
				if( ~getA ) begin		//// For getting the input values two 8-bits data of input A are recieved each time with a complete pulse on input getA  ////
				ld_Alow = 1'b1;			//// Wait for a high to low transition on "getA" since we are using push button///
				n_state = Wait4ahi;		///Getting least significant 16-bits of data A in this state/////
				end
				else
				n_state = LOADAlow;
				
			end
			
			Wait4ahi: begin			   //// Wait for a low to high transition on "getA" ////
				if( getA )
				n_state = LOADAhigh;
				else
				n_state = Wait4ahi;
			
			end
			
			LOADAhigh : begin		  /// Wait for a low to high transition on "getA" since we are using push button///
				if( ~getA ) begin	  ///Getting Most significant 16-bits of data A in this state/////
				ld_Ahigh = 1'b1;
				n_state = LOADBlow;
				end
				else
				n_state = LOADAhigh;
						
			end
			
			LOADBlow : begin		 //// For getting the input values two 8-bits data of input B are recieved each time with a complete pulse on input getB  ////
				if( ~getB ) begin	 //// Wait for a high to low transition on "getB" since we are using push button///
				ld_Blow = 1'b1;		 ///Getting least significant 16-bits of data B in this state/////
				n_state = Wait4bhi;
				end
				else
				n_state = LOADBlow;
							
						
			end
						
			Wait4bhi: begin			//// Wait for a low to high transition on "getB" ////
				if( getB )
				n_state = LOADBhigh;
				else
				n_state = Wait4bhi;
						
			end
						
			LOADBhigh : begin		/// Wait for a low to high transition on "getA" since we are using push button///
				if( ~getB ) begin	///Getting Most significant 16-bits of data A in this state/////
				ld_Bhigh = 1'b1;
				n_state = COUNT;
				end
				else
				n_state = LOADBhigh;
									
			end
			
			COUNT: begin
				if ((op == 3'b000) || (op == 3'b111)) begin		// Nothing
					sel_MUX = 2'b00;	
				end
				if ((op == 3'b001) || (op == 3'b010)) begin		// P+B
					sel_MUX = 2'b01;
					sel_AS = 1'b0;
				end
				if (op == 3'b011) begin						// P+2B
					sel_MUX = 2'b10;	
					sel_AS = 1'b0;
				end
				if (op == 3'b100) begin						// P-2B
					sel_MUX = 2'b10;	
					sel_AS = 1'b1;
				end
				if ((op == 3'b101) || (op == 3'b110)) begin		// P-B
					sel_MUX = 2'b01;	
					sel_AS = 1'b1;
				end
				
				en_cntr = 1'b1;
				ld_P = 1'b1;
				sh_A = 1'b1;
				
				if( co )
					n_state = IDLE;
				else
					n_state = COUNT;
				
			end
			
		endcase
		
	end


	always @(posedge clk, posedge rst) begin
		if( rst )
			p_state <= IDLE;
		else
			p_state <= n_state;
	end
	

//Counter: counting the number of iterations
	always @(posedge rst, posedge clk ) begin
		if( rst )
			cntr <= 3'b0;
		else if( zero_cntr )
			cntr <= 3'b0;
		else if( en_cntr )
			cntr <= cntr + 1;
	end
	
	assign co = (cntr == 3'b111) ? 1'b1 : 1'b0;

endmodule
	  
	  