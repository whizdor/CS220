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
module five_bit_adder_subtractor(x,y,num,sum_x,sum_y);
    input [3:0] x,y,num;
    output [4:0] sum_x,sum_y;
    wire [4:0] sum_x,sum_y;

    wire op;
    wire[1:0] addx,addy;
    wire[4:0] coutx, couty;

    assign op = num[1];


    assign addx = {num[3]&num[0], num[2]&num[0]};
    assign addy = {num[3]&(~num[0]), num[2]&(~num[0])};

    full_operator FA0(x[0],addx[0],op, op,sum_x[0], coutx[0]);
    full_operator FA1(x[1],addx[1],op,coutx[0],sum_x[1], coutx[1]);
    full_operator FA2(x[2],1'b0,op,coutx[1],sum_x[2], coutx[2]);
    full_operator FA3(x[3],1'b0,op,coutx[2],sum_x[3], coutx[3]);
    full_operator FA4(1'b0,1'b0,op,coutx[3],sum_x[4], coutx[4]);

    full_operator FA5(y[0],addy[0],op, op,sum_y[0], couty[0]);
    full_operator FA6(y[1],addy[1],op, couty[0],sum_y[1], couty[1]);
    full_operator FA7(y[2],1'b0,op,couty[1],sum_y[2], couty[2]);
    full_operator FA8(y[3],1'b0,op,couty[2],sum_y[3], couty[3]);
    full_operator FA9(1'b0,1'b0,op,couty[3],sum_y[4], couty[4]);
	 
endmodule