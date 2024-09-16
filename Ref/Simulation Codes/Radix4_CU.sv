
module Controller (clk, rst, start, op, ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, sel_MUX, busy, ready);

	input  clk, rst, start;
	input [2:0] op;															//comes from datapath part
	
	output busy,ready;
	output ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS;    //go to datapath part
	output reg [1:0] sel_MUX;												 //go to datapath part
	
	reg busy, ready;
	reg ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS;
	reg [1:0] p_state, n_state;
	reg zero_cntr, en_cntr;
	wire co;
	reg [2:0] cntr = 3'b000;
	parameter [1:0] IDLE = 2'b00, LOAD = 2'b01, COUNT = 2'b10, ADD = 2'b11;
	
	
	always @( p_state, start, co, op) begin
	
		n_state = IDLE;
		busy = 1'b1;
		ready = 1'b0;
		ld_A = 1'b0; sh_A = 1'b0; ld_B = 1'b0; ld_P = 1'b0; zero_P = 1'b0; sel_AS = 1'b0;  sel_MUX = 2'b00;
		en_cntr = 1'b0; zero_cntr = 1'b0;

		case ( p_state )
			IDLE : begin
				busy = 1'b0;
				ready = 1'b1;
				zero_cntr = 1'b1;		
				ld_A = 1'b0;
				ld_B = 1'b0;
		
				
				if( start )
					n_state = LOAD;
				else
					n_state = IDLE;
			end
			
			LOAD : begin
	
				ld_A = 1'b1;
				ld_B = 1'b1;
				zero_P = 1'b1;
				n_state = COUNT;

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
	  
	  