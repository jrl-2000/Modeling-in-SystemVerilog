`timescale 1ns / 1ps

module DevAone(
    input clkA1,
    input rst,
    input gntA1,
    input acceptedB,
    output reg [7:0]sharedBus,
    output reg reqA1,
    output reg readyA1
);

reg [1:0] stateA1;
reg [1:0] state_nA1;
reg [7:0] dataOutA1;

always @(posedge clkA1, negedge rst) begin
        if (rst == 1'b0) begin
            stateA1 <= 3'b000;
            dataOutA1 <= 8'd0;
            sharedBus = 8'd0;
        end
        else begin
          stateA1 <= state_nA1;
          dataOutA1 = $random;
        end
end

always @(posedge acceptedB) begin
    reqA1 = 1'b0;
end

always @(stateA1, gntA1) begin
    state_nA1 = stateA1;
    case (stateA1)
    2'b00: begin
        readyA1 = 1'b0;
        reqA1 = 1'b1;
        state_nA1 = 2'b01;
        //sharedBus = 8'd0; 
    end
    2'b01: begin
        if (gntA1 == 1'b1) begin
            readyA1 = 1'b1;
            state_nA1 = 2'b00;
            sharedBus = dataOutA1;
        end
    end
    endcase
end
endmodule