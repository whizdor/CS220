`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:59 03/06/2024 
// Design Name: 
// Module Name:    five_bit_operator
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
module five_bit_operator(x, add, op, sum);
    input [3:0] x;
    input [1:0] add;
    input op;

    output [4:0] sum;
    wire [4:0] sum;

    wire[4:0] cout;
    full_operator FA0(x[0],addx[0],op, op,sum[0], cout[0]);
    full_operator FA1(x[1],addx[1],op,cout[0],sum[1], cout[1]);
    full_operator FA2(x[2],1'b0,op,cout[1],sum[2], cout[2]);
    full_operator FA3(x[3],1'b0,op,cout[2],sum[3], cout[3]);
    full_operator FA4(1'b0,1'b0,op,cout[3],sum[4], cout[4]);	 
endmodule