`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2023 03:14:29 AM
// Design Name: 
// Module Name: tbcla12
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tbcla12(
    );
//wires
wire [11:0] s;

//regs
reg [11:0]A;
reg [11:0]B;
reg c12;
reg c;

top uut(
    .x(A),
    .y(B),
    .c(c),
    .s(s),
    .c12(c12)
);

initial begin
    c = 1'b0; //intialize the first carry value
    //Test Cases
    //16 + 12 = 28
    A = 16;
    B = 12;
    #200;

    A = -31;
    B = -45;
    #200; 
    // //12 + 32 = 54
    // y = 8'd12;
    // x = 8'd32;
    // #2;
    // //66 + 400 = 466
    // y = 8'd66;
    // x = 8'd400;
    // #2;
    // //32 + 60 = 92
    // y = 8'd32;
    // x = 8'd60;
    // #2;

end
endmodule