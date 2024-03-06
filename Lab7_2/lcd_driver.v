`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:14 02/14/2024 
// Design Name: 
// Module Name:    lcd_driver 
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

module LCD_Driver( clk, first_line, second_line, LCD_E, LCD_W, LCD_RS, data);

	//Input
	input clk;
	input [127:0]first_line,second_line;

	//Output
	output wire LCD_E, LCD_W, LCD_RS;
	output wire [3:0] data;


	//Internal Variables
	reg [32:0] counter;
	reg [2:0] state;
	reg LCD_E_r, LCD_W_r, LCD_RS_r;
	reg [3:0] data_r;
	reg [1:0] steps;
	reg [7:0] ROM_index, first_line_index, line_break_index, second_line_index;
	wire[55:0] init_ROM;
	wire[7:0] line_break_ROM;
	assign init_ROM = 56'h333228060C0180;
	assign line_break_ROM = 8'hC0;

	initial 
	begin
		steps = 0;
		state = 0;
		counter = 0;
		LCD_E_r = 0;
		LCD_W_r = 0;
		LCD_RS_r = 0;
		ROM_index = 55; 
		first_line_index = 127;
		second_line_index = 127; 
		line_break_index = 7;
	end



	always @(posedge clk)
	begin
		counter = counter + 1;

		//Initialize and Configure the LED
		if(state == 0 && counter == 1000000)
		begin
			if(steps == 0)
			begin
				LCD_E_r = 0;
				steps = steps + 1;
			end

			else if(steps == 1)
			begin
				data_r[3] = init_ROM[ROM_index];
				data_r[2] = init_ROM[ROM_index-1];
				data_r[1] = init_ROM[ROM_index-2];
				data_r[0] = init_ROM[ROM_index-3];
				steps = steps + 1;	
			end

			else if(steps == 3)
			begin
				
				if (ROM_index == 3)
				begin
					state = 3'b001;
					steps = 0;
				end
				LCD_E_r = 1;
				steps = 0;
				ROM_index = ROM_index - 4;
			end
			counter = 0;
		end

		//First Line of LCD
		else if(state == 1 && counter == 1000000)
		begin	
			if(steps == 0)
			begin
				LCD_E_r = 0;
				steps = steps + 1;
			end

			else if(steps == 1)
			begin
				LCD_RS_r = 1;
				LCD_W_r = 0;
				data_r[3] = first_line[first_line_index];
				data_r[2] = first_line[first_line_index-1];
				data_r[1] = first_line[first_line_index-2];
				data_r[0] = first_line[first_line_index-3];
				steps = steps + 1;
			end

			else if(steps == 2)
			begin
				if (first_line_index ==3)
				begin
					state = 3'b010;
					steps = 0;
				end
				LCD_E_r = 1;
				steps = 0;
				first_line_index = first_line_index - 4;
			end
			counter = 0;
		end

		//Line Break
		else if(state == 2 && counter == 1000000)
		begin
			
			if(steps == 0)
			begin
				LCD_E_r = 0;
				steps = steps + 1;
			end

			else if(steps == 1)
			begin
				LCD_RS_r = 0;
				LCD_W_r = 0;
				data_r[3] = line_break_ROM[line_break_index];
				data_r[2] = line_break_ROM[line_break_index-1];
				data_r[1] = line_break_ROM[line_break_index-2];
				data_r[0] = line_break_ROM[line_break_index-3];
				steps = steps + 1;
			end

			else if(steps == 2)
			begin
				if (line_break_index ==3)
				begin
					state = 3;
					steps = 0;
				end
				LCD_E_r = 1;
				steps = 0;
				line_break_index = line_break_index-4;
			end
			counter = 0;
		end

		//Second Line of LCD
		else if(state == 3 && counter == 1000000)
		begin
			if(steps == 0)
			begin
				LCD_E_r=0;
				steps = steps + 1;
			end

			else if(steps == 1)
			begin
				LCD_RS_r = 1;
				LCD_W_r = 0;
				data_r[3] = second_line[second_line_index];
				data_r[2] = second_line[second_line_index-1];
				data_r[1] = second_line[second_line_index-2];
				data_r[0] = second_line[second_line_index-3];
				steps = steps + 1;	
			end

			else if(steps == 2)
			begin
				if (second_line_index ==3)
				begin
					state = 4;
				end
				LCD_E_r = 1;
				steps = 0;
				second_line_index = second_line_index - 4;
			end
			counter = 0;
		end	
	end

	assign data[3:0] = data_r[3:0];
	assign LCD_E = LCD_E_r;
	assign LCD_W = LCD_W_r;
	assign LCD_RS = LCD_RS_r; 
endmodule