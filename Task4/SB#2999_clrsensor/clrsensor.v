module clrsensor  (
    input clk,
    input sensorout,
    input [7:0]node,
    output tx,
    output reg xb = 1,
    output reg s0=1,
    output reg s1=0,
    output reg s2=0,
    output reg s3=0,
    output reg [14:0]R=1,
    output reg [14:0]B=1,
    output reg [14:0]G=1,
    output reg red,
    output reg blue,
    output reg green,
    output reg [2:0]state=3'b000,
    output reg flag =0,
    output reg R1=0,
    output reg R2=0,
    output reg R3=0,
    output reg G1=0,
    output reg G2=0,
    output reg G3=0,
    output reg B1=0,
    output reg B2=0,
    output reg B3=0
);
reg [14:0]freq;
reg [63:0]display = "GBI0-0-#";
//reg [7:0]waste = " ";
reg [7:0]count_red = 0;
reg [7:0]count_blue = 0;
reg [7:0]count_green = 0;
reg [7:0]count_bw = 0;
reg l1 = 0;
reg l2 = 0;
reg l3 = 0;
//reg [2:0]sel = 0;

Xbee(
    .clk_50M(clk),
    .tx(tx),
    .flag(xb),
    .data(display)
);
    always @(posedge clk ) begin
        case (state)
            3'b000: begin
				s0<=1;
				s1<=1;
				freq <= 1;
                s2 <= 0;
                s3 <= 0;
                xb <= 1;
					 if (sensorout == 0)begin
                    state <= 3'b001;
                    flag <= 0;
                end 
            end
            3'b001: begin
                if (sensorout == 1 ) begin
                    freq <= freq+1;
                    flag <= 1;
                end
                else if (flag == 1)begin
                    R <= freq;
                    state <= 3'b010;
                    flag <= 0;
                end
            end 
            3'b010: begin
					 freq <= 1;
                s2 <= 0;
                s3 <= 1;
                //flag <= 0;
                if (sensorout == 0)begin
                    state <= 3'b011;
                    flag <= 0;
                end 
            end
            3'b011: begin
                if (sensorout == 1 ) begin
                freq <= freq+1;
                flag <=1 ;
                end
                else if (flag == 1) begin
                    B <= freq;
                    state <= 3'b100;
                    flag <= 0;
                end
            end 
            3'b100: begin
					 freq <= 1;
                s2 <= 1;
                s3 <= 1;
                //
                if (sensorout == 0)begin
                    state <= 3'b101;
                    flag <= 0;
                end 
            end
            3'b101: begin
                if (sensorout == 1) begin
                    freq <= freq+1;
                    flag <= 1;
                end
                else if (flag == 1)begin
                    G <= freq;
                    state <= 3'b110;
                    flag <= 0;
                end
            end
            3'b110:begin
				//color detection state 
            if (((R > 700 && B > 700) && G > 700) &&(R < 2500 &&  (B < 2500 && G < 2500)))begin
                if (R < B && R < G)begin
                    //RED
                        if (count_red < 50)begin
                            count_red <= count_red + 1;
                        end
                        else if (count_red == 50)begin
                            count_red <= 50;
                            count_blue <= 0;
                            count_green <= 0;
									 count_bw <= 0;
                        end
                        red <= 1;
                        green <= 0;
                        blue <= 0;
                        // count_blue <= 0;
                        // count_green <= 0;
                        display[23:16] <= "M";
                end
                else if (B < R && (B < G))begin
                    //BLUE 
                    if (count_blue < 50)begin
                        count_blue <= count_blue + 1; 
                    end
                    else if (count_blue == 50) begin
                        count_blue <= 50;
                        count_green <= 0;
                        count_red <= 0;
								count_bw <= 0;
                    end
                        red <= 0;
                        green <= 0;
                        blue <= 1;
                        // count_red <= 0;
                        // count_green <= 0;
                        display[23:16] <= "W";
                end
                else if (G < R && (G < B))begin
                    //GREEN
                    if (count_green < 50)begin
                        count_green <= count_green + 1;
                    end
                    else if (count_green == 50) begin
                        count_green <= 50;
                        count_blue <= 0;
                        count_red <= 0;
								count_bw <= 0;
                    end
                        red <= 0;
                        green <= 1;
                        blue <= 0;
                        // count_blue <= 0;
                        // count_red <= 0;
                        display[23:16] <= "D";
                end
            end
            else begin
                red <= 0;
                green <= 0;
                blue <= 0;
					 if (count_bw < 100)begin
						count_bw <= count_bw + 1;
					 end
					 else begin
						count_bw <= 100;
                  count_blue <= 0;
                  count_green <= 0;
                  count_red <= 0;
					 end
            end
            if((count_blue == 49 || count_green == 49 ) || count_red == 49)begin
                state <= 3'b111;
            end
            else begin
                state <= 3'b000;
               end
            //state <= 3'b111;
            end
            3'b111:begin
                if (l1 == 0 /*|| sel == 3*/)begin
                    R1 <= red;
                    G1 <= green;
                    B1 <= blue;
                    l1 <= 1;
                    //sel <= 1;
                    xb <= 0;
						  display[39:32] <= 1;
                end
                else if (l2 == 0 /*|| sel == 1*/)begin
                    R2 <= red;
                    G2 <= green;
                    B2 <= blue;
                    l2 <= 1;
                    //sel <= 2;
                    xb <= 0;
						  display[39:32] <= 2;
                end
                else if (l3 == 0 /*|| sel == 2*/)begin
                    R3 <= red;
                    G3 <= green;
                    B3 <= blue;
                    l3 <= 1;
                    //sel <= 3;
                    xb <= 0;
						  display[39:32] <= 3;
            end
                state <= 3'b000;
            end
			default:state <= 3'b000;	
        endcase        
    end    
endmodule