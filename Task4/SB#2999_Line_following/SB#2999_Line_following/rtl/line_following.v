module line_following(
    input clk_50,
	output A1A,
	output A1B,
	output B1A,
	output B1B,
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,				//Ch. address input to ADC128S022 (serial)
	output adc_sck,		  //2.5 MHz ADC clock
	output [11:0]lsa_1,	  //12-bit output of ch. 5 (parallel)
	output [11:0]lsa_2,	  //12-bit output of ch. 6 (parallel)
	output [11:0]lsa_3,	
	output reg signed [8:0]delta	//12-bit output of ch. 7 (parallel)
);

reg signed [8:0] duty_cycle1;
reg signed [8:0] duty_cycle2;

adc_control ADC1(.d_out_ch5(lsa_1),
                .d_out_ch6(lsa_2),
                .d_out_ch7(lsa_3),
                .din(din),
                .dout(dout),
                .adc_cs_n(adc_cs_n),
                .adc_sck(adc_sck),
					 .clk_50(clk_50)
);

motor motor_control(
    .clk_50(clk_50),
    .duty_cycle1(duty_cycle1),
    .duty_cycle2(duty_cycle2),
    .A1A(A1A),
    .A1B(A1B),
    .B1A(B1A),
    .B1B(B1B)
);

parameter Kp = 9'd4;
parameter Kd = 9'd3;
parameter Ki = 9'd0;
parameter thr = 12'd350;	

reg bool_l1;
reg bool_l2;
reg bool_l3;


reg signed [8:0] error = 9'd0;
reg signed [8:0] prev_error = 9'd0;
reg signed [8:0] diff_error = 9'd0;
reg signed [8:0] sum_error = 9'd0;
//reg signed [8:0] delta;


reg [7:0] optimum_pwm = 8'd22	;

always @ (posedge clk_50) begin
    
	 if(lsa_1 > thr) bool_l1 <= 1;
	 else            bool_l1 <= 0;
    
	 if(lsa_2 > thr) bool_l2 <= 1;
	 else            bool_l2 <= 0;
	 
    if(lsa_3 > thr) bool_l3 <= 1;
    else            bool_l3 <= 0;

    case({bool_l1,bool_l2,bool_l3})
        
		  3'b010: begin 
                error <= 0;
                sum_error <= 0;
                end
					 
        3'b011: error <= 9'd3;
        
		  3'b001: error <= 9'd5;
        
		  3'b110: error <= -9'd3;
        
		  3'b100: error <= -9'd5;
        
		  3'b000: error <= prev_error ;
		  
    endcase
    diff_error <= prev_error - error;
    sum_error <= sum_error + error;
	 prev_error <= error;
    if(sum_error > 9'b00011110)
        sum_error <= 9'b00011110;
    if(sum_error < 9'b011100010)
        sum_error <= 9'b011100010;

    delta <= Kp * error + Kd * diff_error + Ki * sum_error;

    duty_cycle1 <= optimum_pwm - delta;
    duty_cycle2 <= optimum_pwm + delta;
end

endmodule
