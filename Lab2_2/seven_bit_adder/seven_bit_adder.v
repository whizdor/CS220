`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:02:08 01/24/2024 
// Design Name: 
// Module Name:    seven_bit_adder 
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
/////////////////////////////////////////////////////////////////////////
module one_bit_full_adder(a,b,cin,sum,cout
    );
input a,b,cin;
output sum,cout;
wire sum,cout;

assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule

module seven_bit_adder (PB1, PB2, PB3, PB4, a, sum, cout);

   // Inputs
	input PB1,PB2,PB3,PB4;
   reg [6:0] x;
   reg [6:0] y;

	
	input [3:0] a;
	
	always@ (posedge PB1) begin
		x[3:0] = a[3:0];
	end
	
	always@ (posedge PB2) begin
		x[6:4] = a[2:0];
	end
	
	always@ (posedge PB3) begin
		y[3:0] = a[3:0];
	end
	
	always@ (posedge PB4) begin
		y[6:4] = a[2:0];
	end
	
	
   // Outputs
   output [6:0] sum;
   wire [6:0] sum;
   output cout;
   wire cout;

   // Intermediate wire
   wire [5:0] cintermediate;

   // Instantiating the 8 one-adder modules
   one_bit_full_adder FA0 (x[0], y[0], 1'b0, sum[0], cintermediate[0]);
   one_bit_full_adder FA1 (x[1], y[1], cintermediate[0], sum[1], cintermediate[1]);
   one_bit_full_adder FA2 (x[2], y[2], cintermediate[1], sum[2], cintermediate[2]);
   one_bit_full_adder FA3 (x[3], y[3], cintermediate[2], sum[3], cintermediate[3]);
   one_bit_full_adder FA4 (x[4], y[4], cintermediate[3], sum[4], cintermediate[4]);
   one_bit_full_adder FA5 (x[5], y[5], cintermediate[4], sum[5], cintermediate[5]);
   one_bit_full_adder FA6 (x[6], y[6], cintermediate[5], sum[6], cout);
  
endmodule