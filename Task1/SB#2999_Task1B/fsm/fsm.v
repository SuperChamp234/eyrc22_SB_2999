// SB : Task 1 B : Finite State Machine
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Finite State Machine.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Finite State Machine design
//Inputs  : I (4 bit) and CLK (clock)
//Output  : Y (Y = 1 when 102210 sequence(decimal number sequence) is detected)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module fsm(
	input CLK,			  //Clock
	input [3:0]I,       //INPUT I
	output	  Y		  //OUTPUT Y
);

reg Y1 = 0;
assign Y = Y1;



////////////////////////WRITE YOUR CODE FROM HERE//////////////////// 
	

// Tip : Write your code such that Quartus Generates a State Machine 
//			(Tools > Netlist Viewers > State Machine Viewer).
// 		For doing so, you will have to properly declare State Variables of the
//       State Machine and also perform State Assignments correctly.
//			Use Verilog case statement to design.

parameter IDLE = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6; //to keep track of the states of the fsm

reg [3:0] current_state, next_state = IDLE; //to keep track of current and next states.

always @ (posedge CLK) begin
	current_state <= next_state;
end

always @ (current_state or I) begin
	Y1 <= 0;
	case(current_state) 
		IDLE: begin
			if(I == 3'd1) next_state = S1;
			else next_state = IDLE;
		end
		S1: begin
			if(I == 3'd0) next_state = S2;
			else next_state = IDLE;
		end
		S2: begin
			if(I == 3'd2) next_state = S3;
			else next_state = IDLE;
		end
		S3: begin
			if(I == 3'd2) next_state = S4;
			else next_state = IDLE;
		end
		S4: begin
			if(I == 3'd1) next_state = S5;
			else next_state = IDLE;
		end
		S5: begin
			if(I == 3'd0) begin
				next_state = S6;
			end
			else next_state = IDLE;
		end
		S6: begin
			if(I == 3'd2) next_state = S3;
			else next_state = IDLE;
			Y1 <= 1;
		end
	endcase
end

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////