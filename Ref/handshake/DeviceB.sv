module DeviceB_ctrl(input clock, reset, readyA, acceptedC, cocount, output readyB, Inccount, acceptedB, loadreg);

	logic [2:0] pstate,nstate;
	
	parameter [2:0]          
							WAIT4READY	 	=  3'd0,
							Load			=  3'd1,
							ACC				=  3'd2,
							SEND2C			=  3'd3,
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
	always @ (pstate, readyA, acceptedC, cocount)
	  begin
	  
			case (pstate)

				WAIT4READY: begin 
					if (readyA) 
					nstate <= Load; 
					else
					nstate <= WAIT4READY;
				end
				
				Load: begin 
					nstate <= ACC; 
				end

				ACC: begin 
					nstate <= SEND2C; 
				end
				
				SEND2C: begin 
					if (acceptedC) 
					nstate <= COUNTING; 
					else
					nstate <= SEND2C;
				end
					
				COUNTING: begin
				if (cocount) 
					nstate <= WAIT4READY; 
					else
					nstate <= SEND2C ;
				end
				
				default: nstate <= WAIT4READY;
			endcase
	end
	
//////********************************************************//////
	
	assign readyB		  = (pstate==SEND2C)?       1: 0;
	assign acceptedB	  =  (pstate==ACC)?		1: 0;
	assign loadreg	      =  (pstate==Load)?		1: 0;
	assign Inccount       = (pstate==COUNTING)?   	1: 0;
	
	endmodule


//----------------------------------------------------------------------------------------

module REG63 (input  ld, clk, rst, input [63:0]inREG, output logic [63:0] outREG);

  always @(posedge clk, posedge rst) begin
    if(rst)
      outREG <= 0;
    else if(ld)
      outREG <= inREG;
  end
  
endmodule
//-------------------------------------------------------------------------------------------
module DeviceB_DP(input clk, rst, Inccount, loadreg, input [63:0] in_B, output cocount, output [15:0] out_B);

wire  [1:0]  cntout;
reg   [63:0]  outtemp;
//int  i;
REG63 register63(loadreg, clk, rst, in_B, outtemp);
counter  cnt(clk, rst, Inccount, cocount, cntout);
assign out_B=	 (cntout==2'd0)? outtemp[63:48]:
				 (cntout==2'd1)? outtemp[47:32]:
				 (cntout==2'd2)? outtemp[31:16]:
				 (cntout==2'd3)? outtemp[15:0]:
				 8'd0;
endmodule 

//-----------------------------------------------------------------------------------------

module DeviceB_TOP(input clk, rst, readyA, acceptedC, input [63:0] in_B, output [15:0] out_B, output readyB, acceptedB);

wire cocount;
wire Inccount;
wire loadreg;

DeviceB_ctrl    CTRLB(clk, rst, readyA, acceptedC, cocount, readyB, Inccount, acceptedB, loadreg);
DeviceB_DP		DPB(clk, rst, Inccount, loadreg, in_B, cocount, out_B);

endmodule