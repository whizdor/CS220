`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:40 01/31/2024 
// Design Name: 
// Module Name:    fulladder 
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
module fulladder(a,b,c,sum,carry
    );
	 input a,b,c;
	 output sum,carry;
	 wire sum,carry;
	 
	 assign sum = (a^b^c);
	 assign carry = (a&b)|(b&c)|(c&a);

endmodule
