`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:34 03/06/2024 
// Design Name: 
// Module Name:    full_operator 
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
module full_operator(a,b,operation,cin,sum,cout);

	input a;
	input b;
	input operation;
	input cin;

	output sum;
	wire sum;
	output cout;
	wire cout;

	assign sum = a^(b^operation)^cin;
	assign cout = (a&(b^operation)) | ((b^operation)&cin) | (cin&a);

endmodule
