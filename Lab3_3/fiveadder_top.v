`include "fiveadder.v"
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:59 02/02/2024
// Design Name:   fiveadder
// Module Name:   /media/mahaarajan/HP USB20FD/CS220/Lab3_3/fiveadder/fiveadder_top.v
// Project Name:  fiveadder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fiveadder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fiveadder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg ROT_SWITCH;
	reg [3:0] t;

	// Outputs
	wire [5:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	fiveadder uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.ROT_SWITCH(ROT_SWITCH), 
		.t(t), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		PB1 = 0;
		PB2 = 0;
		PB3 = 0;
		PB4 = 0;
		ROT_SWITCH = 0;
		t = 0;
		#10
		t<=4'b1111;
		#4
		PB1<=1'b1;
		#2
		t<= 4'b1111;
		#2
		PB2<=1'b1;
		#2
		t<= 4'b1111;
		#2
		PB3<=1'b1;
		#2
		t<= 4'b1111;
		#2
		PB4<=1'b1;
		#2
		t<= 4'b1111;
		#2
		ROT_SWITCH<=1'b1;
		#2
		$finish;
	end
	always @(sum,cout) begin
	$display("The sum is %b. Carry is %b. time %d ",sum,cout,$time);
   end
endmodule

