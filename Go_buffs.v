//Alex Johnson April 2018
//Module to Scroll "Go Buffs" across given seven segment displays
module go_buffs(input clock,
					 output reg [7:0]HEX0, output reg [7:0]HEX1, output reg [7:0]HEX2, output reg [7:0]HEX3, output reg [7:0]HEX4, output reg [7:0]HEX5);
	//create constants for the different characters that need to be displayed
	parameter g_HEX = ~(8'b01011111);
	parameter O_HEX = ~(8'b01111110);
	parameter space_HEX = ~(8'b00000000);
	parameter b_HEX = ~(8'b00011111);
	parameter u_HEX = ~(8'b00011100);
	parameter f_HEX = ~(8'b01000111);
	parameter s_HEX = ~(8'b01011011);
	
	initial HEX5 = g_HEX;
	initial HEX4 = O_HEX;
	initial HEX3 = space_HEX;
	initial HEX2 = b_HEX;
	initial HEX1 = u_HEX;
	initial HEX0 = f_HEX;
	
	integer state;
	initial state = 0;
	always@(posedge clock)
	begin
		state = (state + 1) % 9;
		HEX5 = HEX4;
		HEX4 = HEX3;
		HEX3 = HEX2;
		HEX2 = HEX1;
		HEX1 = HEX0;
		case(state)
			0: HEX0 = f_HEX;
			1: HEX0 = f_HEX;
			2: HEX0 = s_HEX;
			3: HEX0 = space_HEX;
			4: HEX0 = g_HEX;
			5: HEX0 = O_HEX;
			6: HEX0 = space_HEX;
			7: HEX0 = b_HEX;
			8: HEX0 = u_HEX;
		endcase
	end
endmodule
