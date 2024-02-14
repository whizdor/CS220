`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:38 02/14/2024 
// Design Name: 
// Module Name:    lcd_driver_top 
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
module LCD_Driver_top(clk, LCD_E, LCD_W, LCD_RS, data);
    //Input
    input clk;

    //Output
    output LCD_E,LCD_RS,LCD_W;  
    output [3:0] data;

    wire LCD_E,LCD_RS,LCD_W;  
    wire [3:0] data;

    LCD_Driver LCD(clk, "WELCOME TO CSE, ","IIT KANPUR      ",LCD_E, LCD_W, LCD_RS, data);
endmodule
