module shreg_1b (d, ser_in, clr, ld, sh, clk, q);
  input  d;
  input ser_in, clr, ld, sh, clk;
  output  q;
  reg  q;
  
  always @(posedge clk)
    if (clr)
      q <= 1'b0;
    else if (ld)
      q <= d;
    else if (sh)
      q <= ser_in;
        
endmodule
