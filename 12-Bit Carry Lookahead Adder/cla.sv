`timescale 1ns / 1ps


module cla(
    input c, //starting carry value
    input [7:0] x, //1st number to add
    input [7:0] y, //2nd number to add
    output c12, 
    output [7:0] s
    );

wire [3:0] c_i; //intermediate c only need a 4 bits as we start with one as the input
wire [2:0] g;
wire [2:0] p;
assign c_i[0] = c;
assign c12 = c_i[3];
genvar i;
generate 
     for(i=0; i<3; i=i+1) begin : fapg
        fapg fapg_inst (.x(x[i]), .y(y[i]), .c(c_i[i]), .p(p[i]), .g(g[i]), .s(s[i]));
        
     end
endgenerate

cll cll_inst(
    .c(c),
    .g(g),
    .p(p),
    .c_i(c_i[3:1])
);


endmodule 
