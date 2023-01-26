module Line_following (clk_50,din1,dout1,cs,output1,output2,c1,c2,c3);

adc_control I1(.d_out_ch5(S1), .d_out_ch6(S2), .d_out_ch7(S3),.adc_sck(clk_50), .din(din1), .dout(dout1), .adc_cs_n(cs));
 
motor motor1(.clk_50())
PWM_Generator I3(.PWM_OUT(output2_2), .DUTY_CYCLE(pwm2), .clk(clk_50));
  
output wire output1; //pwm_out_1 to motor
output wire output2; //pwd_out_2 to motor
wire output1_1;  //calculated pwm_out_1
wire output2_2; //calculated pwm_out_2
reg[2:0] pwm1;
reg[2:0] pwm2;
wire [11:0] S1; 
wire [11:0] S2;
wire [11:0] S3; 
  
output wire clk_50;
wire clk;
wire adc_sck;
output wire din1;
input wire dout1 ;

output  wire cs;
output c1;
output c2;
output c3;

reg s1;
reg s2;
reg s3;

reg signed [1:0] error;
reg signed [1:0] cumulative_error;
reg signed [1:0] diff_error;
reg signed [1:0] prev_error;
reg[11:0] optimum;
reg signed [11:0] delta;
reg[11:0] thr= 330;
  
parameter kp = 8'b1;
parameter ki = 8'b1;
parameter kd = 8'b1;

  always @(posedge clk)begin
    optimum <= 60;
    if(S1 > thr)
    begin
      s1 <= 1;
    //  c1 <= 1;
      end
    else
      s1 <=0;
    if(S2> thr)
    begin
      s2 <= 1;
      //c2 <= 1;
      end
    else
      s2 <=0;
    if(S3> thr)
    begin
      s3 <= 1;
     // c3 <= 1;
      end
    else
      s3 <=0;
    
 
    case ({S1,S2,S3})
       3'b010: 
        begin
        error<=0;
        cumulative_error <= 0;
        end
               
       3'b011: 
        error<=1;
      
       3'b001: 
        error<=2;
      
       3'b110: 
        error<=-1;
      
       3'b100: 
        error<=-2;
      
       3'b000:
        begin
        error<=0;
        cumulative_error <= 0;
        diff_error <= 0;
        end
        endcase
      prev_error = error;
      diff_error <= prev_error - error;
      cumulative_error <= cumulative_error + error ;
        if(cumulative_error > 30 )
          cumulative_error <= 30;
        if(cumulative_error <-30)
          cumulative_error <=-30;
        
      delta <= kp*error + ki*cumulative_error + kd*diff_error ;
      
      pwm1 <= optimum - delta ;
      pwm2 <= optimum + delta;
      end
		
      assign c1=s1;
      assign c2=s2;
      assign c3=s3;
      
      assign output1 = output1_1;
      assign output2 = output2_2;
      assign din = din1;
      assign dout = dout1;
      assign adc_cs_n = cs;
      assign clk = adc_sck;
      assign clk1= clk;
      
endmodule
		