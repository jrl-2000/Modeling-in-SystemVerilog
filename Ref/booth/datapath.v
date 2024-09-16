module datapath(y,x,ldy,lda,sha,cla,ldx,shx,ldx_1,shx_1,is_add,is_sub,sel,clk,next_op,p);
  input [3:0] x,y;
  input ldy,lda,sha,cla,ldx,shx,ldx_1,shx_1,is_add,is_sub,sel,clk;
  output [1:0] next_op;
  output [3:0]p;
  wire [3:0] a,b,s,x_out;
  wire x_1_out;
  reg_4b reg_y(y,ldy,clk,b);
  subadd_4b subadd(a,b,is_add,is_sub,s);
  shreg_4b shreg_a(s,a[3],cla,lda,sha,clk,a);
  shreg_4b shreg_x(x,a[0],1'b0,ldx,shx,clk,x_out);
  shreg_1b shreg_x_1(1'b0,x_out[0],cla,ldx_1,shx_1,clk,x_1_out);
  mux_2_to_1 mux(a,x_out,sel,p);
  assign next_op={x_out[0],x_1_out};
endmodule
