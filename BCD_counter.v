//Alex Johnson March 2018
//Module to count a BCD value and record it to the given binary output
module BCD_counter(input clock, input start, input reset, output  reg [13:0]count);
	//at every clock cycle increment the count by one
	always@(posedge clock)
	begin
		if(reset == 1)
			count = 0;
		else if(start == 1)
			count = (count + 1) % 9999;
	end
	
//	//decode the binary value into a value on the seven segment displays
//	BCD_decoder HEX_block(count[13:0], HEX0[6:0], HEX1[6:0], HEX2[6:0], HEX3[6:0]);
//	
//	assign HEX0[7] = 1;
//	assign HEX1[7] = 1;
//	assign HEX2[7] = 1;
//	assign HEX3[7] = 0;
endmodule
