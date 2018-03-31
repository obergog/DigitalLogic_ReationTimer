//Alex Johnson ECEN 2350 Spring 2018
//seven segment module that takes 4 BCD digits and decodes them to 7 bits for a seven segment display
module SevenSegment(x[3:0], f[6:0]);
	input [3:0]x;
	output reg [6:0]f;
	//always block to output the correct 7 bits in accordance to the BCD sent in
	always @(x)
	begin
		case(x)
			4'b0000: f = ~(7'b1111110);
			4'b0001: f = ~(7'b0110000);
			4'b0010: f = ~(7'b1101101);
			4'b0011: f = ~(7'b1111001);
			4'b0100: f = ~(7'b0110011);
			4'b0101: f = ~(7'b1011011);
			4'b0110: f = ~(7'b1011111);
			4'b0111: f = ~(7'b1110000);
			4'b1000: f = ~(7'b1111111);
			4'b1001: f = ~(7'b1111011);
			4'b1010: f = ~(7'b1110111);
			4'b1011: f = ~(7'b0011111);
			4'b1100: f = ~(7'b1001110);
			4'b1101: f = ~(7'b0111101);
			4'b1110: f = ~(7'b1001111);
			4'b1111: f = ~(7'b1000111);
		endcase
	end
endmodule
