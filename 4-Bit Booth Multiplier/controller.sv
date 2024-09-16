`timescale 1ns / 1ps
module controller(
    input clk,
    input reset,
    input qzero,
    input [3:0] q,
    input qneg1,
    input [1:0] count,
    output reg load,
    output reg add,
    output reg sub,
    output reg shift,
    output reg dc
    );

always @(posedge clk) begin
    load = 1'b1;

    
    if (qzero == 1'b1 && qneg1 == 1'b0) begin
        sub = 1'b1;
        // a = a - multiplicandM;
    end
    else begin
      sub = 1'b0;
    end

    if (qzero == 1'b0 && qneg1 == 1'b1) begin
        add = 1'b1;
        // a = a + multiplicandM;
    end
    else begin
      add = 1'b0;
    end
    
     if ((qzero == 1'b0 && qneg1 == 1'b0) ||  (qzero == 1'b1 && qneg1 == 1'b1)) begin
        add = 1'b0;
        sub = 1'b0;
    end
    

    if ((sub == 1'b0) || (add == 1'b0)) begin
        shift = 1'b1;
        
    end
    else begin
      shift = 1'b0;
    end
    if (count != 0) begin
        dc = 1'b1;
    end
    else if (count == 2'b0) begin
        dc = 1'b0;
    end

end
endmodule
