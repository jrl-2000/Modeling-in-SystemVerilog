`timescale 1ns / 1ps

// Jonathan Lopez
// ECE 5720
// Modeling and Synthesis of Digital Systems using Verilog
// Homework # 1
// Multi-channel Synchronous Serial Communication Demultiplexer (MSSD)

module top (
    input clk,              //Clock
    input reset,            //Reset
    input serIn,            //Serial Input
    output error,           //Error Flag
    output outValid,        //OutValid Flag
    output [0:1] d,         //2-bit destination
    output p0,              // Port 0
    output p1,              //Port 1
    output p2,              //Port 2
    output p3               //Port 3
);

//intermediates
wire [0:3] bCounter; // Byte Counter 

//Instantiation of the Datapath Module for the MSSD
    mssddataPath mssddp1(
        .clk(clk),
        .reset(reset),
        .serIn(serIn),
        .d(d),
        .dataCom(dataCom),
        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3));
        
//Instantiation of the Control Module for the MSSD         
     mssdControl mmsdCtrl1 (
        .clk(clk),
        .reset(reset),
        .serIn(serIn),
        .error(error),
        .dest(d),
        .bCounter(bCounter),
        .dataCom(dataCom),
        .outValid(outValid));
        
endmodule