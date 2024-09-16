`timescale 1ns/1ns
module FA_PG(
    input X, Y, Cin,
    output P, G, S
);

	assign #1 P = X ^ Y; 
	assign #1 G = X & Y;	
	assign #1 S = P ^ Cin;
	
endmodule
	