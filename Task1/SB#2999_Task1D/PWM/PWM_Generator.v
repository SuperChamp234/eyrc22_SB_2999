// SB : Task 1 D PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50Mhz Clock Frequency to 1Mhz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : Clk, DUTY_CYCLE
//Output : PWM_OUT

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////

module PWM_Generator(
 
	input clk,             // Clock input
	input [7:0] DUTY_CYCLE, // Input Duty Cycle
	output PWM_OUT         // Output PWM
);
 
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
reg [7:0] counter = 0 ;

always @(posedge clk)
begin
   
   if (counter < 50 ) begin 
	counter <= counter + 1 ; 
	end
	else begin
	counter <= 1 ;
	end
	
end

assign PWM_OUT = (counter <= DUTY_CYCLE/2 ) ? 1: 0;

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////