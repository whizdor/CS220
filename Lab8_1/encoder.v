`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:12 03/20/2024 
// Design Name: 
// Module Name:    encoder 
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
module encoder(clk, PB, output_stream); 

	//Inputs
    input clk;
	input PB;

	//Outputs
    output[7:0] output_stream;
	reg [7:0] output_stream=0;
	 
	//Internal signals
    reg [7:0] answer=0;
	reg flag=0; 
    reg [15:0] data [7:0];
    reg [2:0] counter=0;


	// Initial values
    initial begin
        data[7] = 16'b0000000000000000;
        data[6] = 16'b1000100000000000;
        data[2] = 16'b0000000100000000;
        data[3] = 16'b1000000000000000;
        data[4] = 16'b0000000000000001;
        data[1] = 16'b0000100000000000;
        data[5] = 16'b1000000100010000;
        data[0] = 16'b0000000010000000;
    end
	 
	always @(posedge PB) begin
		if(flag == 0) begin
			flag=1;
	 	end
	 	else if(flag == 1) begin
			flag=0;
	 	end
	end

    always @(posedge clk) begin
		if(flag == 0) begin
			if(counter < 4'b1000) begin
				
				if(data[counter] == 16'b0000000000000001) begin
				answer <= answer+8'b00000001;
				end
				
				else if(data[counter] == 16'b0000000000000010) begin
				answer <= answer+8'b00000010;
				end
				
				else if(data[counter] == 16'b0000000000000100) begin
				answer <= answer+8'b00000011;
				end
				
				else if(data[counter] == 16'b0000000000001000) begin
				answer <= answer+8'b00000100;
				end
				
				else if(data[counter] == 16'b0000000000010000) begin
				answer <= answer+8'b00000101;
				end
				
				else if(data[counter] == 16'b0000000000100000) begin
				answer <= answer+8'b00000110;
				end
				
				else if(data[counter] == 16'b0000000001000000) begin
				answer <= answer+8'b00000111;
				end
				
				else if(data[counter] == 16'b0000000010000000) begin
				answer <= answer+8'b00001000;
				end
				
				else if(data[counter] == 16'b0000000100000000) begin
				answer <= answer+8'b00001001;
				end
				
				else if(data[counter] == 16'b0000001000000000) begin
				answer <= answer+8'b00001010;
				end
				
				else if(data[counter] == 16'b0000010000000000) begin
				answer <= answer+8'b00001011;
				end
				
				else if(data[counter] == 16'b0000100000000000) begin
				answer <= answer+8'b00001100;
				end
				
				else if(data[counter] == 16'b0001000000000000) begin
				answer <= answer+8'b00001101;
				end
				
				else if(data[counter] == 16'b0010000000000000) begin
				answer <= answer+8'b00001110;
				end
				
				else if(data[counter] == 16'b0100000000000000) begin
				answer <= answer+8'b00001111;
				end
			
				else if(data[counter] == 16'b1000000000000000) begin
				answer <= answer+8'b00010000;
				end
			
				else begin
				answer <= answer+8'b11111111;
				end
			
				counter  <=  counter+1;
			end
			
			assign output_stream = 8'b00100110;
			answer  <=  8'b00100110;
		end
		  
		else begin 
			if(answer[0] ^ answer[1] ^ answer[2] ^ answer[3] ^ answer[4] ^ answer[5] ^ answer[6] ^ answer[7]) begin
				assign output_stream = 8'b00000001;
			end
			
			else begin
				assign output_stream = 8'b00000000;
			end
		end
		  
    end
endmodule