`timescale 1ns / 1ps

module DevC(
    input clkC,
    input rst,
    input [63:0] sharedBus64,
    input readyB,
    output reg acceptedC,
    output reg [63:0] sharedBusTop
);

reg [1:0] stateC;
reg [1:0] state_nC;

always @(posedge clkC, negedge rst) begin
        if (rst == 1'b0) begin
            stateC <= 2'b00;
        end
        else begin
          stateC <= state_nC;
        end
end

always @ (stateC, readyB) begin
    state_nC = stateC;
    case (stateC)
    2'b00: begin 
        if (readyB == 1'b1) begin
            state_nC = 2'b01;
            //sharedBusTop = 64'd0;
            acceptedC = 1'b0;
        end
        acceptedC = 1'b0; 
    end
    2'b01: begin
        sharedBusTop = sharedBus64;
        acceptedC = 1'b1;
        state_nC = 2'b00;
    end
    endcase
end
endmodule
