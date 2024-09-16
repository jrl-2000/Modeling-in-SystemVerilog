`timescale 1ns / 1ps

module deviceC (
    input clkC,
    input reset,
    input [15:0] sharedBusBC,
    input readyB,
    input acceptedD,
    output reg acceptedC,
    output reg readyC,
    output reg [7:0] sharedBusCD
);

   
    reg [7:0] dataSplitD0;
    reg [7:0] dataSplitD1;
    reg [7:0] dataSplitD2;
    reg [7:0] dataSplitD3;
    reg [7:0] dataSplitD4;
    reg [7:0] dataSplitD5;
    reg [7:0] dataSplitD6;
    reg [7:0] dataSplitD7;
    
    

    reg [3:0] stateC;
    reg [3:0] state_nC;





// always @(readyB) begin
//     if (readyB == 1'b1) begin
//         dataSplitD0 = sharedBusBC [7:0];
//         dataSplitD1 = sharedBusBC [15:8];
//         //acceptedC = 1'b1;
//         readyC = 1'b1;
//     end
//     else begin
//         acceptedC = 1'b0;
//         readyC = 1'b0;
//         end
// end

always @(posedge clkC, negedge reset) begin
        if (reset == 1'b0) begin
            stateC <= 3'b000;
        end
        else begin
          stateC <= state_nC;
        end        
    end

always @ (stateC, readyB) begin
    readyC = 1'b0;
state_nC = stateC;
        case (stateC)
        4'b0000: begin
        if (readyB == 1'b1)begin
            dataSplitD0 = sharedBusBC [7:0];
            dataSplitD1 = sharedBusBC [15:8];
            acceptedC = 1'b1;
            readyC = 1'b1;
            state_nC = 4'b0001;
            end
        end
            
        4'b0001: begin
            acceptedC = 1'b0;
            //readyC = 1'b0;
            dataSplitD2 = sharedBusBC [7:0];
            dataSplitD3 = sharedBusBC [15:8];
            sharedBusCD = dataSplitD0;
            state_nC = 4'b0010;
        end      
        4'b0010: begin
            sharedBusCD = dataSplitD1;
            dataSplitD4 = sharedBusBC [7:0];
            dataSplitD5 = sharedBusBC [15:8];
            //readyC = 1'b0;
            state_nC = 4'b0011;
        end  
        4'b0011: begin
            sharedBusCD = dataSplitD2;
            dataSplitD6 = sharedBusBC [7:0];
            dataSplitD7 = sharedBusBC [15:8];
            state_nC = 4'b0100;

        end 
        4'b0100: begin
           sharedBusCD = dataSplitD3;
           state_nC = 4'b0101;
        end
        4'b0101: begin
           sharedBusCD = dataSplitD4;
           state_nC = 4'b0110;
        end
        4'b0110: begin
           sharedBusCD = dataSplitD5;
           state_nC = 4'b0111;
        end
        4'b0111: begin
           sharedBusCD = dataSplitD6;
           state_nC = 4'b1000;
        end
        4'b1000: begin
           sharedBusCD = dataSplitD7;
           state_nC = 4'b000;

        end


        endcase

    end
endmodule

