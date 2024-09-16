`timescale 1ns/1ns

module seqDetector01110(
  input clk, rst, a,
  output w
);
	
	output w;
	
	logic [2:0] ps;
  localparam [2:0] Idle = 3'b000,
                   got0 = 3'b001,
                   got01 = 3'b010,
                   got011 = 3'b011,
                   got0111 = 3'b100,
                   got01110 = 3'b101;
	
	// sequential 
	always@(posedge clk) begin
		if (rst) ps <= Idle;
		else 
			case(ps)
				Idle    : 
					if (a==1'b0 ) ps <= got0; 
					else ps <= Idle ;
				got0		 :
					if (a==1'b1 ) ps <= got01; 
					else ps <= got0 ;
				got01   :
					if (a==1'b1 ) ps <= got011; 
					else ps <= got0 ;
				got011  : 
					if (a==1'b1 ) ps <= got0111; 
					else ps <= got0 ;
				got0111 :
					if (a==1'b0 ) ps <= got01110; 
					else ps <= got0 ;
				got01110:	
					if (a==1'b1 ) ps <= got01; 
					else ps <= got0 ;
			endcase
	end

	assign w = (ps == got01110) ? 1 : 0;
	
endmodule 


module seqDetector01110_tb();

	reg clk=1'b1;
	reg rst;
	reg a;
	wire w;
	integer f;
	reg [19:0] mem[6:0];
	
	integer i; 
	integer j; 
	 
	integer m; 
	integer n;  
	
	reg [19:0] result[6:0];
	
	seqDetector01110 seqDetector01110_uut(clk, rst, a, w);

	always #5 clk <= ~clk;

	initial begin
		$readmemb("test.dat", mem);
		#3   rst=1;
		#13  rst=0;
	end
	

	initial begin
		#18;
		j=0;
		for(j=0; j<7; j=j+1) begin
		  for(i=19; i>-1; i=i-1) begin
		  	a = mem[j][i];
		  	#10;
		  end
		a = 1'bz;
		#50;
		end	
	end	

	initial begin
		#22;
		n=0;
		for(n=0; n<7; n=n+1) begin
		m=19;
		for(m=19; m>-1; m=m-1) begin
			result[n][m] = w;
			#10;
		end
		f = $fopen("result.dat","a");
		$fwrite(f,"%b\n",result[n]);
		$fclose(f);	
		#50;
		end
	end	

	
		

	
endmodule





