module rotary_shaft(clk, ROT_A, ROT_B, rotation_event, rotation_direction);
    //Inputs
    input clk, ROT_A, ROT_B;

    //Outputs
    output rotation_event, rotation_direction;
    reg rotation_event, rotation_direction;

    always @(posedge clk) begin
        if(ROT_A == 1 & ROT_B == 1) begin
            rotation_event <= 1;
        end
        else if(ROT_A == 0 & ROT_B == 0) begin
            rotation_event <= 0;
        end
        else if(ROT_A == 0 & ROT_B == 1) begin
            rotation_direction <= 1;
        end
        else if(ROT_A == 1 & ROT_B == 0) begin
            rotation_direction <= 0;
        end
    end
endmodule
