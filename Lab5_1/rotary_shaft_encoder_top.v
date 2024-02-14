`include "rotary_shaft_encoder.v"
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