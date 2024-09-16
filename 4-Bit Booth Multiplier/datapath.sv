`timescale 1ns / 1ps
module datapath(
    input clk,
    input reset,
    input load,
    input add,
    input sub,
    input shift,
    input dc,
    input signed [3:0] multiplicandM,
    input signed [3:0] multiplierQ,
    output reg qzero,
    output reg [3:0] q,
    output reg qneg1,
    output reg [1:0] count,
    output reg signed [7:0] product
    );
    reg signed [3:0] a;
    reg signed [3:0] m;
    reg [1:0] state;
    reg [1:0] state_n;
    reg signed [8:0] combined; //9bit

//Update the State Machine
always @ (clk, reset) begin
    if (reset) begin
        state <= 2'b00;
    end    
    else begin
        state <= state_n;
    end    
end

always @ (state) begin
    state_n = state;
    case (state)
    2'b00: begin //loads
        if (load == 1'b1) begin
            q = multiplierQ; //load multiplier into Q
            m = multiplicandM;
            qzero = q[0];
            a = 4'b0000; // Set A to zero
            qneg1 = 1'b0; // set q-1 to zero
            count = 2'b11;
            state_n = 2'b01;
        end
    end
    2'b01: begin
        if (sub == 1'b1) begin
            a = a - m;
            combined = {a, q, qneg1};
            state_n = 2'b10;
        end
        else if (add == 1'b1) begin
            a = a + m;
            combined = {a, q, qneg1};
            state_n = 2'b10;
        end
        else begin
            state_n = 2'b10;
            combined = {a, q, qneg1};
        end
    end
    2'b10: begin
        if (shift == 1'b1) begin
            //combined = {a, q, qneg1};
            combined = combined >>> 1; //arithmetic shift to preserve the sign bit
            //postcombined = combined >>> 1; //arithmetic shift to preserve the sign bit
            a = combined [8:5];
            q = combined [4:1];
            qneg1 = combined [0];
            qzero = combined [1];
           
            if (dc == 1'b1) begin
                count = count - 1'b1;
                state_n = 2'b01;
            end
            else if (dc == 0) begin
                state_n = 2'b11;
            end
        end
    end
    2'b11: begin
        product = combined [8:1]; //cut off q-1
        state_n = 2'b00;
    end   
    endcase
    end
endmodule
