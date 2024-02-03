`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   13:18:15 02/02/2024
// Design Name:   blink
// Module Name:   /media/mahaarajan/HP USB20FD/Mak labs/Rippling_light/wrap_top.v
// Project Name:  Rippling_light
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: blink
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module wrap_top;

 // Inputs
 reg clk;

 // Outputs
 wire [7:0] led;

 // Instantiate the Unit Under Test (UUT)
 blink uut (
 .clk(clk),
 .led(led)
 );
 initial begin
 forever begin
 clk=0;
 #2
 clk=1;
 #2
 clk=0;
 end
 end
 always @(led) begin
 $display("time:%d, config: %b",$time,led);
 end
 initial begin
 // Initialize Inputs
 #10000000;
 $finish;
 end

endmodule

