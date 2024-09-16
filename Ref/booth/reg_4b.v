module reg_4b(y,ld,clk,q);
  input [3:0]y;
  input ld,clk;
  output[3:0]q;
  reg [3:0]q;
  always@(posedge clk)
    if(ld)
      q<=y;
      
  endmodule
