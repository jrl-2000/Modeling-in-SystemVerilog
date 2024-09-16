`timescale 1ns/100ps

module upCounter (
			input [3:0] parIn, 
			input clk, rst, ci, ld, cen,
			output logic [3:0] parOut, 
			output logic co 
		);

	always @( posedge clk, posedge rst ) begin	
      if (rst) begin
				parOut <= 4'b0;
			end
      else if( ld )
         parOut <= parIn;
      else if (cen || ci) begin
				parOut <= parOut + 1;
			end
	end		
	assign co=(parOut==4'b1111)? 1'b1 : 1'b0;



endmodule
