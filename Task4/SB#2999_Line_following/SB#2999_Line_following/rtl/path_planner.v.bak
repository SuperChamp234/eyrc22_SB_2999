// SM : Task 2 C : Path Planning
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design path planner.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Path Planner design
//Parameters : node_count : for total no. of nodes + 1 (consider an imaginary node, refer discuss forum),
//					max_edges : no. of max edges for every node.


//Inputs  	 : clk : 50 MHz clock, 
//				   start : start signal to initiate the path planning,
//				   s_node : start node,
//				   e_node : destination node.
//
//Output     : done : Path planning completed signal,
//             final_path : the final path from start to end node.



//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////

module path_planner
#(parameter node_count = 27, parameter max_edges = 4)
(
	input clk,
	input start,
	input [4:0] s_node,
	input [4:0] e_node,
	output reg done,	
	output reg [10*5-1:0] final_path
);

////////////////////////WRITE YOUR CODE FROM HERE////////////////////
reg [4:0] i;
reg [4:0] j;
reg [4:0] temp;
parameter [6:0] infinity = 7'b1111111; //infinity
reg [4:0] cost_matrix[0:25][0:25]; //maze cost cost_matrix
reg [12:0] dist_h [0:25]; //keep track of previous visited nodes
reg [12:0] dist [0:25]; //keep track of current visited nodes
reg [10*5-1:0] final_path_reg = 0; //{10{5'd27}};
parameter IDLE = 0, S0 = 1, S1 = 2, S2 = 3;


//feed the maze into the ROM
initial begin

	for(i = 0; i<node_count-1;i=i+1) begin
		//dist[i] = 0;
		//dist_h[i] = 0;
		dist[i] = {1'b0,s_node[4:0],{infinity}};
		dist_h[i] = {1'b0,s_node[4:0],{infinity}};
	end
	

	cost_matrix [0][1] = 3'd3 ;
	cost_matrix [1][0] = 3'd3 ;
	cost_matrix [1][2] = 3'd3 ;
	cost_matrix [1][13] = 3'd3 ;
	cost_matrix [2][1] = 3'd3 ;
	cost_matrix [2][3] = 3'd1 ;
	cost_matrix [2][5] = 3'd3 ;
	cost_matrix [3][2] = 3'd1 ;
	cost_matrix [4][6] = 3'd3 ;
	cost_matrix [5][2] = 3'd3 ;
	cost_matrix [5][6] = 3'd1 ;
	cost_matrix [5][9] = 3'd2 ;
	cost_matrix [6][4] = 3'd3 ;
	cost_matrix [6][5] = 3'd1 ;
	cost_matrix [6][16] = 3'd3 ;
	cost_matrix [7][12] = 3'd2 ;
	cost_matrix [8][9] = 3'd1 ;
	cost_matrix [9][5] = 3'd2 ;
	cost_matrix [9][8] = 3'd1 ;
	cost_matrix [9][15] = 3'd1 ;
	cost_matrix [10][16] = 3'd2 ;
	cost_matrix [11][12] = 3'd3 ;
	cost_matrix [12][7] = 3'd2 ;
	cost_matrix [12][11] = 3'd3 ;
	cost_matrix [12][13] = 3'd1 ;
	cost_matrix [12][17] = 3'd3 ;
	cost_matrix [13][1] = 3'd3 ;
	cost_matrix [13][12] = 3'd1 ;
	cost_matrix [13][18] = 3'd2 ;
	cost_matrix [14][15] = 3'd1 ;
	cost_matrix [15][9] = 3'd1 ;
	cost_matrix [15][14] = 3'd1 ;
	cost_matrix [15][22] = 3'd1 ;
	cost_matrix [16][6] = 3'd3 ;
	cost_matrix [16][10] = 3'd2 ;
	cost_matrix [16][23] = 3'd2 ;
	cost_matrix [17][12] = 3'd3 ;
	cost_matrix [18][13] = 3'd2 ;
	cost_matrix [18][19] = 3'd1 ;
	cost_matrix [18][20] = 3'd1 ;
	cost_matrix [19][18] = 3'd1 ;
	cost_matrix [20][18] = 3'd1 ;
	cost_matrix [20][21] = 3'd1 ;
	cost_matrix [20][22] = 3'd2 ;
	cost_matrix [21][20] = 3'd1 ;
	cost_matrix [22][15] = 3'd1 ;
	cost_matrix [22][20] = 3'd2;
	cost_matrix [22][23] = 3'd1;
	cost_matrix [22][25] = 3'd3;
	cost_matrix [23][16] = 3'd2;
	cost_matrix [23][22] = 3'd1;
	cost_matrix [23][24] = 3'd2;
	cost_matrix [24][23] = 3'd2;
	cost_matrix [25][22] = 3'd3;
	
	for(i = 0;i<node_count-1;i=i+1) begin
		cost_matrix[i][i] = 0;
	end
	
end 

reg [3:0] next_state = IDLE;
reg [4:0] shortest_path_iter;
reg [4:0] hold_update_mat_outing;
reg [12:0] min = 0;
reg [4:0] min_index = 0;
reg [12:0] sel = {1'b1,{1'b0,1'b0,1'b0,1'b0,1'b0},{infinity}};
reg [4:0] visited_count = 0;
reg [1:0] readflag = 1;
reg [3:0] count=0;


always @(posedge clk) begin

	case(next_state)
		IDLE: begin
			if(start==1) begin
				done = 0;
				visited_count =0;
				j = s_node;
				dist_h[s_node][12] = 1;
				count = 1;
				final_path_reg[4:0] = e_node;
				sel = {1'b1,s_node,{infinity}};
				next_state = S0;
			end
            i = 0; 
				dist[0] = {1'b0,s_node[4:0],{infinity}};dist[1] = {1'b0,s_node[4:0],{infinity}};dist[2] = {1'b0,s_node[4:0],{infinity}};dist[3] = {1'b0,s_node[4:0],{infinity}};dist[4] = {1'b0,s_node[4:0],{infinity}};dist[5] = {1'b0,s_node[4:0],{infinity}};dist[6] = {1'b0,s_node[4:0],{infinity}};dist[7] = {1'b0,s_node[4:0],{infinity}};dist[8] = {1'b0,s_node[4:0],{infinity}};dist[9] = {1'b0,s_node[4:0],{infinity}};dist[10] = {1'b0,s_node[4:0],{infinity}};dist[11] = {1'b0,s_node[4:0],{infinity}};dist[12] = {1'b0,s_node[4:0],{infinity}};
				dist[13] = {1'b0,s_node[4:0],{infinity}};dist[14] = {1'b0,s_node[4:0],{infinity}};dist[15] = {1'b0,s_node[4:0],{infinity}};dist[16] = {1'b0,s_node[4:0],{infinity}};dist[17] = {1'b0,s_node[4:0],{infinity}};dist[18] = {1'b0,s_node[4:0],{infinity}};dist[19] = {1'b0,s_node[4:0],{infinity}};dist[20] = {1'b0,s_node[4:0],{infinity}};dist[21] = {1'b0,s_node[4:0],{infinity}};dist[22] = {1'b0,s_node[4:0],{infinity}};dist[23] = {1'b0,s_node[4:0],{infinity}};dist[24] = {1'b0,s_node[4:0],{infinity}};dist[25] = {1'b0,s_node[4:0],{infinity}};
				
				dist_h[0] = {1'b0,s_node[4:0],{infinity}};dist_h[1] = {1'b0,s_node[4:0],{infinity}};dist_h[2] = {1'b0,s_node[4:0],{infinity}};dist_h[3] = {1'b0,s_node[4:0],{infinity}};dist_h[4] = {1'b0,s_node[4:0],{infinity}};dist_h[5] = {1'b0,s_node[4:0],{infinity}};dist_h[6] = {1'b0,s_node[4:0],{infinity}};dist_h[7] = {1'b0,s_node[4:0],{infinity}};dist_h[8] = {1'b0,s_node[4:0],{infinity}};dist_h[9] = {1'b0,s_node[4:0],{infinity}};dist_h[10] = {1'b0,s_node[4:0],{infinity}};dist_h[11] = {1'b0,s_node[4:0],{infinity}};dist_h[12] = {1'b0,s_node[4:0],{infinity}};
				dist_h[13] = {1'b0,s_node[4:0],{infinity}};dist_h[14] = {1'b0,s_node[4:0],{infinity}};dist_h[15] = {1'b0,s_node[4:0],{infinity}};dist_h[16] = {1'b0,s_node[4:0],{infinity}};dist_h[17] = {1'b0,s_node[4:0],{infinity}};dist_h[18] = {1'b0,s_node[4:0],{infinity}};dist_h[19] = {1'b0,s_node[4:0],{infinity}};dist_h[20] = {1'b0,s_node[4:0],{infinity}};dist_h[21] = {1'b0,s_node[4:0],{infinity}};dist_h[22] = {1'b0,s_node[4:0],{infinity}};dist_h[23] = {1'b0,s_node[4:0],{infinity}};dist_h[24] = {1'b0,s_node[4:0],{infinity}};dist_h[25] = {1'b0,s_node[4:0],{infinity}};
				
        end
		S0: begin //cost_matrix se value liya, we'll check if it's less than the near_row_hold values and if yes, we'll change the near_row array.
				//already visited and bigger values are simply just kept the same
			if(visited_count == 24) begin
				next_state <= S1;
				j=e_node;
				dist_h[s_node][11:7] = 5'b11011;
				final_path_reg[49:5] = {10{5'd27}};
				//$display("DONE");	
			end
			else if(i == node_count-2) begin         //check end of nodes
				min <= {1'b1,sel[11:0]};              //minimum = select(marked as done)
				visited_count <= visited_count + 1;   //increase visit count
				dist[min_index][12] = 1'b1;           //mark minimum index as visited
				//copy dist in prev dist
				dist_h[0] = dist[0] ; dist_h[1] = dist[1] ; dist_h[2] = dist[2] ; dist_h[3] = dist[3] ; dist_h[4] = dist[4] ; dist_h[5] = dist[5] ; dist_h[6] = dist[6] ; dist_h[7] = dist[7] ; dist_h[8] = dist[8] ; dist_h[9] = dist[9] ; dist_h[10] = dist[10] ; dist_h[11] = dist[11] ; dist_h[12] = dist[12] ; dist_h[13] = dist[13] ; dist_h[14] = dist[14] ; dist_h[15] = dist[15] ; dist_h[16] = dist[16] ; dist_h[17] = dist[17] ; dist_h[18] = dist[18] ; dist_h[19] = dist[19] ; dist_h[20] = dist[20] ; dist_h[21] = dist[21] ; dist_h[22] = dist[22] ; dist_h[23] = dist[23] ; dist_h[24] = dist[24] ; dist_h[25] = dist[25] ;
				j = min_index;   //next column node = minimum index
				i = -1;          
				sel =  {1'b1,{min_index[4:0]},{infinity}}; //selected node = minimum index marked as visited and with infinite distance
			end
			else if ( ((cost_matrix[j][i] + min[6:0]) < dist_h[i][6:0]) && (dist_h[i][12] != 1) ) begin
				dist[i] = {1'b0,j,{cost_matrix[j][i] + min[6:0]}};    //update node dstance if it is less than path(min)
			end
			else begin
				dist[i] = dist_h[i];
			end
			
			if((dist[i][6:0] < sel[6:0]) && (dist_h[i][12] != 1)) begin
				sel = {1'b0,j,dist[i][6:0]};
				min_index <= i;
			end
			//$display("min val:%0d",min[6:0]);
			//$display("%0d",next_state);
			//$display("%0d",visited_count);
			//$display("min_index: %0d",min_index);
            //$display(" %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d %0d ", dist[0][6:0], dist[1][6:0], dist[2][6:0], dist[3][6:0], dist[4][6:0], dist[5][6:0], dist[6][6:0], dist[7][6:0], dist[8][6:0], dist[9][6:0], dist[10][6:0], dist[11][6:0], dist[12][6:0], dist[13][6:0], dist[14][6:0], dist[15][6:0], dist[16][6:0], dist[17][6:0], dist[18][6:0], dist[19][6:0], dist[20][6:0], dist[21][6:0], dist[22][6:0], dist[23][6:0], dist[24][6:0], dist[25][6:0] ) ;
			i = i + 1;
		end
		S1: begin
			if(j == 5'b11011) begin
				done <= 1;
				next_state <= IDLE;
				//$display("DONE");
			end
			else begin
				//final_path_reg = (final_path_reg << 5) + dist_h[j][11:7];
				final_path_reg[(5*count+4)-:5] = dist_h[j][11:7];
				count = count+1;
				j = dist_h[j][11:7];
				//$display("j: %0d",j);
			end
		end
	endcase
end

always @(posedge start or posedge done) begin
	final_path <= final_path_reg;
end
	

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
