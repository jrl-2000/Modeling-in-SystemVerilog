`timescale 1ns / 1ps

module deviceB (
    input clkB,
    input reset,
    input [63:0] sharedBus,
    input readyA,
    input acceptedC,
    output reg acceptedB,
    output reg readyB,
    output reg [15:0] sharedBusBC
);
    reg [15:0] dataSplitC0;
    reg [15:0] dataSplitC1;
    reg [15:0] dataSplitC2;
    reg [15:0] dataSplitC3;



  

    reg [2:0] stateB;
    reg [2:0] state_nB;
    

    always @(posedge clkB, negedge reset) begin
        if (reset == 1'b0) begin
            stateB <= 3'b000;
        end
        else begin
          stateB <= state_nB;
        end        
    end

    always @ (stateB, readyA) begin
        state_nB = stateB;
        case (stateB) 
        3'b000: begin
            if (readyA) begin
                dataSplitC0 <= sharedBus [15:0];
                dataSplitC1 <= sharedBus [31:16];
                dataSplitC2 <= sharedBus [47:32];
                dataSplitC3 <= sharedBus [63:48];
                //acceptedB <= 1'b1;
                //readyB <= 1'b1;
                state_nB <= 3'b001;
            end
            // else begin
            //    readyB <= 1'b0;
            //    acceptedB <= 1'b0;
            // end
        end
        3'b001: begin
            sharedBusBC = dataSplitC0;

            state_nB = 3'b010;     
        end
        3'b010: begin
            sharedBusBC = dataSplitC1;
      
            state_nB = 3'b011;  
        end
        3'b011: begin
            sharedBusBC = dataSplitC2;

            state_nB = 3'b100;  
        end
        3'b100: begin
            sharedBusBC = dataSplitC3;
            state_nB = 3'b000;        
        end
        endcase 
        acceptedB = (readyA == 1'b1);
        readyB = (stateB == 3'b001);
    end
endmodule