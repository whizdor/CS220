`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:59 03/06/2024 
// Design Name: 
// Module Name:    five_bit_adder_subtractor 
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
module five_bit(x,y,num,sum_x,sum_y);
    input [3:0] x,y,num;
    output [4:0] sum_x,sum_y;
    wire [4:0] sum_x,sum_y;

    wire op;
    wire[1:0] addx,addy;

    assign op = num[1];

    assign addx = {num[3]&num[0], num[2]&num[0]};
    assign addy = {num[3]&(~num[0]), num[2]&(~num[0])};

    five_bit_operator F0(x,addx,op,sum_x);
    five_bit_operator F1(y,addy,op,sum_y);
endmodule