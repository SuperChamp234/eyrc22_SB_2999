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
parameter data_len = 8*4;


reg [(data_len - 1):0] data = "SB99";
reg [5:0] index = 6'b0;
reg [5:0] index_hold = 6'd7;
reg data_out = 1;
reg [8:0]counter = 0;
reg clk=1;
integer n=data_len-1;
reg [5:0] index_jump = 6'd8;

assign tx = data_out;

reg [4:0] next_state = IDLE;

always @ (posedge clk_50M) begin
   counter = counter+1;
   if(counter == 217) begin
	   counter =1;
		clk= ~clk;
	end
end


always @ (posedge clk) begin
	case(next_state)
		IDLE: begin
			next_state <= START;
			index <= 5'd0;
			if(index_hold == data_len + 7) begin
				data_out <= 1;
				next_state <= 5'b11111;
			end
		end
		START: begin
			next_state <= DATA;
			data_out <= 0;
		end
		DATA: begin
				data_out <= data[n-(index_hold - index)];
				index <= index + 6'd1;
				if(index == 6'd7) begin
					next_state <= STOP;
					index_hold <= index_hold + index_jump;
				end
		end
		STOP: begin
			data_out <= 1;
			next_state <= IDLE;
		end
	endcase
end


////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////