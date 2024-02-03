`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:56 01/31/2024 
// Design Name: 
// Module Name:    wrap 
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
`define SHIFT_TIME 50000000

module blink(clk, led);

    // Inputs
    input clk;
    // Outputs
    output [7:0] led;
    reg [7:0] led = 1;

    // Temporary counter
    reg [31:0] counter = 0;
	reg [31:0] temp = 0;

    // Logic for toggling the output
    always @(posedge clk) begin
	 temp <= counter;
	 counter <= temp + 1;
        if (counter == `SHIFT_TIME) begin
            led[1] <= led[0];
            led[2] <= led[1];
            led[3] <= led[2];
            led[4] <= led[3];
            led[5] <= led[4];
            led[6] <= led[5];
            led[7] <= led[6];
            led[0] <= led[7];
			counter <= 0;			
        end
    end

endmodule