`timescale 1ns / 1ps

//Jonathan Lopez
//ECE 5720 Final Exam
//Question 2

module stack(
    input [31:0] write_data,
    input push,
    input pop,
    input clk,
    input rst,
    output reg [31:0] read_data,
    output reg stack_full,
    output reg stack_empty
    );
  
    //Stack
    reg [31:0] STACK [0:99];
    reg [6:0] stack_pointer; //128 is within 100 range

    always @ (posedge clk, negedge rst) begin
        if (rst == 1'b1) begin
            stack_pointer = 7'b0000000;          
        end
        else begin
            if ((push == 1'b1) && (stack_full == 1'b0) && (stack_pointer != 7'b0000000) ) begin
                STACK[stack_pointer] = write_data;
                stack_pointer += 1'b1;             
            end
            else if ((push == 1'b1) && (stack_full == 1'b0) && (stack_pointer == 7'b0000000)) begin
                STACK[stack_pointer] = write_data;
                stack_pointer += 1'b1;
            end
            else if ((pop == 1'b1) && (stack_empty == 1'b0)) begin
                read_data = STACK[stack_pointer - 1];
                STACK[stack_pointer - 1] = 32'b0;
                stack_pointer -= 1'b1;
            end
        end                
    end
    assign stack_empty = (stack_pointer == 7'b0) ? 1 : 0;
    assign stack_full = (stack_pointer == 7'b1100100)? 1 : 0;
endmodule
