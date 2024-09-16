`timescale 1ns / 1ps


module toptb(
    );

    reg clkA1 = 1;
    reg clkA2 = 1;
    reg clkB = 1;
    reg clkC = 1;
    reg rst;
    reg [63:0] sharedBusTop;

top UUT(
    .clkA1(clkA1),
    .clkA2(clkA2),
    .clkB(clkB),
    .clkC(clkC),
    .rst(rst),
    .sharedBusTop(sharedBusTop)
);


always
begin
    clkA1 = ~clkA1;
    #2;
end

always
begin
    clkA2 = ~clkA2;
    #4;
end

always
begin
    clkB = ~clkB;
    #2;
end

always
begin
    clkC = ~clkC;
    #1;
end

initial begin
  rst = 1'b0;
  #2;
  rst = 1'b1;
  #100;
  $finish;
end

endmodule
