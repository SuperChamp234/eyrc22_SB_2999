// SB : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module uart(
	input clk_50M,	//50 MHz clock
	output tx		//UART transmit output
);
////////////////////////WRITE YOUR CODE FROM HERE////////////////////

parameter IDLE = 0, START = 1, DATA = 2, STOP = 3;

reg [7*4:0] data = "SB99";
reg [5:0] index = 5'b0;
reg [5:0] index_hold = 5'b0;
reg data_out = 1;
reg [8:0]counter = 0;
reg clk=0;
integer n=8*4;

assign tx = data_out;

reg [4:0] current_state = STOP;

always @ (posedge clk_50M) begin
   counter = counter+1;
   if(counter == 217) begin
	   counter =1;
		clk= ~clk;
	end
end


always @ (posedge clk) begin
	case(current_state)
		IDLE: begin
			current_state <= START;
			index <= 0;
			if(index_hold == 5'd31)
				index_hold <= 0;
		end
		START: begin
			current_state <= DATA;
			data_out <= 0;
		end
		DATA: begin
			if(index == 5'd7) begin
				index_hold <= index_hold + index;
				index <= 0;
				current_state <= STOP;
			end
			else begin
				data_out <= data[n -(index_hold + index)];
				index <= index + 5'd1;
			end
		end
		STOP: begin
			data_out = 1;
			current_state <= IDLE;
		end
	endcase
end

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
