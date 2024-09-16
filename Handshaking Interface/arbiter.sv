`timescale 1ns / 1ps

module arbiter(
    input clkA,
    input reset,
    input reqA,
    input [63:0] sharedBus,
    output reg gntA
    );

    reg [3:0]counter;
    always @(posedge reqA) begin
      counter = 4'b0000;
    end

    

    always @ (posedge clkA, negedge reset) begin
      if (reset == 1'b0) begin
        counter = 4'b0000;
      end
      else if (counter == 4'b1010) begin
        counter <= 4'b0000;
        gntA = 1'b1;
      end

      else begin
      counter <= counter + 1;
      gntA = 1'b0;
      end 
    end
endmodule
