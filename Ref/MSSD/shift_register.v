// Negin Safari --- hw1 solution
module shift_register #(
	parameter n = 2
)
(
	input clk,
	input rst,
	input serInp,
	input shiftEnable,
	
	output reg [n-1:0] data
);
	
	always @(posedge clk) begin
	
		if(rst)
			data <= 0;
		else if(shiftEnable)
			data <= {data[n-2:0], serInp};
		else
			data <= data;
	
	end
	


endmodule
