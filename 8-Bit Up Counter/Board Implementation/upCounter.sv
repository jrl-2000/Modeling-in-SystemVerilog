`timescale 1ns / 1ps

module upCounter (
			input [7:0] parIn, 
			input clk, rst, ci, ld, cen,
			output logic [7:0] parOut, 
			output logic co 
		);

	always @( posedge clk, negedge rst ) begin	
      if (!rst) begin
				parOut <= 8'b0;
			end
      else if( ld )
         parOut <= parIn;
      else if (cen || ci) begin
				parOut <= parOut + 1;
			end
	end		
	assign co=(parOut==8'b1111_1111)? 1'b1 : 1'b0;



endmodule