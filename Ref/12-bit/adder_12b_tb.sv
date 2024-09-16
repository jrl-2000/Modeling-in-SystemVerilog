`timescale 1ns/100ps

module adder_12b_tb();

logic[11:0] X, Y;
logic Cin=1'b0;
wire[11:0] S;
wire Co;

adder_12b uut (.X(X), .Y(Y), .Cin(Cin), .S(S), .Co(Co));


initial begin 

 X = -1;
 Y = 0;
 Cin = 1'b1;
 
 #20;
 X = 0;
 Y = 11;
 Cin = 1'b0;
 
 #20;
 X = -7;
 Y = -13;
 Cin = 1'b0;
 
  #20;
 X = 13;
 Y = -6;
 Cin = 1'b1;
 
 #20;
 
 $stop;

end 



 
endmodule
