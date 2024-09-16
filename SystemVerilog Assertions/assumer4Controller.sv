`timescale 1ns / 1ps

//Controller Module
module assumer4Controller(
    input clk,
    input rst,
    input beginAR4,
    input [7:0] swData,
	  input GetA,
	  input GetX,
    output reg setRAR4, //SFlapg to Datapath for Ready
    output reg signed [31:0] outAR4 //Ouput Product
    );

    reg [4:0]state; //state
    reg [4:0]state_n; //state NEXT
	 
	  reg signed [15:0] A;
	  reg signed [15:0] X;

    reg signed [16:0] appendZer0LSB; //to append 0 for our 17 bit number
    //Regs to slpit up the 17 bit number overlapping 1 on each side
    //Zero is assumed for the first grouping
    reg [2:0] split0;
    reg [2:0] split1;
    reg [2:0] split2;
    reg [2:0] split3;
    reg [2:0] split4;
    reg [2:0] split5;
    reg [2:0] split6;
    reg [2:0] split7;

    //Regs for each of the parity products
    //NEED TO BE SIGNED OR ELSE THE ARITHMETIC SHIFT WON'T WORK
    //Will be added to each other after the slpit reg find the OPCODES
    reg signed [31:0] parityP0;
    reg signed [31:0] parityP1;
    reg signed [31:0] parityP2;
    reg signed [31:0] parityP3;
    reg signed [31:0] parityP4;
    reg signed [31:0] parityP5;
    reg signed [31:0] parityP6;
    reg signed [31:0] parityP7;

    
//Set and Update State Machine
    always @(posedge clk, negedge rst) begin
      if (!rst) begin
        state <= 5'b10011; 
      end
      else begin
        state <= state_n;
      end
    end

    always @ (state, beginAR4, GetA, GetX) begin
        state_n = state;
        case (state)
        5'b00000: begin
            if (beginAR4 == 1'b1) begin
              state_n = 5'b00001;
              outAR4 = 32'd0;
              setRAR4 = 1'b0;
            end
        end
        5'b00001: begin
          appendZer0LSB = {X, 1'b0}; //Concatenate a zero on X
          //Split it up 3 bits each
          split0 = appendZer0LSB [2:0];
          split1 = appendZer0LSB [4:2];
          split2 = appendZer0LSB [6:4];
          split3 = appendZer0LSB [8:6];
          split4 = appendZer0LSB [10:8];
          split5 = appendZer0LSB [12:10];
          split6 = appendZer0LSB [14:12];
          split7 = appendZer0LSB [16:14];
          state_n = 5'b00010;
        end
        5'b00010: begin
          //set parity products to 0 intialally 
          setRAR4 = 1'b0;
          parityP0 = 32'd0;
          parityP1 = 32'd0;
          parityP2 = 32'd0;
          parityP3 = 32'd0;
          parityP4 = 32'd0;
          parityP5 = 32'd0;
          parityP6 = 32'd0;
          parityP7 = 32'd0;
          state_n = 5'b00011;                         
        end
        5'b00011: begin
          //FIND THE OPCODES FOR THE PARITY PRODUCTS REPEATEDLY
          //START WITH MSB FIRST
          if ((split7 == 3'b000) || (split7 == 3'b111)) begin
                parityP7 = 32'd0;
            end
          else if ((split7 == 3'b001) || (split7 == 3'b010)) begin
                parityP7 = parityP7 + A;
            end
          else if ((split7 == 3'b110) || (split7 == 3'b101)) begin
                parityP7 = parityP7 + (-1 * A);
            end
          else if (split7 == 3'b100) begin
                parityP7 = parityP7 + (-2 * A);
            end
          else if (split7 == 3'b011) begin
                parityP7 = parityP7 + (2 * A);
                //FIRST ONE IS A SPECIAL CASE WHERE IT GETS ADDED TO ITSELF
            end
          state_n = 00100;
        end
        5'b00100: begin
          //Arithmetically shift to preserve sign bit
          parityP7 = parityP7 <<< 2;
          state_n = 5'b00101;
        end
        5'b00101: begin
          if ((split6 == 3'b000) || (split6 == 3'b111)) begin
                parityP6 = 32'd0;
            end
          else if ((split6 == 3'b001) || (split6 == 3'b010)) begin
                parityP6 = parityP7 + A;
            end
          else if ((split6 == 3'b110) || (split6 == 3'b101)) begin
                parityP6 = parityP7 + (-1 * A);
            end
          else if (split6 == 3'b100) begin
                parityP6 = parityP7 + (-2 * A);
            end
          else if (split6 == 3'b011) begin
                parityP6 = parityP7 + (2 * A); 
                //The rest addup on the previous parity product
            end
          state_n = 5'b00110;
        end
        5'b00110: begin
          parityP6 = parityP6 <<< 2;
          state_n = 5'b00111;
        end
        5'b00111: begin
          if ((split5 == 3'b000) || (split5 == 3'b111)) begin
                parityP5 = 32'd0;
            end
          else if ((split5 == 3'b001) || (split5 == 3'b010)) begin
                parityP5 = parityP6 + A;
            end
          else if ((split5 == 3'b110) || (split5 == 3'b101)) begin
                parityP5 = parityP6 + (-1 * A);
            end
          else if (split5 == 3'b100) begin
                parityP5 = parityP6 + (-2 * A);
            end
          else if (split5 == 3'b011) begin
                parityP5 = parityP6 + (2 * A);
            end
          state_n = 5'b01000;
        end
        5'b01000: begin
          parityP5 = parityP5 <<< 2;
          state_n = 5'b01001;
        end
        5'b01001: begin
          if ((split4 == 3'b000) || (split4 == 3'b111)) begin
                parityP4 = 32'd0;
            end
          else if ((split4 == 3'b001) || (split4 == 3'b010)) begin
                parityP4 = parityP5 + A;
            end
          else if ((split4 == 3'b110) || (split4 == 3'b101)) begin
                parityP4 = parityP5 + (-1 * A);
            end
          else if (split4 == 3'b100) begin
                parityP4 = parityP5 + (-2 * A);
            end
          else if (split4 == 3'b011) begin
                parityP4 = parityP5 + (2 * A);
            end
          state_n = 5'b01010;
        end
        5'b01010: begin
          parityP4 = parityP4 <<< 2;
          state_n = 5'b01011;
        end
        5'b01011: begin
          if ((split3 == 3'b000) || (split3 == 3'b111)) begin
                parityP3 = 32'd0;
            end
          else if ((split3 == 3'b001) || (split3 == 3'b010)) begin
                parityP3 = parityP4 + A;
            end
          else if ((split3 == 3'b110) || (split3 == 3'b101)) begin
                parityP3 = parityP4 + (-1 * A);
            end
          else if (split3 == 3'b100) begin
                parityP3 = parityP4 + (-2 * A);
            end
          else if (split3 == 3'b011) begin
                parityP3 = parityP4 + (2 * A);
            end
          state_n = 5'b01100;
        end
        5'b01100: begin
          parityP3 = parityP3 <<< 2;
          state_n = 5'b01101;
        end
        5'b01101: begin
          if ((split2 == 3'b000) || (split2 == 3'b111)) begin
                parityP2 = 32'd0;
            end
          else if ((split2 == 3'b001) || (split2 == 3'b010)) begin
                parityP2 = parityP3 + A;
            end
          else if ((split2 == 3'b110) || (split2 == 3'b101)) begin
                parityP2 = parityP3 + (-1 * A);
            end
          else if (split2 == 3'b100) begin
                parityP2 = parityP3 + (-2 * A);
            end
          else if (split2 == 3'b011) begin
                parityP2 = parityP3 + (2 * A);
            end
          state_n = 5'b01110;
        end
        5'b01110: begin
          parityP2 = parityP2 <<< 2;
          state_n = 5'b01111;
        end

        5'b01111: begin
          if ((split1 == 3'b000) || (split1 == 3'b111)) begin
                parityP1 = 32'd0;
            end
          else if ((split1 == 3'b001) || (split1 == 3'b010)) begin
                parityP1 = parityP2 + A;
            end
          else if ((split1 == 3'b110) || (split1 == 3'b101)) begin
                parityP1 = parityP2 + (-1 * A);
            end
          else if (split1 == 3'b100) begin
                parityP1 = parityP2 + (-2 * A);
            end
          else if (split1 == 3'b011) begin
                parityP1 = parityP2 + (2 * A);
            end
          state_n = 5'b10000;
        end
        5'b10000: begin
          parityP1 = parityP1 <<< 2;
          state_n = 5'b10001;
        end
        5'b10001: begin
          if ((split0 == 3'b000) || (split0 == 3'b111)) begin
                parityP0 = 32'd0;
            end
          else if ((split0 == 3'b001) || (split0 == 3'b010)) begin
                parityP0 = parityP1 + A;
            end
          else if ((split0 == 3'b110) || (split0 == 3'b101)) begin
                parityP0 = parityP1 + (-1 * A);
            end
          else if (split0 == 3'b100) begin
                parityP0 = parityP1 + (-2 * A);
            end
          else if (split0 == 3'b011) begin
                parityP0 = parityP1 + (2 * A);
            end
          state_n = 5'b10010;
        end
        5'b10010: begin
          //DO NOT SHIFT HERE WE HAVE OUR FINAL PRODUCT          outAR4 = parityP0;
          setRAR4 = 1'b1; //tell datapath to set ready high
          state_n = 5'b10011; //reset to 0 to look for begin again/////////////////////////////
        end
		    5'b10011: begin
			    if(GetA == 1'b1) begin
					 outAR4 = 32'd0;//to tell what state you are at
				    A[15:8] = swData;
				    state_n = 5'b10100;
				 end
				 else begin
					//outAR4 = 32'd6;
					state_n = 5'b10011;
				 end
			  end
		    5'b10100: begin
			    if(GetX == 1'b1) begin
					 outAR4 = 32'd1;
				    X[15:8] = swData;
				    state_n = 5'b10101;
				  end
				  else begin
					state_n = 5'b10100;
				end	
		    end
		    5'b10101: begin
			    if(GetA == 1'b1) begin
					 outAR4 = 32'd2;
				    A[7:0] = swData;
				    state_n = 5'b10110;
				  end
				  else begin
					state_n = 5'b10101;
					end
			  end
			  5'b10110: begin
			    if(GetX == 1'b1) begin
					 outAR4 = 32'd3;
					 X[7:0] = swData;
					 state_n = 5'b00000;
					end
					else begin
						state_n = 5'b10110;
					end
				end
        endcase
    end
endmodule