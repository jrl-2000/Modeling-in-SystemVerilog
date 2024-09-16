`timescale 1ns / 1ps


module write(
    input clk, //clk
    input rst,  //reset
    input a,    //a from RAM
    output reg w    //w o/p to Result
    );
    
    reg [2:0] state; //state machine
    reg [2:0] state_n; //state next
    
    
    
    always @ (clk, posedge rst, a) begin
        if (rst) begin
            state <= 3'b001; //RESET CHECK FOR 1
        end
        else begin
        state <= state_n; //SEQUENTIAL STATES
        end
    end
    
    //Gonna need a state machine
    //AT LEAST 5 STATES FOR 01110
    //
    always @ (state, a, clk, w) begin //update sensitivity list
        state_n = state; //UPDATE STATES
        case (state)
        3'b000: begin
            if (a == 1'b0) begin //0
                state_n = 3'b001;
                w = 1'b0; 
            end
            else begin
                state_n = 3'b000;
                w = 1'b0;
            end
      end
      
      3'b001: begin
            if (a == 1'b1) begin //1
                state_n = 3'b010;
                w = 1'b0;
            end
            else begin
                state_n = 3'b001;
                w = 1'b0;
            end
      end
      
      3'b010: begin
            if (a == 1'b1) begin //1
                state_n = 3'b011;
                w = 1'b0;
            end
            else begin
                state_n = 3'b000;
                w = 1'b0;
            end
      end
      3'b011: begin
            if (a == 1'b1) begin //1
                state_n = 3'b100;
                w = 1'b0;
            end
            else begin
                state_n = 3'b000;
                w = 1'b0;
            end
      end
      3'b100: begin
            if (a == 1'b0) begin //0
                state_n = 3'b001;
                w = 1'b1;           //set 1 flag //esle write 0 for w
            end
            else begin
                state_n = 3'b000;
                w = 1'b0;
            end
      end      
      
    endcase
    end
endmodule 