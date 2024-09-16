module counter_3b (cnt, cen, ldcnt, clk, co, q);
  input[2:0]cnt;
  input cen, ldcnt, clk;
  output co;
  output[2:0] q;
  reg [2:0] q;
  always @(posedge clk)
  begin
     if(ldcnt==1)
       q<=cnt;
     else if(cen==1)
       q<=q+1;
  end
  
  assign co=(q==3'b111)? 1: 0;
endmodule
  
  
    
