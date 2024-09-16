`timescale 1ns/1ns

module CLA_3b_tb();

  logic[2:0] A,B;
  logic Cin=0;
  wire[2:0] S;
  wire Co;

  CLA_3b uut (.A(A), .B(B), .Cin(Cin), .S(S), .Co(Co));


  initial begin 

 A = 3'b000;
 B = 3'b111;
 Cin = 1'b1;
 
 #10;
 A = 3'b000;
 B = 3'b000;
 Cin = 1'b0;
 
 #10;
 A = 3'b110;
 B = 3'b011;
 Cin = 1'b1;
 
 #10;
 A = 3'b110;
 B = 3'b010;
 Cin = 1'b0;
 
  #10;
 A = 3'b000;
 B = 3'b000;
 Cin = 1'b0;
 
 #10;
 A = 3'b101;
 B = 3'b011;
 Cin = 1'b0;
 
 #10;
 A = 3'b111;
 B = 3'b000;
 Cin = 1'b0;
 #10
 
 $stop;

  end 

endmodule
