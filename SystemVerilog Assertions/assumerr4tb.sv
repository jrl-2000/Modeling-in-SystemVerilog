`timescale 1ns / 1ps

module assumerr4tb(
    );

    reg clk;
    reg rst;
    //reg signed [15:0] A;
    //reg signed [15:0] X;
    reg [7:0] swData;
    reg startAR4;
    reg readyAR4;
    reg signed [31:0] outAR4;
    reg GetA;
    reg GetX;

    assumer4 UUT(
        .clk(clk),
        .rst(rst),
        .swData(swData),
        .startAR4(startAR4),
        .GetA(GetA),
        .GetX(GetX),
        .readyAR4(readyAR4)
    );


//Simluate the CLK
    always
    begin
    clk = 1'b1;
    #1;
    clk = 1'b0;
    #1;
    end

    initial begin
      GetA = 1'b0;
      GetX = 1'b0;
      rst = 1'b0;
      #2;
      rst = 1'b1;
      #2;
      rst = 1'b0; //test rst
      #2;
      swData = 8'b0000_0000;
      
      //startAR4 = 1'b1;
      //   A = -17;
      //   X = 9;
      #2;
      //startAR4 = 1'b0;
      GetA = 1'b1;
      #2;
      GetA = 1'b0;
      #2;
      swData = 8'b1111_1111;
      #2;
      GetX = 1'b1;
      #2;
      GetX = 1'b0;
      #2;
      swData = 8'b0001_0001;
      #2;
      GetA = 1'b1;
      #2;
      GetA = 1'b0;
      #2;
      swData = 8'b1111_0111;
      #2;
      GetX = 1'b1;
      #2;
      GetX = 1'b0;
      #2;
      startAR4 = 1'b1;
      #100;
      $finish;
    end
endmodule
