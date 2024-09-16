
module Radix4	(clk, rst, startAR4, A, B, busy, outAR4, readyAR4);

	input  clk, rst, startAR4;
	input  [15:0] A, B;

	
	output busy, readyAR4;
	output [31:0] outAR4;
	
	wire ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, ld_MAC, busy,readyAR4;
	wire [1:0] sel_MUX;
	wire [2:0] op;
		
			
	Datapath DP (clk, rst, A, B, ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, sel_MUX, op, readyAR4, outAR4);

	Controller CU (clk, rst, startAR4, op, ld_A, sh_A, ld_B, ld_P, zero_P, sel_AS, sel_MUX, busy, readyAR4);
	
//-----------------------------------------------ASSERTIONS-----------------------------------------------------
//-------------------------------------Uncomment these assertions when running simulation-----------------------  
// This is not the only way to apply assertion, you may have used other kind of assertions 
//that do the same	
	// property ready_check;
      // @(posedge clk) startAR4 |-> ##9 $stable(readyAR4); ///Alternative way is using $stable////
    // endproperty
    
    // assert property (ready_check)
      // else $display("failed at time : ", $time);  //*/
	  
	  
	 // property readyWrong_check;
      // @(posedge clk) startAR4 |-> ##2 $stable(readyAR4); ///Alternative way is using $stable////
    // endproperty
    
    // assert property (readyWrong_check)
      // else $display("It seems like it is working ");  //*/
	
	
endmodule
	  
	  