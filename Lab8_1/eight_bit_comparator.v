`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:09:30 04/03/2024 
// Design Name: 
// Module Name:    eight_bit_comparator 
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
module eight_bit_comparator (x, y, less);

// Inputs
input [15:0] x;
//reg [15:0] x;
input [15:0] y;
//reg [15:0] y;

// Outputs
output less;
wire less;

// Intermediate wires
wire equal;
wire greater;
wire [14:0] lintermediate;
wire [14:0] eintermediate;
wire [14:0] gintermediate;

// Instantiating the 8 one-bit comparator modules
onebitcomp C15 (x[15], y[15], 1'b0, 1'b1, 1'b0, lintermediate[14], eintermediate[14], gintermediate[14]);
onebitcomp C14 (x[14], y[14], lintermediate[14], eintermediate[14], gintermediate[14], lintermediate[13], eintermediate[13], gintermediate[13]);
onebitcomp C13 (x[13], y[13], lintermediate[13], eintermediate[13], gintermediate[13], lintermediate[12], eintermediate[12], gintermediate[12]);
onebitcomp C12 (x[12], y[12], lintermediate[12], eintermediate[12], gintermediate[12], lintermediate[11], eintermediate[11], gintermediate[11]);
onebitcomp C11 (x[11], y[11], lintermediate[11], eintermediate[11], gintermediate[11], lintermediate[10], eintermediate[10], gintermediate[10]);
onebitcomp C10 (x[10], y[10], lintermediate[10], eintermediate[10], gintermediate[10], lintermediate[9], eintermediate[9], gintermediate[9]);
onebitcomp C9 (x[9], y[9], lintermediate[9], eintermediate[9], gintermediate[9], lintermediate[8], eintermediate[8], gintermediate[8]);
onebitcomp C8 (x[8], y[8], lintermediate[8], eintermediate[8], gintermediate[8], lintermediate[7], eintermediate[7], gintermediate[7]);
onebitcomp C7 (x[7], y[7], lintermediate[7], eintermediate[7], gintermediate[7], lintermediate[6], eintermediate[6], gintermediate[6]);
onebitcomp C6 (x[6], y[6], lintermediate[6], eintermediate[6], gintermediate[6], lintermediate[5], eintermediate[5], gintermediate[5]);
onebitcomp C5 (x[5], y[5], lintermediate[5], eintermediate[5], gintermediate[5], lintermediate[4], eintermediate[4], gintermediate[4]);
onebitcomp C4 (x[4], y[4], lintermediate[4], eintermediate[4], gintermediate[4], lintermediate[3], eintermediate[3], gintermediate[3]);
onebitcomp C3 (x[3], y[3], lintermediate[3], eintermediate[3], gintermediate[3], lintermediate[2], eintermediate[2], gintermediate[2]);
onebitcomp C2 (x[2], y[2], lintermediate[2], eintermediate[2], gintermediate[2], lintermediate[1], eintermediate[1], gintermediate[1]);
onebitcomp C1 (x[1], y[1], lintermediate[1], eintermediate[1], gintermediate[1], lintermediate[0], eintermediate[0], gintermediate[0]);
onebitcomp C0 (x[0], y[0], lintermediate[0], eintermediate[0], gintermediate[0], less, equal, greater);

endmodule
