`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:18:47 01/24/2024
// Design Name:   two_bit_adder
// Module Name:   /media/aditikh22/HP USB20FD/CS220/Lab2_1/two_bit_adder/two_bit_adder_top.v
// Project Name:  two_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: two_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module two_bit_adder_top;

	// Inputs
	reg [1:0] a;
	reg [1:0] b;
	reg cin;

	// Outputs
	wire [1:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	two_bit_adder uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

module two_bit_adder_top;

    // Inputs
    reg [1:0] A;
    reg [1:0] B;

    // Outputs
    wire [1:0] Sum;
    wire Carry;

    // Instantiation of the 8-bit adder module
	 two_bit_adder ADDER (A, B, Sum, Carry);

    // Displaying the output
    always @ (A or B or Sum or Carry) begin
        $display("<%d>: Input_A = %b, Input_B = %b, Sum = %b, Carry = %b",$time,A,B,Sum,Carry);
    end

    // Initialising the inputs
    initial begin
        A = 1; B = 1;
        #1 
        $display("\n");
        A = 3; B = 3;
        #1 
        $display("\n");
        A = 2; B = 1;
        #1 
        $display("\n");
              
    end

endmodule