module DeviceA_ctrl(input clock, reset, start, gntA, acceptedB, cocount, output readyA, reqA, Inccount);

	logic [2:0] pstate,nstate;
	
	parameter [2:0]          
							WAIT4START	 	=  3'd0,
                            Counting		=  3'd1,
							GETBUS			=  3'd2,
							READY			=  3'd3;

//////********************Sequential part***********************//////							
	always @(posedge clock, posedge reset) begin
	  if ( reset)
	  pstate <= WAIT4START;
	  else
	  pstate <=nstate;
	end
//////********************************************************//////


//////********************Combinational part***********************//////		
	always @ (pstate, start, gntA, acceptedB, cocount)
	  begin
	  
			case (pstate)

				WAIT4START: begin 
					if (start) 
					nstate <= Counting; 
					else
					nstate <= WAIT4START;
				end

				Counting: begin 
					if (cocount) 
					nstate <= GETBUS; 
					else
					nstate <= Counting;
				end
				
				GETBUS: begin 
					if (gntA) 
					nstate <= READY; 
					else
					nstate <= GETBUS;
				end
				
				READY: begin
				if (acceptedB) 
					nstate <= Counting; 
					else
					nstate <=	READY ;
				end
				
				default: nstate <= WAIT4START;
			endcase
	end
	
//////********************************************************//////
	
	assign reqA		      = (pstate==GETBUS)?       1: 0;
	assign Inccount       = (pstate==Counting)?   	1: 0;
	assign readyA 		  = (pstate==READY)?	    1: 0;
	endmodule


//----------------------------------------------------------------------------------------
module dcd3to8( input [1:0] A, input en, output reg [0:3] I);

	always @(en, A) begin 
		I={4{1'b0}};
		if (en) I[A]=1'b1;
	end
endmodule
//-------------------------------------------------------------------------------------------

module counter (input clk, rst, counnt_en, output cocount, output logic [1:0] countout);
/////////////////////////////Controller Counter///////////////////////		
		always @ (posedge clk, posedge rst) begin
				if (rst)
					countout <= 2'd0;
					else 
					if (counnt_en)
					countout <= countout + 1;
		end  
	assign cocount= (countout==2'd3)? 1'b1: 1'b0;
endmodule
//-------------------------------------------------------------------------------------------

module REG (input  ld, clk, rst, input [15:0]inREG, output logic [15:0] outREG);

  always @(posedge clk, posedge rst) begin
    if(rst)
      outREG <= 0;
    else if(ld)
      outREG <= inREG;
  end
  
endmodule
//--------------------------------------------------------------------------------------------
module DeviceA_DP(input clk, rst, Inccount,input [15:0] in_A, output cocount, output [63:0] out_A);

wire  [1:0]  cntout;
wire  [3:0]  dcdout;
reg   [15:0]  outtemp [0:7];
//int  i;

dcd3to8  dcd( cntout, Inccount, dcdout);
counter  cnt(clk, rst, Inccount, cocount, cntout);

genvar i;
		generate
			for(i = 0; i<4; i = i+1)
			begin 
				REG regsrtrs(dcdout[i], clk, rst, in_A, outtemp[i]);
			end
		endgenerate

assign out_A= {outtemp[7], outtemp[6], outtemp[5], outtemp[4], outtemp[3], outtemp[2], outtemp[1], outtemp[0] };

endmodule

//----------------------------------------------------------------------------------------------------

module DeviceA_TOP(input clk, rst, start, gntA, acceptedB, input [15:0] in_A, output [63:0] out_A, output readyA, reqA);

wire cocount;
wire Inccount;

DeviceA_DP		DP(clk, rst, Inccount, in_A, cocount, out_A);
DeviceA_ctrl	CTRL(clk, rst, start, gntA, acceptedB, cocount, readyA, reqA, Inccount);

endmodule