`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:39:50 04/03/2024 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk, input, PB1, PB2, ROT_A, ROT_B, LCD_E, LCD_RS, LCD_RW, data);

input clk, ROT_A, ROT_B, PB1, PB2;
input [3:0] input;

output wire LCD_E, LCD_RS, LCD_RW;
output [3:0] data;

reg [2:0] cmd;
reg [3:0] count;
reg prev_rot_event;
wire rot_event;

reg [4:0] read_address_1;
reg [4:0] read_address_2;
reg [4:0] write_addr;

reg [15:0] write_data;
wire [15:0] write_data_bus;
wire [15:0] bus1;
wire [15:0] bus2;

reg [15:0] register [0:31];
reg [7:0] ASCII_ROM[0:9];
reg [0:127] first_line;
reg [0:127] second_line;
reg display_start;
wire display_end;
reg input_done;
wire [15:0] compare;
wire [15:0] sub;
wire [15:0] shift;
reg [3:0] bit_shift;
reg flag=1;

initial begin
	prev_rot_event = 0;
	count=0;
	display_start=0;
	//input_done=0;
	//display_end=0;
	ASCII_ROM[0] = 8'd48;
	ASCII_ROM[1] = 8'd49;
	ASCII_ROM[2] = 8'd50;
	ASCII_ROM[3] = 8'd51;
	ASCII_ROM[4] = 8'd52;
	ASCII_ROM[5] = 8'd53;
	ASCII_ROM[6] = 8'd54;
	ASCII_ROM[7] = 8'd55;
	ASCII_ROM[8] = 8'd56;
	ASCII_ROM[9] = 8'd57;
end

initial begin
	register[0] = 16'd0;
	register[1] = 16'd0;
	register[2] = 16'd0;
	register[3] = 16'd0;
	register[4] = 16'd0;
	register[5] = 16'd0;
	register[6] = 16'd0;
	register[7] = 16'd0;
	register[8] = 16'd0;
	register[9] = 16'd0;
	register[10] = 16'd0;
	register[11] = 16'd0;
	register[12] = 16'd0;
	register[13] = 16'd0;
	register[14] = 16'd0;
	register[15] = 16'd0;
	register[16] = 16'd0;
	register[17] = 16'd0;
	register[18] = 16'd0;
	register[19] = 16'd0;
	register[20] = 16'd0;
	register[21] = 16'd0;
	register[22] = 16'd0;
	register[23] = 16'd0;
	register[24] = 16'd0;
	register[25] = 16'd0;
	register[26] = 16'd0;
	register[27] = 16'd0;
	register[28] = 16'd0;
	register[29] = 16'd0;
	register[30] = 16'd0;
	register[31] = 16'd0;
end

assign bus1[15:0] = register[read_address_1];
assign bus2[15:0] = register[read_address_2];
assign write_data_bus = write_data;

//assign compare = register[read_address_2] + register[read_address_1];
//have to change this part
//eight_bit_comparator EBC(register[read_address_1], register[read_address_2], compare);
assign compare = $signed(register[read_address_1]) < $signed(register[read_address_2])
assign sub = register[read_address_2] ^ register[read_address_1];
assign shift = register[read_address_1] >>> bit_shift;

rotary uut1(clk, ROT_A, ROT_B, rot_event);
display uut2(first_line , second_line , display_start, clk , LCD_RS , LCD_RW , LCD_E , data[0], data[1], data[2], data[3], display_end);

always @(posedge PB1) begin
	cmd[2:0]=input[2:0];
end

always@(posedge PB2) begin
	//input_done = 0;
	flag=~flag;
	//count = 0;
end

always @(posedge clk) begin
	prev_rot_event <= rot_event;
	if (display_end == 1) begin
			count = 0;
			// input_done = 0;
			display_start = 0;
	end
	if(flag==0) begin
		count=0;
	end
	if(prev_rot_event == 0 && rot_event == 1 && flag==1) begin
		if(cmd==0) begin
			if(count==0) begin        //write_addr address of register
				//write_addr[4:1]<=input[3:0];
				count=1;
			end
			else if(count==1) begin        //write_addr address of register
				write_addr[4:1]<=input[3:0];
				count=2;
			end

			else if(count==2) begin
				write_addr[0]<=input[0];
				count=3;
			end
			else if(count==3) begin      //write_addr data
				write_data[15:12]<=input[3:0];
				count=4;
			end
			else if(count==4) begin      //write_addr data
				write_data[11:8]<=input[3:0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				write_data[7:4]<=input[3:0];
				count=6;
			end
			else if(count==6) begin      //write_addr data
				write_data[3:0]<=input[3:0];
				input_done = 1;
				count=7;
			end
			else if(count==7) begin
				register[write_addr]<=write_data;
				count=8;
			end
			else if (count==8) begin
				first_line <= {ASCII_ROM[write_addr[4]], ASCII_ROM[write_addr[3]], ASCII_ROM[write_addr[2]], ASCII_ROM[write_addr[1]], ASCII_ROM[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ASCII_ROM[write_data[15]], ASCII_ROM[write_data[14]], ASCII_ROM[write_data[13]],ASCII_ROM[write_data[12]], ASCII_ROM[write_data[11]], ASCII_ROM[write_data[10]], ASCII_ROM[write_data[9]], ASCII_ROM[write_data[8]],ASCII_ROM[write_data[7]], ASCII_ROM[write_data[6]], ASCII_ROM[write_data[5]], ASCII_ROM[write_data[4]], ASCII_ROM[write_data[3]], ASCII_ROM[write_data[2]], ASCII_ROM[write_data[1]], ASCII_ROM[write_data[0]]};
				//input_done = 0;
				display_start=1;
				//count=0;
			end
			// count<=count+1;
		end
		
		else if(cmd==1) begin
			if(count==0) begin        
				//read_address_1[4:1]<=input[3:0];
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end

			else if(count==2) begin        //read address of register
				read_address_1[0]<=input[0];
				input_done = 1;
				count=3;
			end
			else if(count==3 && input_done==1) begin
				first_line <= {ASCII_ROM[read_address_1[4]], ASCII_ROM[read_address_1[3]], ASCII_ROM[read_address_1[2]], ASCII_ROM[read_address_1[1]], ASCII_ROM[read_address_1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				/*second_line <= {ASCII_ROM[register[read_address_1][15]], ASCII_ROM[register[read_address_1][14]], ASCII_ROM[register[read_address_1][13]],ASCII_ROM[register[read_address_1][12]], ASCII_ROM[register[read_address_1][11]], ASCII_ROM[register[read_address_1][10]], ASCII_ROM[register[read_address_1][9]], ASCII_ROM[register[read_address_1][8]], 
									ASCII_ROM[register[read_address_1][7]], ASCII_ROM[register[read_address_1][6]], ASCII_ROM[register[read_address_1][5]], ASCII_ROM[register[read_address_1][4]], ASCII_ROM[register[read_address_1][3]], ASCII_ROM[register[read_address_1][2]], ASCII_ROM[register[read_address_1][1]], ASCII_ROM[register[read_address_1][0]]};*/
				second_line <= {ASCII_ROM[bus1[15]], ASCII_ROM[bus1[14]], ASCII_ROM[bus1[13]],ASCII_ROM[bus1[12]], ASCII_ROM[bus1[11]], ASCII_ROM[bus1[10]], ASCII_ROM[bus1[9]], ASCII_ROM[bus1[8]], 
									ASCII_ROM[bus1[7]], ASCII_ROM[bus1[6]], ASCII_ROM[bus1[5]], ASCII_ROM[bus1[4]], ASCII_ROM[bus1[3]], ASCII_ROM[bus1[2]], ASCII_ROM[bus1[1]], ASCII_ROM[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==2) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end
			else if(count==2) begin         //read address of register
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_address_2[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin           //read address of register
				read_address_2[0]<=input[0];
				input_done = 1;
				count=5;
			end
			else if(count==5 && input_done==1) begin
				first_line <= {ASCII_ROM[bus1[15]], ASCII_ROM[bus1[14]], ASCII_ROM[bus1[13]],ASCII_ROM[bus1[12]], ASCII_ROM[bus1[11]], ASCII_ROM[bus1[10]], ASCII_ROM[bus1[9]], ASCII_ROM[bus1[8]], 
									ASCII_ROM[bus1[7]], ASCII_ROM[bus1[6]], ASCII_ROM[bus1[5]], ASCII_ROM[bus1[4]], ASCII_ROM[bus1[3]], ASCII_ROM[bus1[2]], ASCII_ROM[bus1[1]], ASCII_ROM[bus1[0]]};
				second_line <= {ASCII_ROM[bus2[15]], ASCII_ROM[bus2[14]], ASCII_ROM[bus2[13]],ASCII_ROM[bus2[12]], ASCII_ROM[bus2[11]], ASCII_ROM[bus2[10]], ASCII_ROM[bus2[9]], ASCII_ROM[bus2[8]], 
									ASCII_ROM[bus2[7]], ASCII_ROM[bus2[6]], ASCII_ROM[bus2[5]], ASCII_ROM[bus2[4]], ASCII_ROM[bus2[3]], ASCII_ROM[bus2[2]], ASCII_ROM[bus2[1]], ASCII_ROM[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==3) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin           //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end

			else if(count==2) begin
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				write_addr[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=input[0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				write_data[15:12]<=input[3:0];
				count=6;
			end
			else if(count==6) begin      //write_addr data
				write_data[11:8]<=input[3:0];
				count=7;
			end
			else if(count==7) begin      //write_addr data
				write_data[7:4]<=input[3:0];
				count=8;
			end
			else if(count==8) begin      //write_addr data
				write_data[3:0]<=input[3:0];
				input_done = 1;
				count=9;
			end
			else if(count==9 && input_done==1) begin
				register[write_addr]<=write_data_bus;
				
				count=10;
			end
			else if (count==10 && input_done==1) begin
				first_line <= {ASCII_ROM[read_address_1[4]], ASCII_ROM[read_address_1[3]], ASCII_ROM[read_address_1[2]], ASCII_ROM[read_address_1[1]], ASCII_ROM[read_address_1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ASCII_ROM[bus1[15]], ASCII_ROM[bus1[14]], ASCII_ROM[bus1[13]],ASCII_ROM[bus1[12]], ASCII_ROM[bus1[11]], ASCII_ROM[bus1[10]], ASCII_ROM[bus1[9]], ASCII_ROM[bus1[8]], 
									ASCII_ROM[bus1[7]], ASCII_ROM[bus1[6]], ASCII_ROM[bus1[5]], ASCII_ROM[bus1[4]], ASCII_ROM[bus1[3]], ASCII_ROM[bus1[2]], ASCII_ROM[bus1[1]], ASCII_ROM[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==4) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_address_2[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin
				read_address_2[0]<=input[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=input[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=input[0];
				count=7;
			end
			else if(count==7) begin      //write_addr data
				write_data[15:12]<=input[3:0];
				count=8;
			end
			else if(count==8) begin      //write_addr data
				write_data[11:8]<=input[3:0];
				count=9;
			end
			else if(count==9) begin      //write_addr data
				write_data[7:4]<=input[3:0];
				count=10;
			end
			else if(count==10) begin      //write_addr data
				write_data[3:0]<=input[3:0];
				input_done = 1;
				count=11;
			end

			else if(count==11 && input_done==1) begin
				register[write_addr]<=write_data_bus;
				count=12;
			end
			else if (count==12 && input_done==1) begin
				first_line <= {ASCII_ROM[bus1[15]], ASCII_ROM[bus1[14]], ASCII_ROM[bus1[13]],ASCII_ROM[bus1[12]], ASCII_ROM[bus1[11]], ASCII_ROM[bus1[10]], ASCII_ROM[bus1[9]], ASCII_ROM[bus1[8]], 
									ASCII_ROM[bus1[7]], ASCII_ROM[bus1[6]], ASCII_ROM[bus1[5]], ASCII_ROM[bus1[4]], ASCII_ROM[bus1[3]], ASCII_ROM[bus1[2]], ASCII_ROM[bus1[1]], ASCII_ROM[bus1[0]]};
				second_line <= {ASCII_ROM[bus2[15]], ASCII_ROM[bus2[14]], ASCII_ROM[bus2[13]],ASCII_ROM[bus2[12]], ASCII_ROM[bus2[11]], ASCII_ROM[bus2[10]], ASCII_ROM[bus2[9]], ASCII_ROM[bus2[8]], 
									ASCII_ROM[bus2[7]], ASCII_ROM[bus2[6]], ASCII_ROM[bus2[5]], ASCII_ROM[bus2[4]], ASCII_ROM[bus2[3]], ASCII_ROM[bus2[2]], ASCII_ROM[bus2[1]], ASCII_ROM[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==5) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_address_2[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin
				read_address_2[0]<=input[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=input[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=input[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				register[write_addr]<=compare;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {ASCII_ROM[write_addr[4]], ASCII_ROM[write_addr[3]], ASCII_ROM[write_addr[2]], ASCII_ROM[write_addr[1]], ASCII_ROM[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ASCII_ROM[compare[15]], ASCII_ROM[compare[14]], ASCII_ROM[compare[13]],ASCII_ROM[compare[12]], ASCII_ROM[compare[11]], ASCII_ROM[compare[10]], ASCII_ROM[compare[9]], ASCII_ROM[compare[8]],ASCII_ROM[compare[7]], ASCII_ROM[compare[6]], ASCII_ROM[compare[5]], ASCII_ROM[compare[4]], ASCII_ROM[compare[3]], ASCII_ROM[compare[2]], ASCII_ROM[compare[1]], ASCII_ROM[compare[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		end
		else if(cmd==6) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_address_2[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin
				read_address_2[0]<=input[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=input[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=input[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				register[write_addr]<=sub;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {ASCII_ROM[write_addr[4]], ASCII_ROM[write_addr[3]], ASCII_ROM[write_addr[2]], ASCII_ROM[write_addr[1]], ASCII_ROM[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ASCII_ROM[sub[15]], ASCII_ROM[sub[14]], ASCII_ROM[sub[13]],ASCII_ROM[sub[12]], ASCII_ROM[sub[11]], ASCII_ROM[sub[10]], ASCII_ROM[sub[9]], ASCII_ROM[sub[8]],ASCII_ROM[sub[7]], ASCII_ROM[sub[6]], ASCII_ROM[sub[5]], ASCII_ROM[sub[4]], ASCII_ROM[sub[3]], ASCII_ROM[sub[2]], ASCII_ROM[sub[1]], ASCII_ROM[sub[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		
		end
		else if(cmd==7) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_address_1[4:1]<=input[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_address_1[0]<=input[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				write_addr[4:1]<=input[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=input[0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				bit_shift[3:0]<=input[3:0];
				input_done = 1;
				count=6;
			end
			else if(count==6 && input_done==1) begin
				register[write_addr]<=shift;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				first_line <= {ASCII_ROM[write_addr[4]], ASCII_ROM[write_addr[3]], ASCII_ROM[write_addr[2]], ASCII_ROM[write_addr[1]], ASCII_ROM[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {ASCII_ROM[shift[15]], ASCII_ROM[shift[14]], ASCII_ROM[shift[13]],ASCII_ROM[shift[12]], ASCII_ROM[shift[11]], ASCII_ROM[shift[10]], ASCII_ROM[shift[9]], ASCII_ROM[shift[8]],ASCII_ROM[shift[7]], ASCII_ROM[shift[6]], ASCII_ROM[shift[5]], ASCII_ROM[shift[4]], ASCII_ROM[shift[3]], ASCII_ROM[shift[2]], ASCII_ROM[shift[1]], ASCII_ROM[shift[0]]};
				input_done = 0;
				display_start=1;				
				//count=0;
			end
			// count<=count+1;
		end
	end
	
end


endmodule
