// Code your testbench here
// or browse Examples

module assumerr4tb(
    );

    reg clk;
    reg rst;
    reg signed [15:0] A;
    reg signed [15:0] X;
    reg startAR4;
    reg readyAR4;
    reg signed [31:0] outAR4;
  	reg setRAR4;

    assumer4Controller UUT(
        .clk(clk),
        .rst(rst),
        .beginAR4(startAR4),
        .A(A),
        .X(X),
        .setRAR4(readyAR4),
        .outAR4(outAR4)
    );



    always
    begin
    clk = 1'b1;
    #1;
    clk = 1'b0;
    #1;
    end

    initial begin
      rst = 1'b1;
      #2;
      rst = 1'b0;
      #2;
      rst = 1'b1;
      startAR4 = 1'b1;
      A = -17;
      X = 9;
      #2;
      startAR4 = 1'b0;
      #100;   
      assert_ready : assert(readyAR4 == 1'b1) begin
        //pass
        $display("Correct Ready Singal");
      end
      else begin
        //fail
        $display ("Not Ready");
      end
      
      assert_outAR4 : assert(outAR4 == -153) begin
        //pass
        $display("Correct Answer!");
      end
      else begin
        //fail
        $display ("Inocrrect Answer!");
      end

    end
  endmodule