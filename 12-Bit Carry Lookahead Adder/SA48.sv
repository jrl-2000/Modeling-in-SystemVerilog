`timescale 1ns / 1ps
//Jonathan Lopez
//ECE 5720 Midterm Q2
//Top module

module SA48(
    input clk,                      //sync CLK
    input rst,                      //Async Reset
    input [11:0] inBusA,            //Bus for data in A channel
    input [11:0] inBusB,            //Bus for data in B channel
    input startChunks,              //Flag from assignment for starting the flow of data into the SA48
    input ci,                       //Carry in input adds 1 to the result
    output [47:0] outBus,           //Output bus where the final answer will reside
    output resultReady,             //Flag for the result being ready to read from Q2 instructions
    output co                       // carry out
    );

//Wires to connect instantiations of DP and CTRLR
   wire loadReady;
   wire threeNybblesFlag1;
   wire threeNybblesFlag2;
   wire threeNybblesFlag3;
   wire threeNybblesFlag4;

    //Controller Instantiation
    SA48Controller SA48Controller1(
        .clk(clk),
        .rst(rst),
        .inBusA(inBusA),
        .inBusB(inBusB),
        .startChunks(startChunks),
        .loadReady(loadReady),
        .threeNybblesFlag1(threeNybblesFlag1),
        .threeNybblesFlag2(threeNybblesFlag2),
        .threeNybblesFlag3(threeNybblesFlag3),
        .threeNybblesFlag4(threeNybblesFlag4),
        .resultReady(resultReady)
    );

    //Datapath Instantiation
    SA48Datapath SA48Datapath1(
        .inBusA(inBusA),
        .inBusB(inBusB),
        .threeNybblesFlag1(threeNybblesFlag1),
        .threeNybblesFlag2(threeNybblesFlag2),
        .threeNybblesFlag3(threeNybblesFlag3),
        .threeNybblesFlag4(threeNybblesFlag4),
        .loadReady(loadReady),
        .ci48(ci),
        .outBus(outBus),
        .co(co)
    );
endmodule
