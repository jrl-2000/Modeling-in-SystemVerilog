module FA_PG(
    input X, Y, Cin,
    output P, G, S
);

	assign P = X ^ Y; 
	assign G = X & Y;	
	assign S = P ^ Cin;
	
endmodule
	