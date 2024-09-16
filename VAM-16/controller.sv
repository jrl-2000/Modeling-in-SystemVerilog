`timescale 1ns / 1ps

module VAMcontroller (
    input clk,
    input rst,
    input startSignal,
    input [15:0] outW,
    input [31:0] bus32,
    output reg [31:0] rsltW,
    output reg readyFlag,
    output reg [7:0] inA,
    output reg [7:0] inB
);

reg [15:0] opndA;
reg [15:0] opndB;
reg [4:0] state;
reg [4:0] state_n;
reg [3:0] i_a;
reg [3:0] i_b;
reg [3:0] remainZer0A;
reg [3:0] remainZer0B;
reg [4:0] remainZeroTotal;
reg [4:0] concatNumZero;
reg [31:0] rsltW_i;

parameter offset = 8;

always @(posedge clk, negedge rst) begin
    if (rst == 1'b0) begin
        state <= 5'b00000;
        
    end
    else begin
        state <= state_n;
    end
end

always @(state, startSignal, readyFlag, bus32, opndA, opndB, outW) begin
    state_n = state;
    case (state)
    5'b00000: begin
        if (startSignal == 1'b1) begin
            state_n = 5'b00001;
				rsltW <= 32'd0;
				i_a <= 4'd15;
				i_b <= 4'd15;
				//offset <= 4'd8;
				remainZer0A <= 4'd0;
				remainZer0B <= 4'd0;
				remainZeroTotal <= 5'd0;
				rsltW_i <= 32'd0;
				concatNumZero <= 5'd0;
            readyFlag = 1'b0;         
        end
        else begin
            state_n = 5'b00000;
        end
    end 
    5'b00001: begin
        if (startSignal == 1'b0) begin
            state_n = 5'b00010;         
        end
        else begin
            state_n = 5'b00001;
        end
    end
    5'b00010: begin
        opndA =  bus32 [31:16];
        opndB =  bus32 [15:0];
        state_n = 5'b00011;
    end
    5'b00011: begin
        if (opndA [15:8] == 8'b0000_0000) begin
            //inA = opndA [7:0];
            remainZer0A = 4'b0000;
            state_n = 5'b00100;
        end
        else begin
            state_n = 5'b00101;
        end
    end
    5'b00101: begin //15
    //7+8 for index
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            remainZer0A = 4'b0000;
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b00110;
        end
    end
    5'b00110: begin//14
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b00111;
        end
    end
    5'b00111: begin //13
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b01000;
        end
    end
    5'b01000: begin //12
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b01001;
        end
    end
    5'b01001: begin //11
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b01010;
        end
    end
    5'b01010: begin //10
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b01011;
        end
    end
    5'b01011: begin //9
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b01100;
        end
    end
    5'b01100: begin //8
        if (opndA[i_a] == 1'b1) begin
            state_n = 5'b00100;
            
        end
        else begin
            --i_a;
            remainZer0A++;
            state_n = 5'b00100;
        end
    end

    //opndB TIME
    5'b00100: begin
        if (opndB [15:8] == 8'b0000_0000) begin
            //inB = opndB [7:0];
            remainZer0B = 4'b0000;
            state_n = 5'b10101;
        end
        else begin
            state_n = 5'b01101;
        end
        
    end
    5'b01101: begin //15 b
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b01110;
        end
    end
    5'b01110: begin //14
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
           
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b01111;
        end
    end
    5'b01111: begin //13
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b10000;
        end
    end
    5'b10000: begin //12
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b10001;
        end
    end
    5'b10001: begin //11
       if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b10010;
        end 
    end
    5'b10010: begin //10
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b10011;
        end 
    end
    5'b10011: begin //9
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b;
            remainZer0B++;
            state_n = 5'b10100;
        end 
    end
    5'b10100: begin //8
        if (opndB[i_b] == 1'b1) begin
            state_n = 5'b10101;
            
        end
        else begin
            --i_b; //support by SV
            remainZer0B++;
            state_n = 5'b10101;
        end 
    end
    5'b10101: begin
        //new to system verilog
        // [index- :how wide the data is to take to the right as noted by by the neg sign]
        if (opndA [15:8] == 8'b0000_0000) begin
            inA = opndA [7:0];
            inB = opndB[i_b-:offset];
        end
        else if (opndB [15:8] == 8'b0000_0000) begin
            inB = opndB [7:0];
            inA = opndA[i_a-:offset];
        end
        else if ((opndA [15:8] == 8'b0000_0000) && (opndB [15:8] == 8'b0000_0000)) begin
            inA = opndA [7:0];
            inB = opndB [7:0];
        end
        else begin
            inA = opndA[i_a-:offset];
            inB = opndB[i_b-:offset];
        end
        state_n = 5'b11001;
    end
    5'b11001: begin
        rsltW_i = outW;
        remainZeroTotal = remainZer0B + remainZer0A;
        state_n = 5'b10110;
    end
    5'b10110: begin
        state_n = 5'b10111;
    end
    5'b10111: begin
        if (concatNumZero == remainZeroTotal) begin
            rsltW = rsltW_i;
            state_n = 5'b11000;          
        end
        else begin
            rsltW_i = {rsltW_i, 1'b0};
            concatNumZero++;
            state_n = 5'b10110;
        end
    end
    5'b11000: begin
        readyFlag = 1'b1;
        if (outW != 16'd0) begin
            state_n = 5'b00000;
        end
    end
        //default: 
    endcase
end
endmodule