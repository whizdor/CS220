module rotary_shaft(clk, ROT_A, ROT_B, rotation_event);
    //Inputs
    input clk, ROT_A, ROT_B;

    //Outputs
    output rotation_event;
    reg rotation_event;

    always @(posedge clk) begin
        if(ROT_A == 1 && ROT_B == 1) begin
            rotation_event <= 1;
        end
        if(ROT_A == 0 && ROT_B == 0) begin
            rotation_event <= 0;
        end
    end
endmodule