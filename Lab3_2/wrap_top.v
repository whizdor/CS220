`include "wrap.v"
`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:56 01/31/2024 
// Design Name: 
// Module Name:    wrap_top 
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
module wrap_top;
    // Inputs
    reg clk;
 
    // Outputs
    wire [7:0] led;
 
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

    always @(led[0], led[1], led[2], led[3], led[4], led[5], led[6], led[7]) begin
        $display("time:%d, Led(s): %b",$time,led,);
    end

    initial begin
    // Initialize Inputs
        #300;
        $finish;
    end
      
endmodule