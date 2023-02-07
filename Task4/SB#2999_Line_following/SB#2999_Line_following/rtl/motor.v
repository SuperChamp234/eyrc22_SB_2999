module motor(
	input clk_50,
	input [7:0] duty_cycle1_fwd,
	input [7:0] duty_cycle1_back,
	input [7:0] duty_cycle2_fwd,
	input [7:0] duty_cycle2_back,
	output A1A,
	output A1B,
	output B1A,
	output B1B
);

wire PWM_OUT_1_FWD;
wire PWM_OUT_1_BACK;
wire PWM_OUT_2_FWD;
wire PWM_OUT_2_BACK;

integer counter = 1;
reg sck = 0;

always @(negedge clk_50 ) begin
      counter <= counter + 1;
		
    if(counter==5000) begin 
       counter <= 1; end 
		 
    sck = (counter>2500) ? 1:0;
end

PWM_Generator motor1_fwd(.clk(sck), .PWM_OUT(PWM_OUT_1_FWD), .DUTY_CYCLE(duty_cycle1_fwd));
PWM_Generator motor1_back(.clk(sck), .PWM_OUT(PWM_OUT_1_BACK), .DUTY_CYCLE(duty_cycle1_back));

PWM_Generator motor2_fwd(.clk(sck), .PWM_OUT(PWM_OUT_2_FWD), .DUTY_CYCLE(duty_cycle2_fwd));
PWM_Generator motor2_back(.clk(sck), .PWM_OUT(PWM_OUT_2_BACK), .DUTY_CYCLE(duty_cycle2_back));


assign A1A = PWM_OUT_1_BACK;
assign A1B = PWM_OUT_1_FWD;

assign B1A = PWM_OUT_2_BACK;
assign B1B = PWM_OUT_2_FWD;


endmodule