module encoder(a, encoded_value);
    // Inputs
    input a;

    //Output
    output [4:0] encoded_value;
    wire [4:0] encoded_value;

	//Check for two set bits
	initial begin
		if(a == 16'b0000000000000001) begin
			encoded_value = 5'b00000;
		end
		else if(a == 16'b0000000000000010) begin
			encoded_value = 5'b00001;
		end
		else if(a == 16'b0000000000000100) begin
			encoded_value = 5'b00010;
		end
		else if(a == 16'b0000000000001000) begin
			encoded_value = 5'b00011;
		end
		else if(a == 16'b0000000000010000) begin
			encoded_value = 5'b00100;
		end
		else if(a == 16'b0000000000100000) begin
			encoded_value = 5'b00101;
		end
		else if(a == 16'b0000000001000000) begin
			encoded_value = 5'b00110;
		end
		else if(a == 16'b0000000010000000) begin
			encoded_value = 5'b00111;
		end
		else if(a == 16'b0000000100000000) begin
			encoded_value = 5'b01000;
		end
		else if(a == 16'b0000001000000000) begin
			encoded_value = 5'b01001;
		end
		else if(a == 16'b0000010000000000) begin
			encoded_value = 5'b01010;
		end
		else if(a == 16'b0000100000000000) begin
			encoded_value = 5'b01011;
		end
		else if(a == 16'b0001000000000000) begin
			encoded_value = 5'b01100;
		end
		else if(a == 16'b0010000000000000) begin
			encoded_value = 5'b01101;
		end
		else if(a == 16'b0100000000000000) begin
			encoded_value = 5'b01110;
		end
		else if(a == 16'b1000000000000000) begin
			encoded_value = 5'b01111;
		end
		else begin
			encoded_value = 5'b11111;
		end
	end
endmodule