//Alex Johnson March 2018
//module to decode a BCD value into a value that can be
//displayed on seven segment displays in base 10
module BCD_decoder(input [13:0]number,
						 output [6:0]HEXOUT_0, output [6:0]HEXOUT_1, output [6:0]HEXOUT_2, output [6:0]HEXOUT_3);
	reg [3:0]digit_0;
	reg [3:0]digit_1;
	reg [3:0]digit_2;
	reg [3:0]digit_3;
	
	//have each digit correspond to a different division of the number
	always@(number)
	begin
		digit_3 = number / 1000;
		digit_2 = (number / 100) % 10;
		digit_1 = (number / 10) % 10;
		digit_0 = number % 10;
	end
	
	//display the new digits on the seven segments displays
	SevenSegment HEX0(digit_0[3:0],HEXOUT_0[6:0]);
	SevenSegment HEX1(digit_1[3:0],HEXOUT_1[6:0]);
	SevenSegment HEX2(digit_2[3:0],HEXOUT_2[6:0]);
	SevenSegment HEX3(digit_3[3:0],HEXOUT_3[6:0]);


endmodule
