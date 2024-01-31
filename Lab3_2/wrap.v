`define SHIFT_TIME 50000000

module blink(clk, led);

    // Inputs
    input clk;
    // Outputs
    output led;
    reg [8:0] led = 0;
    led[0] = 1;

    // Temporary counter
    reg [14:0] counter = 0;

    // Logic for toggling the output
    always @(posedge clk) begin
        if (temp == SHIFT_TIME) begin
            led[1] <= led[0];
            led[2] <= led[1];
            led[3] <= led[2];
            led[4] <= led[3];
            led[5] <= led[4];
            led[6] <= led[5];
            led[7] <= led[6];
            led[0] <= led[7];
        end
        else begin
            temp <= temp + 1;
        end
    end

endmodule