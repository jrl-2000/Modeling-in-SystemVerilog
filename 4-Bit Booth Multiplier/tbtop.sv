`timescale 1ns / 1ps


module tbtop(
    );

    reg clk = 1;
    reg reset = 0;
    reg signed [3:0] M;
    reg signed [3:0] Q;
    reg signed [7:0] fp;


    top uut(
        .clk(clk),
        .reset(reset),
        .multiplicandM(M),
        .multiplierQ(Q),
        .finproduct(fp)
    );



    //Simulate the CLOCK
    always #1
    clk = ~clk;

    initial begin
        reset <= 1'b0; //reset
        #1;
        reset <= 1'b1;
        #1;
        reset <= 1'b0;
        #1;
        M = 4'b1101;
        Q = 4'b0101;
        #1;
        
    end
endmodule
