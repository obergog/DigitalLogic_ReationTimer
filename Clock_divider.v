//Alex Johnson March 2018
//module to divide a clock given a division 'n'
//the standard division is 1000, which will divide the clock
//by 1KHz
module Clock_divider(input CLK, output div_CLK);
	parameter n = 1000;
	integer clock_count;
	reg new_clock;
	always@(posedge CLK)
	begin
		if(clock_count < (n/2))
			clock_count = clock_count + 1;
		else
		begin
			new_clock = ~new_clock;
			clock_count = 0;
		end
	end
	
	assign div_CLK = new_clock;
endmodule
