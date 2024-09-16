`timescale 1ns / 1ps

module deviceD(
    input clkD,
    input reset,
    input readyC,
    input [7:0] sharedBusCD,
    output reg acceptedD,
    output reg [7:0]  printd0,
    output reg [7:0]  printd1
    );

    reg [4:0] counterD;

    reg [3:0] stateD;
    reg [3:0] state_nD;

    always @(posedge clkD, negedge reset) begin
        if (reset == 1'b0) begin
            stateD <= 3'b000;
        end
        else begin
          stateD <= state_nD;
        end        
    end

    always @ (stateD, readyC) begin

        state_nD = stateD;
        case (stateD)
        4'b0000: begin
          //printd0 = sharedBusCD;
          if (readyC == 1'b1) begin
            printd0 = sharedBusCD;
            //acceptedD = 1'b1;
            state_nD = 4'b0001;
          end
        end
        4'b0001: begin
          printd1 = sharedBusCD;
          state_nD = 4'b0000;
        end
        endcase
    end
    // always @(readyC) begin
    //   counterD = 5'b00000;
    // end


    always @ (posedge clkD, negedge reset) begin
      if (reset == 1'b0) begin
        counterD = 5'b00000;
      end
      else if (counterD == 5'b10100) begin
        counterD <= 5'b00000;
        acceptedD <= 1'b1;
      end
    else begin
      counterD <= counterD + 1;
      acceptedD <= 0;
    end
    end

      // $display("%d" dataFinalD0);
      // $display("%d" dataFinalD1);


endmodule
