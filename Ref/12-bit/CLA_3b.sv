`timescale 1ns/1ns
module CLA_3b(
  input [2:0] A, B, 
  input Cin, 
  output [2:0] S,
  output Co
);

	
	wire [3:0] C;
	wire [2:0] P, G;
	
	genvar i;
	generate
		for (i=0; i<3; i=i+1) begin : FA_PGs
			FA_PG FA_PG_inst(.X(A[i]), .Y(B[i]), .Cin(C[i]), .P(P[i]), .G(G[i]), .S(S[i]));		
		end
	endgenerate
	
	CLL_3b CLL_3b_inst( .G(G), .P(P), .Cin(Cin), .C(C[3:1]));

  assign C[0] = Cin;
	assign Co = C[3];
	
endmodule


