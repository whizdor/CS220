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
module top(clk, data, PB1, PB2, ROT_A, ROT_B, LCD_E, LCD_RS, LCD_RW, data_stream);

	// Inputs
	input clk, ROT_A, ROT_B, PB1, PB2;
	input [3:0] data;

	//Output
	output wire LCD_E, LCD_RS, LCD_RW;
	output [3:0] data_stream;

	//Internal Signals
	reg [2:0] cmd;
	reg [3:0] count;
	reg prev_rot_event;
	wire rot_event;
	reg flag = 1;
	reg [4:0] read_address_1, read_address_2, write_address;
	reg [15:0] write_data_stream;
	wire [15:0] write_data_stream_bus;
	wire [15:0] bus_1;
	wire [15:0] bus_2;
	reg [15:0] register [0:31];
	//LCD
	reg [7:0] ASCII_ROM[0:9];
	reg [0:127] first_line, second_line;
	reg display_start;
	wire display_end;
	reg data_done;
	wire [15:0] compare, sub, shift;
	reg [3:0] bit_shift;


	initial begin
		prev_rot_event = 0;
		count=0;
		display_start=0;
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

	assign bus_1[15:0] = register[read_address_1];
	assign bus_2[15:0] = register[read_address_2];
	assign write_data_stream_bus = write_data_stream;

	assign compare = $signed(register[read_address_1]) < $signed(register[read_address_2])
	assign sub = register[read_address_2] ^ register[read_address_1];
	assign shift = register[read_address_1] >>> bit_shift;

	rotary uut1(clk, ROT_A, ROT_B, rot_event);
	display uut2(first_line , second_line , display_start, clk , LCD_RS , LCD_RW , LCD_E , data_stream[0], data_stream[1], data_stream[2], data_stream[3], display_end);

	always @(posedge PB1) begin
		cmd[2:0]=data[2:0];
	end

	//Reset
	always@(posedge PB2) begin
		flag=~flag;
	end

	always @(posedge clk) begin
		prev_rot_event <= rot_event;
		if (display_end == 1) begin
				count = 0;
				display_start = 0;
		end
		if(flag==0) begin
			count=0;
		end
		if(prev_rot_event == 0 && rot_event == 1 && flag==1) begin
			if(cmd==0) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					write_address[4:1]<=data[3:0];
					count=2;
				end

				else if(count==2) begin
					write_address[0]<=data[0];
					count=3;
				end
				else if(count==3) begin      
					write_data_stream[15:12]<=data[3:0];
					count=4;
				end
				else if(count==4) begin      
					write_data_stream[11:8]<=data[3:0];
					count=5;
				end
				else if(count==5) begin      
					write_data_stream[7:4]<=data[3:0];
					count=6;
				end
				else if(count==6) begin      
					write_data_stream[3:0]<=data[3:0];
					data_done = 1;
					count=7;
				end
				else if(count==7) begin
					register[write_address]<=write_data_stream;
					count=8;
				end
				else if (count==8) begin
					first_line <= {ASCII_ROM[write_address[4]], ASCII_ROM[write_address[3]], ASCII_ROM[write_address[2]], ASCII_ROM[write_address[1]], ASCII_ROM[write_address[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[write_data_stream[15]], ASCII_ROM[write_data_stream[14]], ASCII_ROM[write_data_stream[13]],ASCII_ROM[write_data_stream[12]], ASCII_ROM[write_data_stream[11]], ASCII_ROM[write_data_stream[10]], ASCII_ROM[write_data_stream[9]], ASCII_ROM[write_data_stream[8]],ASCII_ROM[write_data_stream[7]], ASCII_ROM[write_data_stream[6]], ASCII_ROM[write_data_stream[5]], ASCII_ROM[write_data_stream[4]], ASCII_ROM[write_data_stream[3]], ASCII_ROM[write_data_stream[2]], ASCII_ROM[write_data_stream[1]], ASCII_ROM[write_data_stream[0]]};
					display_start=1;
				end
			end
			
			else if(cmd==1) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end

				else if(count==2) begin       
					read_address_1[0]<=data[0];
					data_done = 1;
					count=3;
				end
				else if(count==3 && data_done==1) begin
					first_line <= {ASCII_ROM[read_address_1[4]], ASCII_ROM[read_address_1[3]], ASCII_ROM[read_address_1[2]], ASCII_ROM[read_address_1[1]], ASCII_ROM[read_address_1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[bus_1[15]], ASCII_ROM[bus_1[14]], ASCII_ROM[bus_1[13]],ASCII_ROM[bus_1[12]], ASCII_ROM[bus_1[11]], ASCII_ROM[bus_1[10]], ASCII_ROM[bus_1[9]], ASCII_ROM[bus_1[8]], ASCII_ROM[bus_1[7]], ASCII_ROM[bus_1[6]], ASCII_ROM[bus_1[5]], ASCII_ROM[bus_1[4]], ASCII_ROM[bus_1[3]], ASCII_ROM[bus_1[2]], ASCII_ROM[bus_1[1]], ASCII_ROM[bus_1[0]]};
					data_done = 0;
					display_start=1;
				end
			end
			
			else if(cmd==2) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end
				else if(count==2) begin        
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					read_address_2[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin          
					read_address_2[0]<=data[0];
					data_done = 1;
					count=5;
				end
				else if(count==5 && data_done==1) begin
					first_line <= {ASCII_ROM[bus_1[15]], ASCII_ROM[bus_1[14]], ASCII_ROM[bus_1[13]],ASCII_ROM[bus_1[12]], ASCII_ROM[bus_1[11]], ASCII_ROM[bus_1[10]], ASCII_ROM[bus_1[9]], ASCII_ROM[bus_1[8]], ASCII_ROM[bus_1[7]], ASCII_ROM[bus_1[6]], ASCII_ROM[bus_1[5]], ASCII_ROM[bus_1[4]], ASCII_ROM[bus_1[3]], ASCII_ROM[bus_1[2]], ASCII_ROM[bus_1[1]], ASCII_ROM[bus_1[0]]};
					second_line <= {ASCII_ROM[bus_2[15]], ASCII_ROM[bus_2[14]], ASCII_ROM[bus_2[13]],ASCII_ROM[bus_2[12]], ASCII_ROM[bus_2[11]], ASCII_ROM[bus_2[10]], ASCII_ROM[bus_2[9]], ASCII_ROM[bus_2[8]], ASCII_ROM[bus_2[7]], ASCII_ROM[bus_2[6]], ASCII_ROM[bus_2[5]], ASCII_ROM[bus_2[4]], ASCII_ROM[bus_2[3]], ASCII_ROM[bus_2[2]], ASCII_ROM[bus_2[1]], ASCII_ROM[bus_2[0]]};
					data_done = 0;
					display_start=1;
				end
			end
			
			else if(cmd==3) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin          
					read_address_1[4:1]<=data[3:0];
					count=2;
				end

				else if(count==2) begin
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					write_address[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin
					write_address[0]<=data[0];
					count=5;
				end
				else if(count==5) begin      
					write_data_stream[15:12]<=data[3:0];
					count=6;
				end
				else if(count==6) begin      
					write_data_stream[11:8]<=data[3:0];
					count=7;
				end
				else if(count==7) begin      
					write_data_stream[7:4]<=data[3:0];
					count=8;
				end
				else if(count==8) begin      
					write_data_stream[3:0]<=data[3:0];
					data_done = 1;
					count=9;
				end
				else if(count==9 && data_done==1) begin
					register[write_address]<=write_data_stream_bus;
					
					count=10;
				end
				else if (count==10 && data_done==1) begin
					first_line <= {ASCII_ROM[read_address_1[4]], ASCII_ROM[read_address_1[3]], ASCII_ROM[read_address_1[2]], ASCII_ROM[read_address_1[1]], ASCII_ROM[read_address_1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[bus_1[15]], ASCII_ROM[bus_1[14]], ASCII_ROM[bus_1[13]],ASCII_ROM[bus_1[12]], ASCII_ROM[bus_1[11]], ASCII_ROM[bus_1[10]], ASCII_ROM[bus_1[9]], ASCII_ROM[bus_1[8]], 
										ASCII_ROM[bus_1[7]], ASCII_ROM[bus_1[6]], ASCII_ROM[bus_1[5]], ASCII_ROM[bus_1[4]], ASCII_ROM[bus_1[3]], ASCII_ROM[bus_1[2]], ASCII_ROM[bus_1[1]], ASCII_ROM[bus_1[0]]};
					data_done = 0;
					display_start=1;
				end

			end
			else if(cmd==4) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end
				else if(count==2) begin           
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					read_address_2[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin
					read_address_2[0]<=data[0];
					count=5;
				end
				else if(count==5) begin       
					write_address[4:1]<=data[3:0];
					count=6;
				end
				else if(count==6) begin
					write_address[0]<=data[0];
					count=7;
				end
				else if(count==7) begin      
					write_data_stream[15:12]<=data[3:0];
					count=8;
				end
				else if(count==8) begin      
					write_data_stream[11:8]<=data[3:0];
					count=9;
				end
				else if(count==9) begin      
					write_data_stream[7:4]<=data[3:0];
					count=10;
				end
				else if(count==10) begin      
					write_data_stream[3:0]<=data[3:0];
					data_done = 1;
					count=11;
				end

				else if(count==11 && data_done==1) begin
					register[write_address]<=write_data_stream_bus;
					count=12;
				end
				else if (count==12 && data_done==1) begin
					first_line <= {ASCII_ROM[bus_1[15]], ASCII_ROM[bus_1[14]], ASCII_ROM[bus_1[13]],ASCII_ROM[bus_1[12]], ASCII_ROM[bus_1[11]], ASCII_ROM[bus_1[10]], ASCII_ROM[bus_1[9]], ASCII_ROM[bus_1[8]], 
										ASCII_ROM[bus_1[7]], ASCII_ROM[bus_1[6]], ASCII_ROM[bus_1[5]], ASCII_ROM[bus_1[4]], ASCII_ROM[bus_1[3]], ASCII_ROM[bus_1[2]], ASCII_ROM[bus_1[1]], ASCII_ROM[bus_1[0]]};
					second_line <= {ASCII_ROM[bus_2[15]], ASCII_ROM[bus_2[14]], ASCII_ROM[bus_2[13]],ASCII_ROM[bus_2[12]], ASCII_ROM[bus_2[11]], ASCII_ROM[bus_2[10]], ASCII_ROM[bus_2[9]], ASCII_ROM[bus_2[8]], 
										ASCII_ROM[bus_2[7]], ASCII_ROM[bus_2[6]], ASCII_ROM[bus_2[5]], ASCII_ROM[bus_2[4]], ASCII_ROM[bus_2[3]], ASCII_ROM[bus_2[2]], ASCII_ROM[bus_2[1]], ASCII_ROM[bus_2[0]]};
					data_done = 0;
					display_start=1;
				end

			end
			else if(cmd==5) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end
				else if(count==2) begin           
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					read_address_2[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin
					read_address_2[0]<=data[0];
					count=5;
				end
				else if(count==5) begin       
					write_address[4:1]<=data[3:0];
					count=6;
				end
				else if(count==6) begin
					write_address[0]<=data[0];
					data_done = 1;
					count=7;
				end
				else if(count==7 && data_done==1) begin
					register[write_address]<=compare;
					count=8;
				end
				else if(count==8 && data_done==1) begin
					first_line <= {ASCII_ROM[write_address[4]], ASCII_ROM[write_address[3]], ASCII_ROM[write_address[2]], ASCII_ROM[write_address[1]], ASCII_ROM[write_address[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[compare[15]], ASCII_ROM[compare[14]], ASCII_ROM[compare[13]],ASCII_ROM[compare[12]], ASCII_ROM[compare[11]], ASCII_ROM[compare[10]], ASCII_ROM[compare[9]], ASCII_ROM[compare[8]],ASCII_ROM[compare[7]], ASCII_ROM[compare[6]], ASCII_ROM[compare[5]], ASCII_ROM[compare[4]], ASCII_ROM[compare[3]], ASCII_ROM[compare[2]], ASCII_ROM[compare[1]], ASCII_ROM[compare[0]]};
					data_done = 0;
					display_start=1;
				end

			end
			else if(cmd==6) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end
				else if(count==2) begin           
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					read_address_2[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin
					read_address_2[0]<=data[0];
					count=5;
				end
				else if(count==5) begin       
					write_address[4:1]<=data[3:0];
					count=6;
				end
				else if(count==6) begin
					write_address[0]<=data[0];
					data_done = 1;
					count=7;
				end
				else if(count==7 && data_done==1) begin
					register[write_address]<=sub;
					count=8;
				end
				else if(count==8 && data_done==1) begin
					first_line <= {ASCII_ROM[write_address[4]], ASCII_ROM[write_address[3]], ASCII_ROM[write_address[2]], ASCII_ROM[write_address[1]], ASCII_ROM[write_address[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[sub[15]], ASCII_ROM[sub[14]], ASCII_ROM[sub[13]],ASCII_ROM[sub[12]], ASCII_ROM[sub[11]], ASCII_ROM[sub[10]], ASCII_ROM[sub[9]], ASCII_ROM[sub[8]],ASCII_ROM[sub[7]], ASCII_ROM[sub[6]], ASCII_ROM[sub[5]], ASCII_ROM[sub[4]], ASCII_ROM[sub[3]], ASCII_ROM[sub[2]], ASCII_ROM[sub[1]], ASCII_ROM[sub[0]]};
					data_done = 0;
					display_start=1;
				end
			
			end
			else if(cmd==7) begin
				if(count==0) begin        
					count=1;
				end
				else if(count==1) begin       
					read_address_1[4:1]<=data[3:0];
					count=2;
				end
				else if(count==2) begin           
					read_address_1[0]<=data[0];
					count=3;
				end
				else if(count==3) begin       
					write_address[4:1]<=data[3:0];
					count=4;
				end
				else if(count==4) begin
					write_address[0]<=data[0];
					count=5;
				end
				else if(count==5) begin      
					bit_shift[3:0]<=data[3:0];
					data_done = 1;
					count=6;
				end
				else if(count==6 && data_done==1) begin
					register[write_address]<=shift;
					count=7;
				end
				else if(count==7 && data_done==1) begin
					first_line <= {ASCII_ROM[write_address[4]], ASCII_ROM[write_address[3]], ASCII_ROM[write_address[2]], ASCII_ROM[write_address[1]], ASCII_ROM[write_address[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
					second_line <= {ASCII_ROM[shift[15]], ASCII_ROM[shift[14]], ASCII_ROM[shift[13]],ASCII_ROM[shift[12]], ASCII_ROM[shift[11]], ASCII_ROM[shift[10]], ASCII_ROM[shift[9]], ASCII_ROM[shift[8]],ASCII_ROM[shift[7]], ASCII_ROM[shift[6]], ASCII_ROM[shift[5]], ASCII_ROM[shift[4]], ASCII_ROM[shift[3]], ASCII_ROM[shift[2]], ASCII_ROM[shift[1]], ASCII_ROM[shift[0]]};
					data_done = 0;
					display_start=1;				
				end
			end
		end
	end
endmodule
