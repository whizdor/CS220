`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:03 02/14/2024 
// Design Name: 
// Module Name:    rotary_shaft_encoder 
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
module rotary_shaft_encoder (clk, rotation_event, rotation_direction, led);
    //Inputs
    input clk, rotation_event, rotation_direction;

    //Outputs
    output [7:0] led;
    reg [7:0] led = 1;

    //Local Variables
    reg prev_rotation_event = 1;

    always @(posedge clk) begin
        prev_rotation_event <= rotation_event;
        if(prev_rotation_event == 0 & rotation_event == 1) begin
            if(rotation_direction == 0) begin
                led[0] <= led[1];
                led[1] <= led[2];
                led[2] <= led[3];
                led[3] <= led[4];
                led[4] <= led[5];
                led[5] <= led[6];
                led[6] <= led[7];
                led[7] <= led[0]; 
            end
            if(rotation_direction == 1) begin
                led[1] <= led[0];
                led[2] <= led[1];
                led[3] <= led[2];
                led[4] <= led[3];
                led[5] <= led[4];
                led[6] <= led[5];
                led[7] <= led[6];
                led[0] <= led[7]; 
            end
        end
    end
endmodule
