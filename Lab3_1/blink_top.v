`include "blink.v"
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:56 01/31/2024 
// Design Name: 
// Module Name:    blink_top 
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
module blink_top;
    // Inputs
    reg clk;
 
    // Outputs
    wire led;
 
    // Instantiate the Unit Under Test (UUT)
    blink uut (clk, led);
    
    initial begin
        forever begin
            clk=0;
            #2
            clk=1;
            #2
            clk=0;
        end
    end

    always @(led) begin
        $display("time:%d, Led: %b",$time,led);
    end

    initial begin
    // Initialize Inputs
        #3000;
        $finish;
    end
      
endmodule