module DeviceC_ctrl(input clock, reset, readyB, acceptedD, cocount, output readyC, Inccount, acceptedC, loadreg);

	logic [2:0] pstate,nstate;
	
	parameter [2:0]          
							WAIT4READY	 	=  3'd0,
							Load			=  3'd1,
							ACC				=  3'd2,
							SEND2D			=  3'd3,
							COUNTING		=  3'd4;

//////********************Sequential part***********************//////							
	always @(posedge clock, posedge reset) begin
	  if ( reset)
	  pstate <= WAIT4READY;
	  else
	  pstate <=nstate;
	end
//////********************************************************//////


//////********************Combinational part***********************//////		
	always @ (pstate, readyB, acceptedD, cocount)
	  begin
	  
			case (pstate)

				WAIT4READY: begin 
					if (readyB) 
					nstate <= Load; 
					else
					nstate <= WAIT4READY;
				end
				
				Load: begin 
					nstate <= ACC; 
				end

				ACC: begin 
					nstate <= SEND2D; 
				end
				
				SEND2D: begin 
					if (acceptedD) 
					nstate <= COUNTING; 
					else
					nstate <= SEND2D;
				end
					
				COUNTING: begin
				if (cocount) 
					nstate <= WAIT4READY; 
					else
					nstate <= SEND2D ;
				end
				
				default: nstate <= WAIT4READY;
			endcase
	end
	
//////********************************************************//////
	
	assign readyC		  = (pstate==SEND2D)?       1: 0;
	assign acceptedC	  =  (pstate==ACC)?		1: 0;
	assign loadreg	      =  (pstate==Load)?		1: 0;
	assign Inccount       = (pstate==COUNTING)?   	1: 0;
	
	endmodule


//----------------------------------------------------------------------------------------

module counter2 (input clk, rst, counnt_en, output cocount, output logic countout);
/////////////////////////////Controller Counter///////////////////////		
		always @ (posedge clk, posedge rst) begin
				if (rst)
					countout <= 1'd0;
					else 
					if (counnt_en)
					countout <= countout + 1;
		end  
	assign cocount= (countout==1'd1)? 1'b1: 1'b0;
endmodule
//----------------------------------------------------------------------------------------

module REG16 (input  ld, clk, rst, input [15:0]inREG, output logic [15:0] outREG);

  always @(posedge clk, posedge rst) begin
    if(rst)
      outREG <= 0;
    else if(ld)
      outREG <= inREG;
  end
  
endmodule
//-------------------------------------------------------------------------------------------
module DeviceC_DP(input clk, rst, Inccount, loadreg, input [15:0] in_C, output cocount, output [7:0] out_C);

wire   cntout;
reg   [15:0]  outtemp;
//int  i;
REG16 register16(loadreg, clk, rst, in_C, outtemp);
counter2  cnt(clk, rst, Inccount, cocount, cntout);
assign out_C=	 (cntout==2'd0)? outtemp[15:8]:
				 (cntout==2'd1)? outtemp[7:0]:
				 8'd0;
endmodule 

//-----------------------------------------------------------------------------------------

module DeviceC_TOP(input clk, rst, readyB, acceptedD, input [15:0] in_C, output [7:0] out_C, output readyC, acceptedC);

wire cocount;
wire Inccount;
wire loadreg;

DeviceC_ctrl    CTRLB(clk, rst, readyB, acceptedD, cocount, readyC, Inccount, acceptedC, loadreg);
DeviceC_DP		DPB(clk, rst, Inccount, loadreg, in_C, cocount, out_C);

endmodule