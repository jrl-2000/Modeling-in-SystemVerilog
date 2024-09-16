`timescale 1ns / 1ps

module mssddataPath(
    input clk,                  //Clock 
    input reset,                //Reset
    input serIn,                //Serial Input
    input [0:1]d,               //2-bit Destination
    input dataCom,              //DataCom flag from Controller
    output reg p0,              //Port 0
    output reg p1,              //Port 1
    output reg p2,              //Port 2
    output reg p3               //Port 3
);


always @(posedge clk, serIn, negedge reset, dataCom) begin
        if (reset || !dataCom) begin //
            //reset state: Return everything to 0
            p0 = 1'b0;
            p1 = 1'b0;
            p2 = 1'b0;
            p3 = 1'b0;
        end

        else if (dataCom) begin
            //assign the ports to serIn with Conditionals. Makes sure there are no hanging ports
            p0 = (d == 2'b00) ? serIn: 1'b0;
            p1 = (d == 2'b01) ? serIn: 1'b0;
            p2 = (d == 2'b10) ? serIn: 1'b0;
            p3 = (d == 2'b11) ? serIn: 1'b0;
        end
    end
endmodule