`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:51 01/24/2024 
// Design Name: 
// Module Name:    two_bit_adder 
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
module full_adder(a,b,cin,sum,cout
    );
input a,b,cin;
output sum,cout;
wire sum,cout;

assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule

module two_bit_adder(a,b, sum, cout
    );
input [1:0]a;
input [1:0]b;

output [1:0] sum;
output cout;
wire [1:0] sum;
wire cout;

wire c_intermediate;

full_adder FA0 (a[0], b[0], 1'b0, sum[0], c_intermediate);
full_adder FA1 (a[1], b[1], c_intermediate, sum[1], cout);


endmodule
