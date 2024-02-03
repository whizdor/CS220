`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   12:52:33 02/02/2024
// Design Name:   Blinkin
// Module Name:   /media/mahaarajan/HP USB20FD/Mak labs/Blinkin/Blinkin_top.v
// Project Name:  Blinkin
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: Blinkin
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module blink_top;

 // Inputs
 reg clk;

 // Outputs
 wire led0;

 // Instantiate the Unit Under Test (UUT)
 blink uut (
 .clk(clk),
 .q(led0)
 );

 always @(led0) begin
 $display("time = %d, led= %d",$time, led0);
 end

 initial begin
 forever begin
 clk = 0;
 #2
 clk = 1;
 #2
 clk = 0;
 end
 end

 initial begin
 // Wait 1000000 ns for global reset to finish
 #100000000;

 // Add stimulus here
 $finish;
end

endmodule
