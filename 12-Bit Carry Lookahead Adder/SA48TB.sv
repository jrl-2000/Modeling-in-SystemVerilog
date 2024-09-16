`timescale 1ns / 1ps

module SA48TB();

//Regs
reg clk = 1;
reg rst;
reg [11:0] inBusA;
reg [11:0] inBusB;
reg startChunks;
reg ci;
reg resultReady;


//Wires
wire co;
wire [47:0] outBus;


//Unit Under testing
SA48 uut(
    .clk(clk),
    .rst(rst),
    .inBusA(inBusA),
    .inBusB(inBusB),
    .startChunks(startChunks),
    .ci(ci),
    .outBus(outBus),
    .resultReady(resultReady),
    .co(co)
);


//Simulate CLK
always #1
clk = ~clk;


initial begin
    ci = 1'b0;
    rst = 1'b0;
    resultReady = 1'b0;
    #2;
    rst = 1'b1; //testing reset
    startChunks = 1'b1; //start sending data //12 bit max is 4095
    inBusA = 12'd2049;
    inBusB = 12'd101;
    #2;
    startChunks = 1'b0;
    inBusA = 12'd13;
    inBusB = 12'd29;
    #2;
    inBusA = 12'd2000;
    inBusB = 12'd4095;
    #2;
    inBusA = 12'd32;
    inBusB = 12'd19;
    #2;
    inBusA = 12'd0;
    inBusB = 12'd0;
    #20;
    $finish;  // so it doesnt go on forever...

end
endmodule