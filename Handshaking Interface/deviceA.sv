`timescale 1ns / 1ps

module deviceA (
    input clkA,
    input reset,
    input gntA,
    input acceptedB,
    output reg [63:0]sharedBus,
    output reg reqA,
    output reg readyA
);

    reg [15:0] dataOut0;
    reg [15:0] dataOut1;
    reg [15:0] dataOut2;
    reg [15:0] dataOut3;
    reg [2:0] stateA;
    reg [2:0] state_nA;
    

    always @(posedge clkA, negedge reset) begin
        if (reset == 1'b0) begin
            stateA <= 3'b000;
        end
        else begin
          stateA <= state_nA;
        end        
    end

    always @(gntA) begin
      
    end
    always @ (stateA, gntA, acceptedB) begin
        if (acceptedB) begin
          reqA = 1'b0;
        end
        state_nA = stateA;
        case (stateA)
        3'b000: begin
          dataOut0 = $random;
          if (acceptedB == 1'b1) begin
            readyA = 1'b0;
            reqA = 1'b0;
          end
          state_nA = 3'b001;
        end
        3'b001: begin
          dataOut1 = $random;
          state_nA = 3'b010;
        end
        3'b010: begin
          dataOut2 = $random;
          state_nA = 3'b011;
        end
        3'b011: begin
          dataOut3 = $random;
          state_nA = 3'b100;
        end
        3'b100: begin
          reqA = 1'b1;
          
          state_nA = 3'b101;
        end
        3'b101: begin
          if (gntA) begin
            //sharedBus <= {dataOut3, dataOut2, dataOut1, dataOut0};
            state_nA = 3'b000;
            readyA = 1'b1;

          end
        end
        endcase
        sharedBus =  (3'b101 && gntA) ? {dataOut3, dataOut2, dataOut1, dataOut0} : 64'b0;
    end   
endmodule