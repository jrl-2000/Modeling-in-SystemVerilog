// Negin Safari --- hw1 solution
module counter #(
	parameter n = 12
)
(	
	input clk,
	input rst,
	input cen,
	input init0,
	input [n-1:0] limit,
	
	output endCnt

);	
	reg [n-1:0] cnt;

	always @(posedge clk) begin
	
		if(rst)
			cnt <= 0;
		else if(init0 || endCnt)
			cnt <= 0;
		else if(cen)
			cnt <= cnt + 1;
		else 
			cnt <= cnt;
			
	end
	
	assign endCnt = (cnt == limit) ? 1 : 0;

endmodule
