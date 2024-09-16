`timescale 1ns / 1ps

//Top VAM16
module top (
    input clk,
    input rst,
    input [31:0] bus32,
    input startSignal,
    output reg [31:0] rsltW,
    output reg readyPulse
);

//Regs
reg [7:0] inA;
reg [7:0] inB;
reg [15:0] outW;
reg startSignal;
reg readyFlag;



VAMdatapath DPinst0(
    .inA(inA),
    .inB(inB),
    .readyFlag(readyFlag),
    .outW(outW),
    .readyPulse(readyPulse)
);

VAMcontroller ctrlrInst0(
    .clk(clk),
    .rst(rst),
    .startSignal(startSignal),
    .outW(outW),
    .bus32(bus32),
    .rsltW(rsltW),
    .readyFlag(readyFlag),
    .inA(inA),
    .inB(inB)
);

    
endmodule