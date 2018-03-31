//Alex Johnson ECEN 2350 Spring 2018
//multiplexor module that will switch between 4 inputs given depending on selection bits
//parameter n determines the size of the input and output buses (1=1 bit bus, 4=4 bit bus, etc.)
module MUX(input [4*n-1:0]x, input[1:0]s, output reg [n-1:0]f);
	parameter n = 4;
	always@(x,s)
	begin
		case(s)
			2'b00: f = x[n-1:0];
			2'b01: f = x[2*n-1:n];
			2'b10: f = x[3*n-1:2*n];
			2'b11: f = x[4*n-1:3*n];
		endcase
	end
endmodule
