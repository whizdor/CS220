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

input clk;
input [127:0]first_line,second_line;
output wire LCD_E, LCD_W, LCD_RS;
output wire [3:0] data;

reg [32:0] counter;
reg [2:0] state;

reg LCD_E_r, LCD_W_r, LCD_RS_r;
reg [3:0] data_r;
reg [1:0] steps;
reg [7:0] index1,first_line_index,index3,second_line_index;

initial 
begin
	steps=0;
	state=0;
	counter=0;
	LCD_E_r=0;
	LCD_W_r=0;
	LCD_RS_r =0;
	index1 = 55; 
	first_line_index=127;
	index3=7;
	second_line_index=127; 
	
end

wire[55:0] init_ROM;
wire[7:0] line_break_ROM;
assign init_ROM=56'h333228060C0180;
assign line_break_ROM = 8'hC0;

always @(posedge clk)
begin
	counter = counter + 1;
	if(counter == 1000000 && state==3'b000)
	begin
		if(steps==2'b00)
		begin
			LCD_E_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			data_r[3] = init_ROM[index1];
			data_r[2] = init_ROM[index1-1];
			data_r[1] = init_ROM[index1-2];
			data_r[0] = init_ROM[index1-3];
			steps=steps+1;	
		end
		else if(steps == 2'b10)
		begin
			
			if (index1 == 3)
			begin
				state = 3'b001;
				steps=0;
			end
			LCD_E_r=1;
			steps = 0;
			index1 = index1-4;
		end
		counter = 0;
	end
	else if(state == 3'b001 && counter == 1000000)
	begin
		
		if(steps==2'b00)
		begin
			LCD_E_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			LCD_RS_r =1;
			LCD_W_r =0;
			data_r[3] = first_line[first_line_index];
			data_r[2] = first_line[first_line_index-1];
			data_r[1] = first_line[first_line_index-2];
			data_r[0] = first_line[first_line_index-3];
			steps=steps+1;
			
		end
		else if(steps == 2'b10)
		begin
			if (first_line_index ==3)
			begin
				state = 3'b010;
				steps=0;
			end
			LCD_E_r=1;
			steps = 0;
			first_line_index = first_line_index-4;
		end
		counter = 0;
	end
	else if(state == 3'b010 && counter == 1000000)
	begin
		
		if(steps == 2'b00)
		begin
			LCD_E_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			LCD_RS_r=0;
			LCD_W_r=0;
			data_r[3] = line_break_ROM[index3];
			data_r[2] = line_break_ROM[index3-1];
			data_r[1] = line_break_ROM[index3-2];
			data_r[0] = line_break_ROM[index3-3];
			steps=steps+1;
		end
		else if(steps == 2'b10)
		begin
			if (index3 ==3)
			begin
				state = 3'b011;
				steps=0;
			end
			LCD_E_r=1;
			steps = 0;
			index3 = index3-4;
		end
		counter = 0;
	end
	else if(state == 3'b011 && counter == 1000000)
	begin
		if(steps==2'b00)
		begin
			LCD_E_r=0;
			steps = steps+1;
		end
		else if(steps == 2'b01)
		begin
			LCD_RS_r=1;
			LCD_W_r=0;
			data_r[3] = second_line[second_line_index];
			data_r[2] = second_line[second_line_index-1];
			data_r[1] = second_line[second_line_index-2];
			data_r[0] = second_line[second_line_index-3];
			steps=steps+1;	
		end
		else if(steps == 2'b10)
		begin
			if (second_line_index ==3)
			begin
				state = 3'b100;
			end
			LCD_E_r=1;
			steps = 0;
			second_line_index = second_line_index-4;
		end
		counter = 0;
	end	
end


assign data[3:0] = data_r[3:0];
assign LCD_E = LCD_E_r;
assign LCD_W = LCD_W_r;
assign LCD_RS = LCD_RS_r; 

endmodule



