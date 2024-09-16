`timescale 1ns / 1ps

module stacktb(
    );

    reg clk = 1;
    reg rst;
    reg push;
    reg pop;
    reg [31:0] write_data;
    reg [31:0] read_data;
    reg stack_full;
    reg stack_empty;

    integer i;

    stack UUT(
        .write_data(write_data),
        .push(push),
        .pop(pop),
        .clk(clk),
        .rst(rst),
        .read_data(read_data),
        .stack_full(stack_full),
        .stack_empty(stack_empty)
    );
//Simulate CLK
always #1
clk = ~clk;

initial begin
  rst = 1'b1;
  #2;
  rst = 1'b0;
  #2;
  //TEST EMPTY STACK
  assert_empty : assert(stack_empty == 1'b1) begin
    //pass
    $display("Correct Stack is Empty Here");
  end
  else begin
    //fail
    $display("Stack is NOT Empty");
  end
  for (i = 100; i >= 0; --i) begin
    write_data = $random;
    #2;
    push = 1'b1;
    #2;
    push = 1'b0;
    #2;
  end
  #2;
  //TEST FULL STACK
  assert_full : assert(stack_full == 1'b1) begin
    //pass
    $display("Correct Stack is Full Here");
  end
  else begin
    //fail
    $display("Stack is NOT Full");
  end
  #2;
  pop = 1'b0;
  push = 1'b0;
  write_data = 13;
  #2;
  push = 1'b1;
  #2;
  push = 1'b0;
  write_data = 24;
  #2;
  push = 1'b1; //testing no value get added to a full stack
  #2;
  push = 1'b0;
  #2;
  pop = 1'b1;
  #2;
  pop = 1'b0;
  #2;
  pop = 1'b1;
  #2;
  pop = 1'b0;
  #2;
  push = 1'b1;
  #2;
  push = 1'b0;
  #2;
  push = 1'b1;
  #2;
  push = 1'b0;
  #2;
   //TEST FULL STACK
  assert_full1 : assert(stack_full == 1'b1) begin
    //pass
    $display("Correct Stack is Full Here");
  end
  else begin
    //fail
    $display("Stack is NOT Full");
  end
  #2;
  pop = 1'b1;
  #2;
  pop = 1'b0;
  #2;
  //TEST Answer STACK
  assert_answer : assert(read_data == 24) begin
    //pass
    $display("Correct Stack element is 24");
  end
  else begin
    //fail
    $display("Stack elemnt is NOT 24");
  end
  #2;
  $finish;
end
endmodule