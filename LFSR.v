//Alex Johnson March 2019
//Module to implement a Fibonacci Linear Feedback shift register to
//be used as a random number generator
module LFSR(input CLK, output reg [7:0]number);
	//use a random 8 bit value as the starting value
	parameter start_state = 8'b01101010;
	reg least;
	
	initial
	begin
		number = start_state;
	end
	
	always@(posedge CLK)
	begin
		least = number[0];
		number = number >> 1;
		//use bits 3,4, and 6 as the feedback taps for the register
		number[7] = number[2] ^ number[4] ^ number[6] ^ least;
	end
endmodule
