`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:05:12 04/03/2024 
// Design Name: 
// Module Name:    onebitcomp 
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
module onebitcomp(a,b,lin,ein,gin,less,equal,greater);
input a,b,lin,ein,gin;
output less,equal,greater;
wire less,equal,greater;
assign less = lin|ein&~a&b;
assign equal = ein&~(a^b);
assign greater = gin|ein&a&~b;

endmodule
