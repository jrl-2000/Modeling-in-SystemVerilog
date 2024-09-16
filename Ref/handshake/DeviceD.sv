module DeviceD_ctrl(input clock, reset, readyC, cocount, output acceptedD, Inccount, ld);

	logic [1:0] pstate,nstate;
	
	parameter [1:0]          
							WAIT4READYC	 	=  2'd0,
							LOAD			=  2'd1,
							Display			=  2'd2,
							WAIT 			=  2'd3;


//////********************Sequential part***********************//////							
	always @(posedge clock, posedge reset) begin
	  if ( reset)
	  pstate <= WAIT4READYC;
	  else
	  pstate <=nstate;
	end
//////********************************************************//////


//////********************Combinational part***********************//////		
	always @ (pstate, readyC, cocount)
	  begin
	  
			case (pstate)

				WAIT4READYC: begin 
					if (readyC) 
					nstate <= LOAD; 
					else
					nstate <= WAIT4READYC;
				end

				LOAD: begin 
					nstate <= Display;
				end
				
				Display: begin 
					nstate <= WAIT;
				end
				WAIT: begin 
					if (cocount) 
					nstate <= WAIT4READYC; 
					else
					nstate <= WAIT;
				end
			
				default: nstate <= WAIT4READYC;
			endcase
	end
	
//////********************************************************//////
	
	assign acceptedD	  =  (pstate==Display)?		1: 0;
	assign ld	  		=  (pstate==LOAD)?		1: 0;
	assign Inccount	      =  (pstate==WAIT)?		1: 0;	
endmodule
//---------------------------------------------------------------------
module counter3 (input clk, rst, counnt_en, output cocount, output logic [2:0] countout);
/////////////////////////////Controller Counter///////////////////////		
		always @ (posedge clk, posedge rst) begin
				if (rst || cocount)
					countout <= 3'd0;
					else 
					if (counnt_en)
					countout <= countout + 1;
		end  
	assign cocount= (countout==3'd5)? 1'b1: 1'b0;
endmodule
//--------------------------------------------------------------------------
module DeviceD_TOP(input clk, rst, readyC, input [7:0] in_D, output reg [7:0] out_D, output  acceptedD);

wire cocount, ld;
wire Inccount;
wire loadreg;
wire [2:0] cntout;

DeviceD_ctrl    CTRLD(clk, rst, readyC, cocount, acceptedD, Inccount, ld);
counter3  cnt(clk, rst, Inccount, cocount, cntout);
always @(posedge clk) begin
	if(rst)
		out_D <= 0;
	else if(ld)
		out_D <= in_D;
	else
		out_D <= out_D;
end

endmodule