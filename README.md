# DigitalLogic_ReationTimer
Simple verilog project that turns the MAX10 DE-10 Lite into a reaction timer.
The timer will first start out in a ready state where the seven segment displays will display "ready"
Once the KEY0 button is pressed the timer will go into a random delay state where it will display "delay"
Once the random delay has passed, all of the LEDs will light up and the timer will start timing the reaction time
Once the KEY0 button is pressed during this timing state the timer stops and displays the reaction time
If the KEY0 button is pressed again, the timer returns back to the ready state
