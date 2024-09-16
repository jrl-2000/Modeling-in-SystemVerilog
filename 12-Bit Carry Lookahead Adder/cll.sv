`timescale 1ns / 1ps



module cll(
    input c,
    input [2:0] g, //for the 3 FAPG Modules 3 bit numbers
    input [2:0] p, //for the 3 FAPG Modules 3 bit numbers
    output [2:0] c_i
    );

    //Wires

//The carry output Boolean function of each stage in a 4 stage carry lookahead adder
assign c_i[0] = g[0] | (p[0] & c);
assign c_i[1] = g[1] | (p[1] & c_i[0]);
//assign c_i[2] = g[2] | (p[2] & c_i[1]);
assign c_i[2] = g[2] | (p[2] & c_i[1]);


endmodule
