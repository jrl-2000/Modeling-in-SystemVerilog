`timescale 1ns / 1ps

module optb(
    );

    reg clk = 1;
    reg rst;
    reg btnIn;
    reg pulser;

    onePulser UUT(
        .clk(clk),
        .rst(rst),
        .btnIn(btnIn),
        .pulser(pulser)
    );

    always #1 clk=~clk;

    initial begin
        rst = 1'b1;
        btnIn = 1'b0;
        #2;
        rst = 1'b0;
        #2;
        btnIn = 1'b1;
        #2;
        btnIn = 1'b0;
        #50;
        btnIn = 1'b1;
        #2;
        btnIn = 1'b0;
        #50;
    end






endmodule
