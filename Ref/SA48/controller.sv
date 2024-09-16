module controller(
	input clk,
	input rst,
	
	input startChunks,
	output reg resultReady,
	
	output reg init0,
	output reg shift_12bR
);

	localparam [2:0] Idle 	  = 3'b000,
					 Starting = 3'b001,
					 Ch1	  = 3'b010,
					 Ch2	  = 3'b011,
					 Ch3	  = 3'b100,
					 Ch4	  = 3'b101;
	reg [2:0] ps, ns;
	
	always @(posedge clk) begin
		if(rst)
			ps <= 0;
		else 
			ps <= ns;
	end
	
	always @(ps, startChunks) begin
		case(ps)
			Idle 	:	ns = (startChunks) ? Starting : Idle;
			Starting:	ns = (~startChunks) ? Ch1 : Starting;
			Ch1		:	ns = Ch2;
		    Ch2	 	:	ns = Ch3;
		    Ch3	 	:	ns = Ch4;	
		    Ch4	 	:	ns = Idle;
		endcase
	end
	
	always @(ps) begin
		resultReady = 0;
		init0 = 0;
		shift_12bR = 0;
		case(ps)
			Idle 	:	resultReady = 1;
			Starting:	init0 = 1;
			Ch1		:	shift_12bR = 1;
		    Ch2	 	:	shift_12bR = 1;
		    Ch3	 	:	shift_12bR = 1;	
		    Ch4	 	:	shift_12bR = 1;
		endcase
	end
	
endmodule