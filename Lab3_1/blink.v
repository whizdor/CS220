`define OFF_TIME 25000000
`define ON_TIME (OFF_TIME*2)

module blink(clk, led);

    // Inputs
    input clk;

    // Outputs
    output reg led = 1'b0;
    
    // Temporary counter
    reg [14:0] temp = 0;

    // Logic for toggling the output
    always @(posedge clk) begin
        if (temp == OFF_TIME) begin
            q <= 1'b0;
            temp <= temp + 1;
        end
        else if (temp == ON_TIME) begin
            q <= 1'b0;
            temp <= 1;
        end
        else begin
            temp <= temp + 1;
        end
    end

endmodule