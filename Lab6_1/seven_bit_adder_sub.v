`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:27 02/28/2024 
// Design Name: 
// Module Name:    seven_bit_adder_sub 
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

module seven_bit_adder_sub(clk, ROT_A, ROT_B, inp, answer, overflow);
    input clk, ROT_A, ROT_B;
    input [3:0] inp;
    output [6:0] answer;
    output overflow;
    wire [6:0] answer;
    wire overflow;

    reg [6:0] a,b;
    reg operation;

    wire rotation_event;
    reg prev_rotation_event = 1;
    reg [2:0] count = 3'b000;

    //intitalise rotation event
    rotary_shaft shaft(clk, ROT_A, ROT_B, rotation_event);
    
    always @(posedge clk) begin
        if(prev_rotation_event == 0 & rotation_event == 1) begin
            if(count == 3'b000) begin
                a[3:0] <= inp[3:0];
                count <= count + 1;
            end
            else if (count == 3'b001) begin
                a[6:4] <= inp[2:0];
                count <= count + 1;
            end
            else if (count == 3'b010) begin
                b[3:0] <= inp[3:0];
                count <= count + 1;
            end
            else if (count == 3'b011) begin
                b[6:4] <= inp[2:0];
                count <= count + 1;
            end
            else if (count == 3'b100) begin
                operation <= inp[0];
                count <= 3'b000;
            end
        end
        prev_rotation_event <= rotation_event;
    end

    wire [6:0] c_intermediate;
    full_operator FO1(a[0],b[0],operation,operation,answer[0],c_intermediate[0]);
    full_operator FO2(a[1],b[1],operation,c_intermediate[0],answer[1],c_intermediate[1]);
    full_operator FO3(a[2],b[2],operation,c_intermediate[1],answer[2],c_intermediate[2]);
    full_operator FO4(a[3],b[3],operation,c_intermediate[2],answer[3],c_intermediate[3]);
    full_operator FO5(a[4],b[4],operation,c_intermediate[3],answer[4],c_intermediate[4]);
    full_operator FO6(a[5],b[5],operation,c_intermediate[4],answer[5],c_intermediate[5]);
    full_operator FO7(a[6],b[6],operation,c_intermediate[5],answer[6],c_intermediate[6]);

    assign overflow = (c_intermediate[6] ^ c_intermediate[5]);

endmodule
