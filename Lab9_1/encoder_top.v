module encoder_top();
    // Register
    reg [16:0]a [8:0];
    // Output
    output[7:0] sum;
    wire[7:0] sum;

    initial begin
        reg a[0] = 16'b0000000000000000;
        reg a[1] = 16'b1000100000000000;
        reg a[2] = 16'b0000000100000000;
        reg a[3] = 16'b1000000000000000;
        reg a[4] = 16'b0000000000000001;
        reg a[5] = 16'b0000100000000000;
        reg a[6] = 16'b1000000100010000;
        reg a[7] = 16'b0000000100000000;
    end

    initial begin
        for(integer i=0; i<8; i=i+1) begin
            if(a[i] == 16'b0000000000000001) begin
                sum = sum + 5'b00000;
            end
            else if(a[i] == 16'b0000000000000010) begin
                sum = sum + 5'b00001;
            end
            else if(a[i] == 16'b0000000000000100) begin
                sum = sum + 5'b00010;
            end
            else if(a[i] == 16'b0000000000001000) begin
                sum = sum + 5'b00011;
            end
            else if(a[i] == 16'b0000000000010000) begin
                sum = sum + 5'b00100;
            end
            else if(a[i] == 16'b0000000000100000) begin
                sum = sum + 5'b00101;
            end
            else if(a[i] == 16'b0000000001000000) begin
                sum = sum + 5'b00110;
            end
            else if(a[i] == 16'b0000000010000000) begin
                sum = sum + 5'b00111;
            end
            else if(a[i] == 16'b0000000100000000) begin
                sum = sum + 5'b01000;
            end
            else if(a[i] == 16'b0000001000000000) begin
                sum = sum + 5'b01001;
            end
            else if(a[i] == 16'b0000010000000000) begin
                sum = sum + 5'b01010;
            end
            else if(a[i] == 16'b0000100000000000) begin
                sum = sum + 5'b01011;
            end
            else if(a[i] == 16'b0001000000000000) begin
                sum = sum + 5'b01100;
            end
            else if(a[i] == 16'b0010000000000000) begin
                sum = sum + 5'b01101;
            end
            else if(a[i] == 16'b0100000000000000) begin
                sum = sum + 5'b01110;
            end
            else if(a[i] == 16'b1000000000000000) begin
                sum = sum + 5'b01111;
            end
            else begin
                sum = sum + 5'b11111;
            end
        end
    end
    
    // Instantiate the encoder module
    

endmodule