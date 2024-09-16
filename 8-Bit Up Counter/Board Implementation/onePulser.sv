`timescale 1ns / 1ps

module onePulser(
    input clk,
    input rst,
    input btnIn,
    output reg pulser
    );

    reg [1:0] state;
    reg [1:0] state_n;

    always @(posedge clk, negedge rst) begin
        if (rst == 1'b0) begin
            state <= 2'b00;
        end
        else begin
            state <= state_n;
        end
    end
    always @(state, btnIn, clk) begin
        state_n = state;
        case (state)
        2'b00: begin
            if (btnIn == 1'b1) begin
                pulser = 1'b1;
                state_n = 2'b01;
            end
            else begin
                pulser = 1'b0;
                state_n = 2'b00;
            end
        end
        2'b01: begin
            if (btnIn == 1'b0) begin
                pulser = 1'b0;
                state_n = 2'b00;
            end
            else begin
                pulser = 1'b1;
                state_n = 2'b01;
            end
        end            
        endcase
    end
endmodule