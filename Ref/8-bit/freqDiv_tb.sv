`timescale 1 ns/100 ps

module freqDiv_tb();
			reg clk=1'b1, rst;
			wire clkOut; 
  
  freqDiv uut(.clk(clk), .rst(rst), .clkOut(clkOut));
  

  always #5 clk=~clk;

  
  initial begin 
	  #3  rst=1'b1;
    #14 rst=1'b0;	
	  #200;

  end

  
endmodule
