`define   S0      4'b0000
`define   S1      4'b0001
`define   S2      4'b0010
`define   S3      4'b0011
`define   S4      4'b0100
`define   S5      4'b0101
`define   S6      4'b0110
`define   S7      4'b0111
`define   S8      4'b1000
`define   S9      4'b1001



module controller (start, rst, next_op, clk, cla, ldx, lda, sha, shx, shx_1, ldy, is_add, is_sub, sel, done);
  input start, rst, clk;
  input [1:0]next_op;
  output cla, ldx, lda, sha, shx, shx_1, ldy, is_add, is_sub, sel, done;
  reg cla, ldx, lda, sha, shx, shx_1, ldy, is_add, is_sub, sel, done;
  reg ldcnt,cen;
  wire co;
  reg [3:0] ps, ns;
  wire[2:0] counter_out;
  counter_3b counter(3'b100, cen, ldcnt, clk, co, counter_out);
  
  // Sequential part 
  always @(posedge clk)
    if (rst)
      ps <= 4'b0000;
    else
      ps <= ns;
      
      
  always @(ps or start)
  begin
    case (ps)
      `S0:  ns = start ? `S1 : `S0;
      `S1:  ns = `S2;
      `S2:  ns = `S3;
      `S3:  ns = (next_op==2'b10)? `S4:((next_op==2'b01)? `S5: `S6);
      `S4:  ns = `S6;
      `S5:  ns = `S6;
      `S6:  ns =(co==0)? `S7: `S8;
      `S7:  ns = `S3;
      `S8:  ns = `S9;
      `S9:  ns =`S0;
    endcase
  end
  
  always @(ps)
  begin
    {cla, ldx, lda, sha, shx, shx_1, ldy, is_add, sel, ldcnt, cen, done} = 12'd0;
    case (ps)
      `S0: ;
      `S1: {ldx, cla, ldcnt} = 3'b111;
      `S2: ldy = 1'b1;
      `S3: ;
      `S4: {is_sub, lda} = 2'b11;
      `S5: {is_add, lda} = 2'b11;
      `S6: {sha, shx, shx_1} = 3'b111;
      `S7: {cen} = 1'b1;
      `S8: {done, sel}=2'b10;
      `S9: {done, sel}=2'b11;
    endcase
  end
  
endmodule 


