`timescale 1ns / 1ps

module fourbitupc(
    input clk,                  //rising edge clock
    input rst,                  //asynchronous reset input
    input reg ld,                   //parallel load enable input
    input reg ci,
    input  reg cen,                  //up-count enable input
    input reg [3:0] parIn,          //4-bit parallel input
    output reg [3:0] parOut,    //4-bit parallel output //needs REG!
    output reg co                //carry-out that becomes 1 when counter reaches FF, and Ci is 1
    );
    
    //Regs
    reg [3:0] counter;         //Counter to reach F
    
    //Assign co carry out flag
    assign co = (counter == 4'hF) ? 1'b1 : 1'b0; //4'h means hex numbers
     always @ * begin
        parOut <= counter;               //set the par out to the up counter
     end  
    
    always @(posedge clk, negedge rst) begin
        if (rst == 0) begin
            //If the reset was hit reset the counter to 0 and the carry out to 0 and the ld and CEN, CI, etc.
            counter <= 4'h0;
            co <= 1'b0;
            ld <= 1'b0;
            parIn <= 4'b0000;
            parOut <= 4'b0000;
            cen <= 1'b0;
            ci = 1'b0;
        end
        else if (ld == 1'b1) begin
            counter <= parIn;               //Load the Parallel in
        end
        else if (cen == 1'b1) begin
            counter <= counter + 4'h1;      //increment the counter
        end
     end
     
endmodule
 