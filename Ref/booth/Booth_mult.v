module booth_mult (x, y, start, reset, clk, p, done);
  input [3:0]x,y;
  input start, reset, clk;
  output [3:0]p;
  output done;
  
  wire ldy,lda,sha,cla,ldx,shx,ldx_1,shx_1,is_add,is_sub,sel;
  wire [1:0]next_op;
  
  datapath dp(y,x,ldy,lda,sha,cla,ldx,shx,ldx_1,shx_1,is_add,is_sub,sel,clk,next_op,p);
  controller cu(start, reset, next_op, clk, cla, ldx, lda, sha, shx, shx_1, ldy, is_add, is_sub, sel, done);
  
endmodule