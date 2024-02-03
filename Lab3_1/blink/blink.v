`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:48 01/31/2024 
// Design Name: 
// Module Name:    blink 
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
`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)

module blink(clk, q);

    // Inputs
    input clk;
    // Outputs
    output reg q = 1'b0;
	 
    
    // Temporary counter
    reg [31:0] temp = 0;
	 reg [31:0] counter = 0;
	 
	 always@(posedge clk)
	 begin
		temp <= counter;
		counter <= temp + 1;
        if (counter == `OFF_TIME) begin
            q <= 0;
        end
		  if (counter == `ON_TIME) begin
				q <= 1;
				counter <= 0;
		  end
    end
endmodule
