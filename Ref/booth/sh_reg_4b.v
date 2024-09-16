module shreg_4b (d, ser_in, clr, ld, sh, clk, q);
  input [3:0] d;
  input ser_in, clr, ld, sh, clk;
  output [3:0] q;
  reg [3:0] q;
  
  always @(posedge clk)
    if (clr)
      q <= 4'b0000;
    else if (ld)
      q <= d;
    else if (sh)
      q <= {ser_in, q[3:1]};
        
endmodule