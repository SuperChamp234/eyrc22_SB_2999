// SB : Task 2 A : ADC
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design ADC Controller.
 
Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.
 
Warning: The error due to compatibility will not be entertained.
-------------------
*/
 
//ADC Controller design
//Inputs  : clk_50 : 50 MHz clock, dout : digital output from ADC128S022 (serial 12-bit)
//Output  : adc_cs_n : Chip Select, din : Ch. address input to ADC128S022, adc_sck : 2.5 MHz ADC clock,
//				d_out_ch5, d_out_ch6, d_out_ch7 : 12-bit output of ch. 5,6 & 7,
//				data_frame : To represent 16-cycle frame (optional)
 
//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module adc_control(
	input  clk_50,				//50 MHz clock  FPGA ka clock is coming ADC me 
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,					//Ch. address input to ADC128S022 (serial)
	output adc_sck,			//2.5 MHz ADC clock ADC ispe work karega which is divided from 50MHz
	output [11:0]d_out_ch5,	//12-bit output of ch. 5 (parallel)
	output [11:0]d_out_ch6,	//12-bit output of ch. 6 (parallel)
	output [11:0]d_out_ch7	//12-bit output of ch. 7 (parallel)
	//output [1:0]data_frame	//To represent 16-cycle frame (optional)
);
 
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
 
reg [4:0]counter_0 = 5'd0;
reg [5:0]counter_1 = 6'd0;
reg sck = 0;
reg din_0 = 0;
reg [11:0] data;
reg [11:0] data5 = 12'd0;
reg [11:0] data6 = 12'd0;
reg [11:0] data7 = 12'd0;
reg cs_0 = 1;
 
always @(negedge clk_50) begin  // clock divider 
 
  counter_0 = counter_0 + 5'd1;
 
  if (counter_0 == 5'd21) begin
  counter_0 = 5'd1;
  sck <= 0;
  end
 
  else if (counter_0 == 5'd11) begin 
  sck <= 1;
  end
 
end
 
always @(negedge sck) begin   // Started working on ADC
 
  counter_1 = counter_1 + 6'd1;
 
  if (counter_1 == 6'd48) begin
  counter_1 = 6'd0;
  end
 
  if (counter_1 == 6'd16 || counter_1 == 6'd32 || counter_1 == 6'd0) begin
  cs_0 <= 1;
  end
 
  else begin 
  cs_0 <= 0;
  end
 
  case (counter_1) 
 
  
  2: din_0 = 0;
  3: din_0 = 1;
  4: din_0 = 0;
  5: din_0 = 1;
  6: begin
     data[11] = dout;
	  din_0 = 0;
	  end
  7: data[10] = dout;
  8: data[9] = dout;
  9: data[8] = dout;
 10: data[7] = dout;
 11: data[6] = dout;
 12: data[5] = dout;
 13: data[4] = dout;
 14: data[3] = dout;
 15: data[2] = dout;
 16: data[1] = dout;
 17: begin
     data[0] = dout;
     data7 <= data;
	  din_0 = 0;
	  end
 
 18: din_0 = 0;
 19: din_0 = 1;
 20: din_0 = 1;
 21: din_0 = 0;
 22: begin
     data[11] = dout;
	  din_0 = 0;
	  end
 23: data[10] = dout;
 24: data[9] = dout;
 25: data[8] = dout;
 26: data[7] = dout;
 27: data[6] = dout;
 28: data[5] = dout;
 29: data[4] = dout;
 30: data[3] = dout;
 31: data[2] = dout;
 32: data[1] = dout; 
 33: begin
     data[0] = dout;
     data5 <= data;
	  din_0 = 0;
	  end
 
 34: din_0 = 0;
 35: din_0 = 1;
 36: din_0 = 1;
 37: din_0 = 1;
 38: begin
     data[11] = dout;
	  din_0 = 0;
	  end
 39: data[10] = dout;
 40: data[9] = dout;
 41: data[8] = dout;
 42: data[7] = dout;
 43: data[6] = dout;
 44: data[5] = dout;
 45: data[4] = dout;
 46: data[3] = dout;
 47: data[2] = dout;
 48: data[1] = dout;
 1: begin
     data[0] = dout;
     data6 <= data;
	  din_0 = 0;
	  end
endcase 
end
 
assign adc_sck = sck;
assign din = din_0;
assign d_out_ch5 = data5;
assign d_out_ch6 = data6;
assign d_out_ch7 = data7;
assign adc_cs_n = cs_0;
 
////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////