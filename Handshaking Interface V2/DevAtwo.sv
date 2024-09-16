`timescale 1ns / 1ps

module DevAtwo(
    input clkA2,
    input rst,
    input gntA2,
    input acceptedB,
    output reg [7:0]sharedBus,
    output reg reqA2,
    output reg readyA2
);

reg [1:0] stateA2;
reg [1:0] state_nA2;
reg [7:0] dataOutA2;

always @(posedge clkA2, negedge rst) begin
        if (rst == 1'b0) begin
            stateA2 <= 3'b000;
            dataOutA2 <= 8'd0;
            sharedBus = 8'd0;

        end
        else begin
          stateA2 <= state_nA2;
          dataOutA2 <= $random;
        end
end

always @(posedge acceptedB) begin
    reqA2 = 1'b0;
end

always @(stateA2, gntA2) begin
    state_nA2 = stateA2;
    case (stateA2)
    2'b00: begin
        readyA2 = 1'b0;
        //dataOut = $random;
        reqA2 = 1'b1;
        state_nA2 = 2'b01;
        //sharedBus = 8'd0;
    end
    2'b01: begin
        if (gntA2 == 1'b1) begin
            readyA2 = 1'b1;
            state_nA2 = 2'b00;
            sharedBus = dataOutA2;
        end
    end
    endcase
end
endmodule