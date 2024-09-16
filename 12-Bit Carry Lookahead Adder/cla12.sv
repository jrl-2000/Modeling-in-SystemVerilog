`timescale 1ns / 1ps

module cla12(
    input [11:0] x,
    input [11:0] y,
    input c,
    output [11:0] s,
    output c12
);

    wire [3:0] c_i;
    assign c_i[0] = c;
    assign c12 = c_i[3];

    genvar i;

    generate
        for(i=0; i<4; i=i+1) begin: cla
            cla cla_inst(.c(c_i[i]), .x(x[((i*3)+2):(i*3)]), .y(y[((i*3)+2):(i*3)]), .c12(c_i[i+1]), .s(s[((i*3)+2):(i*3)]));
        end
    endgenerate

endmodule
