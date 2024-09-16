module datapath(
	input clk,
	input rst,
	
	input [11:0] inBusA,
	input [11:0] inBusB,
	output reg [47:0] outBus,
	
	input init0,
	input shift_12bR
);

	wire [11:0] sum;
	wire co;
	reg ci;

	adder_12b ADD (.X(inBusA), .Y(inBusB), .Cin(ci), .S(sum), .Co(co));
	
	always @(posedge clk) begin
		if(rst)
			ci <= 0;
		else if(init0)
			ci <= 0;
		else 
			ci <= co;
	end
	
	always @(posedge clk) begin
		if(rst)
			outBus <= 0;
		else if(init0)
			outBus <= 0;
		else if(shift_12bR)
			outBus <= {sum, outBus[47:12]};
		else
			outBus <= outBus;
	end
	
endmodule