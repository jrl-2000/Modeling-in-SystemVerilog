`timescale 1ns / 1ps

module SA48Controller(
    input clk,                  //sync CLK
    input rst,                  //Async Reset
    input [11:0]inBusA,         //Bus for data in A channel
    input [11:0]inBusB,         //Bus for data in B channel
    input startChunks,          //Flag from assignment for starting the flow of data into the SA48
    output reg loadReady,       //flag to bring in the load to concatenate
    output reg threeNybblesFlag1,       //Flags for each 3 nybbles sent on both channels
    output reg threeNybblesFlag2,
    output reg threeNybblesFlag3,
    output reg threeNybblesFlag4,
    output reg resultReady      //Flag for the result being ready to read from Q2 instructions
    );
    reg [2:0]state; //3 BIT STATE MACHINE need 6 states
    reg [2:0]state_n; //state NEXT
    //gonna put the FSM in the controller this time

//Update state machine
    always @(posedge clk, negedge rst) begin
        if (rst == 1'b0) begin
          state <= 3'b000;
        end 
        else begin
          state <= state_n;
        end
    end
//state machine to transfer in the 3 nybbles each clock cycle
//1 nybble = 4 bits
//4bits * 3nybbles = 12 bits
//12 bits for each state after 12*4 = 48 bits
//last state is for upading the last vlaue from the 12bit adder

    always @ (startChunks, state) begin
        state_n = state;
        threeNybblesFlag1 = 1'b0;
        threeNybblesFlag2 = 1'b0;
        threeNybblesFlag3 = 1'b0;
        threeNybblesFlag4 = 1'b0;
        case (state)
        3'b000: begin
            if (startChunks == 1'b1) begin //wait until start chunks becomes 1
                state_n = 3'b001; 
                loadReady = 1'b0;
                threeNybblesFlag1 = 1'b0;
                threeNybblesFlag2 = 1'b0;
                threeNybblesFlag3 = 1'b0;
                threeNybblesFlag4 = 1'b0;        
            end
            else begin
                state_n = 3'b000;   
            end
        end
        3'b001: begin                               //SETTING EACH FLAG and returing it to 0 once out of the state
            threeNybblesFlag1 = 1'b1;             
            state_n = 3'b010;
        end
        3'b010: begin
            threeNybblesFlag2 = 1'b1;                       // Note to self: they all stay high???
            state_n = 3'b011;
            threeNybblesFlag1 = 1'b0;
            
        end
        3'b011: begin
            threeNybblesFlag3 = 1'b1;
            state_n = 3'b100;
            threeNybblesFlag2 = 1'b0;
            
        end
        3'b100: begin
            threeNybblesFlag4 = 1'b1;
            threeNybblesFlag3 = 1'b0;
            state_n = 3'b101;  
            loadReady = 1'b1;                           //need a signal to get the last adder values to change loadReady!!!!!
        end
        3'b101: begin
            threeNybblesFlag4 = 1'b0;
            state_n = 3'b110;
            resultReady = 1'b1;                     //set result Ready for the Midterm requirement
        end
        3'b110: begin
            state_n = 3'b000;                   //reset state without hitting the rst signal; ready for more inputs
            threeNybblesFlag1 = 1'b0;
            threeNybblesFlag2 = 1'b0;
            threeNybblesFlag3 = 1'b0;
            threeNybblesFlag4 = 1'b0;
        end
        endcase
    end
endmodule
