module booth_mult_TB ();
  reg [3:0]x,y;
  reg start=0;
  reg reset=0;
  reg clk=0;
  wire [3:0]p;
  wire done;
  
  booth_mult MUT(x, y, start, reset, clk, p, done);
  
  initial begin
    repeat(300) #100 clk=~clk;
  end
  
  initial begin
    reset=1;
    #110;
    reset=0;
    repeat(5)
    begin
      #100;
      y=$random%16;
      x=$random%16;
      #10;
      start=1;
      #300;
      start=0;
      #5000;
    end
  end
  
endmodule
    
    
  
