// Negin Safari --- hw1 solution
module MSSD_CU(

	input clk,
	input rst,
	input serIn,
	
	output reg error,
	output reg outValid,
	
	output reg en_out,
	output reg shiftEnDreg,
	output reg shiftEnNreg,
	output reg [1:0] selLimit,
	output reg init0,
	output reg cen,
	input endCnt
);
	

	localparam [2:0] IDLE = 3'd0,
					 GETD = 3'd1,
					 GETN = 3'd2,
					 TRNS = 3'd3,
					 ERRC = 3'd4;
	

	reg [2:0] ps, ns;	
					
	
	always @(posedge clk) begin
		if(rst)
			ps <= IDLE;
		else 
			ps <= ns;
	end
	
	always @(serIn, endCnt) begin
		case(ps)
			IDLE: ns = (serIn == 0) ? GETD : IDLE;
			
			GETD: ns = (endCnt == 1) ? GETN : GETD;
			
			GETN: ns = (endCnt == 1) ? TRNS : GETN;
			
			TRNS: ns = (endCnt == 1) ? ERRC : TRNS;
			
			ERRC: ns = (serIn == 1) ? IDLE : ERRC;
			
			default: ns = IDLE;
		endcase
	end
	
	always @(ps, serIn) begin
		error = 0;
		outValid = 0;
		shiftEnDreg = 0;
		shiftEnNreg = 0;
		selLimit = 0;
		init0 = 0;
		cen = 0;
		en_out = 0;
	
		case(ps)
			IDLE: begin
				init0 = 1;
			end
			
			GETD: begin
				selLimit = 2;
				cen = 1;
				shiftEnDreg = 1;
			end
			
			GETN: begin
				selLimit = 3;
				cen = 1;
				shiftEnNreg = 1;
			end
			
			TRNS: begin
				en_out = 1;
				selLimit = 1;
				cen = 1;
				outValid = 1;
			end
			
			ERRC: begin
				if(serIn != 1)
					error = 1;
			end
			
		endcase
	end
	
	
endmodule
