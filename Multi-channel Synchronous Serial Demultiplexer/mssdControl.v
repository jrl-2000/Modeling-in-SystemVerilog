`timescale 1ns / 1ps

module mssdControl (
    input clk,                      //clock
    input reset,                    //reset
    input serIn,                    //Serial Input
    output reg error,               //Error Signals
    output reg [0:1] dest,          //d the destination
    output reg [0:3] bCounter,      //Byte count6er for 1+2+4+8*n clocks cycles
    output reg dataCom,             //data Communication Flag for mssd_dataPath
    output reg outValid             //outvalid Flag            
);

//Regs for States
reg [0:1] state;                    //Current State 
reg [0:1] state_n;                  //Next State


//Regs for COunter
reg [0:31] dataStreamCounter;       //32 bit counter for 8*5 bytes goign through serial communication
reg [0:1] counter2Wide;             //2-bit width for filling the bytecounter 2bit range is up to 3 (0-3) 4 bit = 1 byte
reg  counter;                       //single width

//Update the State Machine
always @ (posedge clk, posedge reset) begin
    if (reset) begin
        state <= 2'b00;
    end    
    else begin
        state <= state_n;
    end    
end

//Main State Machine
always @ (state, serIn, dataStreamCounter, counter2Wide, counter) begin
    state_n = state;            //state = next state
    
    case(state)
    2'b00: begin                      //Wait until serIn goes low(0) and reset counters + flags
        if (!serIn )begin //&& !outValid
            //flags and state
            state_n = 2'b01;
            dest = 2'b00;
            outValid = 1'b0;
            error = 1'b0;
            
            //counters
            dataStreamCounter = 32'b00000000000000000000000000000000;
            bCounter = 4'b0000;
            counter2Wide = 2'b00;            
            counter = 1'b0;
            
            
        end
        
        else begin
            //flags and states: error turned high
            state_n = 2'b00;
            dest = 2'b00;
            error = 1'b1;
            outValid = 1'b0;
            
            //counters reset
            dataStreamCounter = 32'b00000000000000000000000000000000;
            bCounter = 4'b0000;
            counter2Wide = 2'b00;
            counter = 1'b0;
            
            
        end
     end
        
    2'b01: begin                         //first 2 bits are for the port selection used by datapath
        if (counter == 1'b0)begin   //the single bit width counter counts until there are 2 populated in the destination register (d). MSB leading first and then tells the machine to move onto the bytes
            dest[0] = serIn;
            state_n = 2'b01;
        end
        
        else if (counter == 1'b1)begin   
            dest[1] = serIn;
            state_n = 2'b10;
        end
     end
     
    2'b10: begin                              //the 2bit width counter iis to to count in 4s. 4bits in 1byte
        if (counter2Wide == 2'b00)begin   
            bCounter[0] = serIn;
            state_n = 2'b10;
        end
        
        else if (counter2Wide == 2'b01)begin   
            bCounter[1] = serIn;
            state_n = 2'b10;
        end
        
        else if (counter2Wide == 2'b10)begin   
            bCounter[2] = serIn;
            state_n = 2'b10;
        end
        
        else if (counter2Wide == 2'b11)begin   
            bCounter[3] = serIn;
            state_n = 2'b11;
        end
     end
        
    2'b11: begin                         //1+2+4+n*8 clock cycles for transmission until that is met where n is the number of bits
        if (dataStreamCounter != ((bCounter + bCounter + bCounter + bCounter + bCounter) - 2'b10))begin  
            state_n = 2'b11;
        end
        
        else begin
            state_n = 2'b00;
        end
     end
    endcase  
    //Set Flags for dataPath
    dataCom = (state == 2'b11);
    outValid = (state == 2'b11);
end

//Update the Counter only on positive edge of the CLOCK
always @ (posedge clk) begin
    if (state == 2'b01) begin
        counter <= counter + 1'b1;
    end
    else begin
        counter <= 1'b0;
    end
    if (state == 2'b10) begin
        counter2Wide <= counter2Wide + 1'b1;
    end
    else begin
        counter2Wide = 2'b00;
    end
    if (state == 2'b11) begin
        dataStreamCounter <= dataStreamCounter + 1'b1;
    end
    else begin
        dataStreamCounter <= 32'b00000000000000000000000000000000;
    end
       
end
endmodule
