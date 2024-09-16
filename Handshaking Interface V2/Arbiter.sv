`timescale 1ns / 1ps

module Arbiter(
    input reqA1,
    input reqA2,
    output reg gntA1,
    output reg gntA2
);

always @(reqA1, reqA2) begin
    if ((reqA1 == 1'b1) && (reqA2 == 1'b0)) begin
        gntA1 = 1'b1;
    end
    else if ((reqA1 == 1'b0) && (reqA2 == 1'b1)) begin
        gntA2 = 1'b1;
    end
    else if ((reqA1 == 1'b1) && (reqA2 == 1'b1)) begin
        gntA1 = 1'b1;
    end
    else begin
        gntA1 = 1'b0;
        gntA2 = 1'b0;
    end
end
endmodule