module motor(
	input clk_50,
	input [7:0] duty_cycle1,
	input [7:0] duty_cycle2,
	output A1A,
	output A1B,
	output B1A,
	output B1B
);

wire PWM_OUT_1;
wire PWM_OUT_2;

integer counter = 1;
reg sck = 0;

always @(negedge clk_50 ) begin
      counter <= counter + 1;
		
    if(counter==5000) begin 
       counter <= 1; end 
		 
    sck = (counter>2500) ? 1:0;
end

PWM_Generator motor1(.clk(sck), .PWM_OUT(PWM_OUT_1), .DUTY_CYCLE(duty_cycle1));
PWM_Generator motor2(.clk(sck), .PWM_OUT(PWM_OUT_2), .DUTY_CYCLE(duty_cycle2));


assign A1A = PWM_OUT_1;
assign A1B = ~PWM_OUT_1;

assign B1A = PWM_OUT_2;
assign B1B = ~PWM_OUT_2;


endmodule