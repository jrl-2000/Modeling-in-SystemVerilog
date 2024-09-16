`timescale 1ns / 1ps

module toptb3();

reg clk = 1;
reg rst;
reg a;
reg w;
reg [19:0] RAM [0:6];
reg [19:0] result;

//use code that was in the mditerm exam
integer f;
integer i;

write uut(
    .clk(clk),
    .rst(rst),
    .a(a),
    .w(w));

//Simulate CLK
    always #1
    clk = ~clk;

      initial begin
        a = 0;
        rst = 0;
        #1;
        rst = 1; //test reset
        #1;
        rst = 0;
        $readmemb("test.dat", RAM); //use example code
        for (i = 20; i >= 0; --i) begin
            a = RAM[0][i];
            result[i] = w;
            #1;            
        end
        f = $fopen("result.dat", "w");
        a = 0;
        $fwrite(f, "%b", result);
        $fclose(f);
        $finish; //finish sim after done with 1st line of test.dat which it does
       end

          
endmodule