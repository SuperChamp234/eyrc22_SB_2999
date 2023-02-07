module line_following(
    input clk_50,
	 input planner_start,
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
   output [10*2-1:0] direction,
	output [5:0] direction_index,	
	output reg signed [8:0]delta	//12-bit output of ch. 7 (parallel)
);

reg signed [8:0] duty_cycle1_fwd;
reg signed [8:0] duty_cycle1_back;
reg signed [8:0] duty_cycle2_fwd;
reg signed [8:0] duty_cycle2_back;

reg [4:0] s_node = 0; reg [4:0] e_node = 5'd01001;
wire planner_done; wire [10*5-1:0] final_path;
integer planner_counter = 0;
reg [7:0] node_count = 0;
reg [7:0] node_detected = 0;
reg [1:0] current_heading = 2'b01; //change
reg [1:0] turn;
wire planner_start_wire = ~planner_start;

//path_planner planner1(
//							.clk(clk_50),
//							.start(planner_start_wire),
//							.s_node(s_node),
//							.e_node(e_node),
//							.done(planner_done),
//							.final_path(final_path),
//							.direction(direction),
//							.direction_index(direction_index)
//							);

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
    .duty_cycle1_fwd(duty_cycle1_fwd),
    .duty_cycle1_back(duty_cycle1_back),
	 .duty_cycle2_fwd(duty_cycle2_fwd),
    .duty_cycle2_back(duty_cycle2_back),
    .A1A(A1A),
    .A1B(A1B),
    .B1A(B1A),
    .B1B(B1B)
);

parameter Kp = 9'd4;
parameter Kd = 9'd3;
parameter Ki = 9'd0;
parameter thr = 12'd1500;
parameter opt_thr = 12'd2300;	

reg bool_l1;
reg bool_l2;
reg bool_l3;


reg signed [8:0] error = 9'd0;
reg signed [8:0] prev_error = 9'd0;
reg signed [8:0] diff_error = 9'd0;
reg signed [8:0] sum_error = 9'd0;
//reg signed [8:0] delta;
reg [1:0] turn_direction = 0;


reg [7:0] optimum_pwm = 8'd60;

assign direction = 20'b00000000000110100101;
assign direction_index = 6'd9;

parameter Follow = 0; parameter Turn = 1;
reg run_state;

always @ (posedge clk_50) begin
	
    
	 if(lsa_1 > thr) bool_l1 <= 1;
	 else            bool_l1 <= 0;
    
	 if(lsa_2 > opt_thr) bool_l2 <= 1;
	 else            bool_l2 <= 0;
	 
    if(lsa_3 > thr) bool_l3 <= 1;
    else            bool_l3 <= 0;

    case({bool_l1,bool_l2,bool_l3})
        
		  3'b010: begin 
                error <= 0;
                sum_error <= 0;
					 run_state <= Follow;
                end
					 
        3'b011: begin 
						error <= 9'd7;
						//run_state <= Follow;
					 end
        
		  3'b001: begin 
						error <= 9'd9;
						//run_state <= Follow;
					 end
        
		  3'b110: begin 
						error <= -9'd7;
						//run_state <= Follow;
					 end
        
		  3'b100: begin 
						error <= -9'd9;
						//run_state <= Follow;
					 end
        
		  3'b000: begin 
						error <= prev_error ;
						//run_state <= Follow;
					 end
		  
		  3'b111: begin
			  if(run_state == Follow) begin
				  node_count <= node_count + 1;
				  if((node_count > 100)) begin
						node_count <= 0;
						node_detected = node_detected + 1;
						run_state <= Turn;
					end
				  end
				end
    endcase
	 
	 case(run_state)
	 Follow: begin
		 diff_error <= prev_error - error;
		 sum_error <= sum_error + error;
		 prev_error <= error;
		 if(sum_error > 9'b00011110)
			  sum_error <= 9'b00011110;
		 if(sum_error < 9'b011100010)
			  sum_error <= 9'b011100010;

		 delta <= Kp * error + Kd * diff_error + Ki * sum_error;

		 duty_cycle1_fwd <= optimum_pwm + delta;
		 duty_cycle1_back <= 0;
		 duty_cycle2_fwd <= optimum_pwm - delta;
		 duty_cycle2_back	<= 0;
	end
	
	Turn: begin
		case({direction[(direction_index-(node_detected)*2-1)+:2],direction[(direction_index-(node_detected)*2)+:2]})
				4'b0001, 4'b0110, 4'b1011, 4'b1100: begin
					turn_direction <= 2'b01;
					duty_cycle1_fwd <= 9'd60;
					duty_cycle1_back <= 0;
					duty_cycle2_fwd <= 0;
					duty_cycle2_back <= 9'd50;
				end
				4'b0011, 4'b1110, 4'b1001, 4'b0100: begin
					turn_direction <= 2'b10;
					duty_cycle1_fwd <= 0;
					duty_cycle1_back <= 9'd60;
					duty_cycle2_fwd <= 9'd50;
					duty_cycle2_back <= 0;
				end
			endcase
			//current_heading <= direction[(direction_index-(node_count)*2)+:2];
	end
	endcase
	
end

endmodule
