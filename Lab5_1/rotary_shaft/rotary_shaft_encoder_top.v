`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:38 02/14/2024 
// Design Name: 
// Module Name:    rotary_shaft_encoder_top 
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
module rotary_shaft_encoder_top (clk, ROT_A, ROT_B, led);
    //Inputs
    input clk, ROT_A, ROT_B;

    //Outputs
    output [7:0] led;
    wire [7:0] led;

    wire rotation_direction, rotation_event;

    rotary_shaft RS(clk, ROT_A, ROT_B, rotation_event, rotation_direction);
    rotary_shaft_encoder RSE(clk, rotation_event, rotation_direction, led);
endmodule

