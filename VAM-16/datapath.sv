`timescale 1ns / 1ps

module VAMdatapath(
    input [7:0] inA,
    input [7:0] inB,
    input readyFlag,
    output reg [15:0] outW,
    output reg readyPulse
    );

//You do not need tyo implement the unsigned 8-bit array multiplier. Use the
//multiplication operator with 8-bit operands and a 16-bit result in an assign statement.
assign outW = inA * inB;

//ReadyPulse Flagger
always @(readyFlag) begin
    if (readyFlag == 1'b1) begin
        readyPulse = 1'b1;
    end
    else if (readyFlag == 1'b0) begin
        readyPulse = 1'b0;
    end

end
endmodule