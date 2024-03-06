module fsmROM_top(clk, y, ROT_A, ROT_B, next_state)
    //Inputs
    input clk; 
    //Switch for input
    input [1:0] y; 
    //Rotary Shaft to detect new input.
    input ROT_A, ROT_B;
    //Outputs
    output [3:0] next_state;
    wire [3:0] next_state;

    //Internal Wires
    reg [3:0] current_state = 0;
    reg [31:0] clock_cycles = 0;
    reg [1:0] x;

    wire rotation_event;
    reg prev_rot_event = 1;

    fsmROM fsm(clk, x, current_state, next_state);
    rotary_shaft shaft(clk, ROT_A, ROT_B, rotation_event);

    always @(posedge clk) begin
        clock_cycles <= clock_cycles + 1;
        if(prev_rot_event == 0 && rotation_event == 1) begin
            current_state <= next_state;
            x <= y;
            clock_cycles <= 0;
        end
        else if(clock_cycles == 1000000) begin
            current_state <= next_state;
            clock_cycles <= 0;
        end
        prev_rot_event <= rotation_event;
    end
endmodule