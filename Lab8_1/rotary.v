`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:40:57 04/03/2024 
// Design Name: 
// Module Name:    rotary 
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

module rotary(clk, ROT_A, ROT_B, rot_event);
	input clk, ROT_A, ROT_B;
	output rot_event;
	reg rot_event;

	always@(posedge clk) begin
		if(ROT_A == 1 & ROT_B == 1) begin
			rot_event <= 1;
		end
		else if(ROT_A == 0 & ROT_B == 0) begin
			rot_event <= 0;
		end
	end
endmodule
