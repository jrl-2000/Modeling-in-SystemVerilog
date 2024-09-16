`timescale 1ns / 1ps

//Datapath Module
module assumer4Datapath(
    input clk,
    input rst,
    input startAR4,
    input setRAR4,
    output reg beginAR4,
    output reg readyAR4
    );

    always @ (setRAR4, startAR4) begin
        if (startAR4) begin
            beginAR4 = 1'b1;
            //readyAR4 = 1'b0;
        end
        else if (!startAR4) begin
            beginAR4 = 1'b0;
            //readyAR4 = 1'b1;
        end
        else if (setRAR4 == 1'b1) begin
            readyAR4 = 1'b1;
        end
        else if (!setRAR4) begin
          readyAR4 = 1'b0;
        end
    end
endmodule