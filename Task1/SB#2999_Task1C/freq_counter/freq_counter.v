// SB : Task 1C Frequency Counter
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design 2:1 Multiplexer.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Freq Counter design
//Inputs	: clk & ip_sig (input signal)
//Output	: count (8 bits)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module freq_counter(
	input clk,
	input ip_sig,

	output reg [7:0] count = 0
);


////////////////////////WRITE YOUR CODE FROM HERE//////////////////// 

reg [7:0] counter = 0 ;
reg [7:0] prevcount = 0 ;
reg [7:0] temp = 0 ;

always @ (posedge clk) begin

if (ip_sig!= 0) begin
counter = counter + 1;
prevcount = temp ;
end

else begin
count = counter - prevcount ;
temp = counter ;
end

end

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
