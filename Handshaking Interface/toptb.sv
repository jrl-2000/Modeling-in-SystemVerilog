`timescale 1ns / 1ps

module toptb(
    );

    reg clkA = 1;
    reg clkB = 1;
    reg clkC = 1;
    reg clkD = 1;
    reg reset;

    reg [7:0] printd0;
    reg [7:0] printd1;



    top UUT(
        .clkA(clkA),
        .clkB(clkB),
        .clkC(clkC),
        .clkD(clkD),
        .reset(reset),
        .printd0(printd0),
        .printd1(printd1)
    );

    always #4
    clkA = ~clkA;

    always #3
    clkB = ~clkB;

    always #2
    clkC = ~clkC;

    always #1
    clkD = ~clkD;



    initial begin
        
        reset = 1'b0;
        #2;
        reset = 1'b1;
        #1;
        repeat(100)begin
        
        $display("%h", printd0);
        $display("%h", printd1);
        #4;
        end  
    end




endmodule
