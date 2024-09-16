`timescale 1ns / 1ps

module DevB (
    input clkB,
    input rst,
    input [7:0] sharedBus,
    input readyA1,
    input readyA2,
    input acceptedC,
    output reg acceptedB,
    output reg  [63:0] sharedBus64,
    output reg readyB
);


reg [1:0] stateB;
reg [1:0] state_nB;
reg [63:0] concatenate;
reg [3:0] counter;

always @(posedge clkB, negedge rst) begin
        if (rst == 1'b0) begin
            stateB <= 2'b00;
            counter = 4'b0000;
        end
        else begin
          stateB <= state_nB;
        end        
end


always @(stateB, acceptedC, readyA1, readyA2) begin
    state_nB = stateB;
    case (stateB)
    2'b00:begin
        if ((readyA1 == 1'b1) || (readyA2 == 1'b1)) begin
            //sharedBus64 = 64'd0;
            //concatenate = 64'd0;
            readyB = 1'b0;
            acceptedB = 1'b0;
            state_nB = 2'b01;
        end
        sharedBus64 = 64'd0;
        concatenate = 64'd0;
        readyB = 1'b0;
        acceptedB = 1'b0;
    end 
    2'b01: begin
        if ((counter != 4'b1000)) begin //&& ((readyA1 == 1'b1) || (readyA2 == 1'b1))
            concatenate = concatenate << 8;
            counter ++;
            concatenate [7:0] = sharedBus;
            state_nB = 2'b01;
        end
        else if (counter == 4'b1000) begin
            counter = 3'b000;
            state_nB = 2'b10;            
        end
    end
    2'b10: begin
        sharedBus64 = concatenate;
        readyB = 1'b1;
        acceptedB = 1'b1;
        if (acceptedC == 1'b1) begin
            state_nB = 2'b00;
        end
        else begin
            state_nB = 2'b10;
        end
    end
    endcase
end    
endmodule