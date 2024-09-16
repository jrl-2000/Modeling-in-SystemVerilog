`timescale 1ns / 1ps



module toptb();
//Starting Conditions
    reg clk = 1;
    reg reset = 0;
    reg serIn = 1;
    
    //Simulate the CLOCK
    always #1
    clk = ~clk;
    
    //Top Module Instantiation
    top uut (
        .clk(clk),
        .reset(reset),
        .serIn(serIn),
        .error(error),
        .outValid(outValid),
        .d(d),
        .p0(p0),
        .p1(p1),
        .p2(p2),
        .p3(p3));
 
 //One test bench for each Port and varying byte amounts
 // 0,1,2,3 
       
//// P0
////o/p 1111
//    initial begin
//        reset <= 1'b0; //reset
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b1;
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b0;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b0;  //serIn broguht low
//        #2;
//        serIn <= 1'b0; //d[0]
//        #2;
//        serIn <= 1'b0;  //d[1]
//        #2;
//        serIn <= 1'b0; //bCounter[0]
//        #2;
//        serIn <= 1'b0; //bCounter[1]
//        #2;
//        serIn <= 1'b0; //bCounter[2]
//        #2;
//        serIn <= 1'b1; //bCounter[3]
//        // how many bytes? = 1
//        #2;
//        serIn <= 1'b1; //1
//        #2;
//        serIn <= 1'b1; //1
//        #2;
//        serIn <= 1'b1; //1
//        #2;
//        serIn <= 1'b1; //1
//        //1111
//    end
  

    
//// P1
////o/p 0111_0110
//    initial begin
//        reset <= 1'b0; //reset
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b1;
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b0;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b0;  //serIn broguht low
//        #2;
//        serIn <= 1'b0; //d[0]
//        #2;
//        serIn <= 1'b1;  //d[1]
//        #2;
//        serIn <= 1'b0; //bCounter[0]
//        #2;
//        serIn <= 1'b0;//bCounter[1]
//        #2;
//        serIn <= 1'b1;//bCounter[2] 
//        #2;
//        serIn <= 1'b0; //bCounter[3]
//        // how many bytes? = 2
//        #2;
//        serIn <= 1'b0;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b0;
//        #2
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b0; 
//        //0111_0110
//    end


//// P2
////o/p 1101
//    initial begin
//        reset <= 1'b0; //reset
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b1;
//        serIn <= 1'b1;
//        #2;
//        reset <= 1'b0;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b1;
//        #2;
//        serIn <= 1'b0;  //serIn broguht low
//        #2;
//        serIn <= 1'b1; //d[0]
//        #2;
//        serIn <= 1'b0;  //d[1]
//        #2;
//        serIn <= 1'b0; //bCounter[0]
//        #2;
//        serIn <= 1'b0; //bCounter[1]
//        #2;
//        serIn <= 1'b0; //bCounter[2]
//        #2;
//        serIn <= 1'b1; //bCounter[3]
//        // how many bytes? = 1
//        #2;
//        serIn <= 1'b1; //1
//        #2;
//        serIn <= 1'b1; //1
//        #2;
//        serIn <= 1'b0; //1
//        #2;
//        serIn <= 1'b1; //1
//        //1101
//    end
  

    
// P3
//o/p 1010_0101
    initial begin
        reset <= 1'b0; //reset
        serIn <= 1'b1;
        #2;
        reset <= 1'b1;
        serIn <= 1'b1;
        #2;
        reset <= 1'b0;
        serIn <= 1'b1;
        #2;
        serIn <= 1'b1;
        #2;
        serIn <= 1'b0;  //serIn broguht low
        #2;
        serIn <= 1'b1; //d[0]
        #2;
        serIn <= 1'b1;  //d[1]
        #2;
        serIn <= 1'b0; //bCounter[0]
        #2;
        serIn <= 1'b0;//bCounter[1]
        #2;
        serIn <= 1'b1;//bCounter[2] 
        #2;
        serIn <= 1'b0; //bCounter[3]
        // how many bytes? = 2
        #2;
        serIn <= 1'b1;
        #2;
        serIn <= 1'b0;
        #2;
        serIn <= 1'b1;
        #2;
        serIn <= 1'b0;
        #2;
        serIn <= 1'b0;
        #2
        serIn <= 1'b1;
        #2;
        serIn <= 1'b0;
        #2;
        serIn <= 1'b1;
        
        //11010_0101
//        #2;
//        serIn <= 1'b0;
    end



endmodule