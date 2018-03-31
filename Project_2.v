//Alex Johnson March 2018
//This project is a reaction timer that records the reaction
//time of the user by first pressing a button, and then after
//a random time passes, indicating to press the button again
//The project will also have a second mode that scrolls "Go Buffs"
//across the seven segment displays
module Project_2( input [1:0]KEY,
						input [9:0]SW,input CLK,
						output [9:0]LED,
						output [7:0]HEXOUT_0, output [7:0]HEXOUT_1, output [7:0]HEXOUT_2, output [7:0]HEXOUT_3, output [7:0]HEXOUT_4, output [7:0]HEXOUT_5);
				
	//create a state register that stores the state of the reaction timer		
	reg [1:0]state;
	parameter ready_state = 2'b00;	//timer is ready
	parameter delay_state = 2'b01;	//timer is waiting a random amount of time
	parameter timing_state = 2'b10;	//timer is currently timing the reaction time
	parameter finish_state = 2'b11;	//reaction time has been recorded and is displayed
	initial state = ready_state;
		
	//constants to be display "ready" on the seven segment displays during ready state
	parameter ready_HEX0 = ~(8'b00111011);	//'y'
	parameter ready_HEX1 = ~(8'b00111101);	//'d'
	parameter ready_HEX2 = ~(8'b01110111);	//'a'
	parameter ready_HEX3 = ~(8'b01001111);	//'e'
	parameter ready_HEX4 = ~(8'b01000110);	//'r'
	parameter ready_HEX5 = ~(8'b00000000);	//blank space
	parameter ready_all = {ready_HEX5, ready_HEX4, ready_HEX3, ready_HEX2, ready_HEX1, ready_HEX0};
	
	//constants to be display "delay" during the delay state
	parameter delay_HEX0 = ~(8'b00111011);	//'y'
	parameter delay_HEX1 = ~(8'b01110111);	//'a'
	parameter delay_HEX2 = ~(8'b00110000);	//'l'
	parameter delay_HEX3 = ~(8'b01001111);	//'e'
	parameter delay_HEX4 = ~(8'b00111101);	//'d'
	parameter delay_HEX5 = ~(8'b00000000);	//blank space
	parameter delay_all = {delay_HEX5, delay_HEX4, delay_HEX3, delay_HEX2, delay_HEX1, delay_HEX0};
	
	//divide the clock into a 1KHz clock
	wire clock_1k;
	Clock_divider clock_division(CLK, clock_1k);
	defparam clock_division.n = 50000;
	
	//divide the clock into a 5Hz clock
	wire clock_5;
	Clock_divider clock_division2(CLK, clock_5);
	defparam clock_division2.n = 10000000;
	
	//find a random number between 0 and 255
	wire [7:0]delay;
	LFSR random(clock_5, delay[7:0]);
		
	//create wires to hold the seven segment output of the timer
	wire [7:0]react_HEX0;
	wire [7:0]react_HEX1;
	wire [7:0]react_HEX2;
	wire [7:0]react_HEX3;
	wire [47:0]react_all;
	assign react_all[47:0] = {8'b11111111, 8'b11111111, react_HEX3[7:0], react_HEX2[7:0], react_HEX1[7:0], react_HEX0[7:0]};
	//use the BCD_counter to time the reaction of the user
	wire go;
	wire reset;
	assign go = state[1] & ~state[0];
	assign reset = ~state[1] & ~state[0];
	BCD_counter reaction_count(clock_1k, go, reset, react_HEX0[7:0], react_HEX1[7:0], react_HEX2[7:0], react_HEX3[7:0]);

	//create seperate button states that are used to cycle through the top level states
	reg [1:0]button_state;
	always@(negedge KEY[0])
	begin
		button_state = (button_state + 1) % 3;
	end
	//use the 1KHz clock to check the button states and enter the apporpriate top level states
	integer delay_count;
	reg delay_flag;
	initial delay_flag = 0;
	always@(posedge clock_1k)
	begin
		case(button_state)
			//zero button state is same as the ready state
			2'b00: state = ready_state;
			//the 1 button state corresponds to both the timing and delay states
			2'b01:
			begin
				//wait the random amount of time (0-255) plus 500 miliseconds
				if((delay_count < (delay + 500)) && (delay_flag == 0))
				begin
					state = delay_state;
					delay_count = delay_count + 1;
				end
				else
				begin
					state = timing_state;
					delay_flag = 1;
					delay_count = 0;
				end
			end
			//the 2 button state is the same as the finish top level state
			2'b10:
			begin
				state = finish_state;
				delay_flag = 0;
			end
		endcase
	end
	
	//have the all of the LEDs turn on when the user needs to react
	genvar i;
	generate
		for(i=0; i<10; i=i+1) begin: LED_assignment
			assign LED[i] = state[1];
		end
	endgenerate
	
	//use a very large multiplexor to change the output of the seven segment displays based on the state
	MUX HEX_MUX({react_all[47:0],react_all[47:0],delay_all[47:0],ready_all[47:0]}, state[1:0],
		{HEXOUT_5[7:0], HEXOUT_4[7:0], HEXOUT_3[7:0], HEXOUT_2[7:0], HEXOUT_1[7:0], HEXOUT_0[7:0]});
	defparam HEX_MUX.n = 48;
endmodule
