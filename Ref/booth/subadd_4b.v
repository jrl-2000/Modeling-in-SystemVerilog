module subadd_4b(a,y,is_add,is_sub,p);
  input [3:0]a,y;
  input is_add,is_sub;
  output [3:0] p;
  assign p=(is_add)?(a+y):(is_sub)?(a-y): 4'd0;
endmodule

