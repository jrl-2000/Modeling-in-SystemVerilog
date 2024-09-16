`timescale 1ns / 1ps

module SA48Datapath(
    input [11:0]inBusA, //each 12 bit i/p
    input [11:0]inBusB,
    input threeNybblesFlag1, //flags from the controller for each 3nybbles sent
    input threeNybblesFlag2,
    input threeNybblesFlag3,
    input threeNybblesFlag4,
    input loadReady,            //flag yo bring in the load to concatenate
    input ci48,                 //inout carry in for the top level need to be in here and in the first 12 bit adder
    output reg [47:0] outBus,       //48 bit outbus with result to top module
    output reg co               //carry out to top module
    );  

    //Wires
    wire c12; //wire for the 12adder will be set to the ci48 from the top module

    //Regs
    reg [11:0] A121;     //12 bit adder
    reg [11:0] B121;     //12 bit adder
    reg [11:0] A122;     //12 bit adder
    reg [11:0] B122;     //12 bit adder
    reg [11:0] A123;     //12 bit adder
    reg [11:0] B123;     //12 bit adder
    reg [11:0] A124;     //12 bit adder
    reg [11:0] B124;     //12 bit adder
    reg [11:0] twelveResult1;   //Results from the adder
    reg [11:0] twelveResult2;
    reg [11:0] twelveResult3;
    reg [11:0] twelveResult4;
    reg ci12;

//only combinational in datapath
// MUX to use the adders
//this block only depends on the 4 flags and the loadReady frot he last one
//Always_comb was too sensitive only gonna do the singals that change here
    always @ (threeNybblesFlag1, threeNybblesFlag2, threeNybblesFlag3, threeNybblesFlag4, loadReady) begin
        if (threeNybblesFlag1 == 1'b1) begin //set carring in to the 48 bit one from the top
            A121 = inBusA;
            B121 = inBusB;          
        end
        else if (threeNybblesFlag2 == 1'b1) begin
            A122 = inBusA;
            B122 = inBusB;
        end
        else if (threeNybblesFlag3 == 1'b1) begin
            A123 = inBusA;
            B123 = inBusB;
        end
        else if (threeNybblesFlag4 == 1'b1) begin
            A124 = inBusA;
            B124 = inBusB;
        end
        else if (loadReady == 1'b1) begin
            //Concatenation of the outbus using the adder 1 at a time. 
            outBus [11:0] = twelveResult1;
            outBus [23:12] = twelveResult2;
            outBus [35:24] = twelveResult3;
            outBus [47:36] = twelveResult4;
        end
        else begin //reset carry values for the next run
            co = 1'b0;
            ci12 = 1'b0;
        end
    end

// 12 bit adder in Question 1
    cla12 cla12inst1(
        .x(A121),
        .y(B121),
        .c(ci48),
        .s(twelveResult1),
        .c12(c12)
);
// 12 bit adder in Question 1
    cla12 cla12inst2(
        .x(A122),
        .y(B122),
        .c(ci12),
        .s(twelveResult2),
        .c12(c12)
);
// 12 bit adder in Question 1
    cla12 cla12inst3(
        .x(A123),
        .y(B123),
        .c(ci12),
        .s(twelveResult3),
        .c12(c12)
);
// 12 bit adder in Question 1
    cla12 cla12inst4(
        .x(A124),
        .y(B124),
        .c(ci12),
        .s(twelveResult4),
        .c12(co)
);

endmodule