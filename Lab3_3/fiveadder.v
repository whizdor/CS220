// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:08 01/31/2024 
// Design Name: 
// Module Name:    fiveadder 
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
module fulladder(a,b,c,sum,carry);
	input a,b,c;

    //Outputs
    output carry,sum;
    wire carry,sum;
	 
	assign sum = (a^b^c);
	assign carry = (a&b)|(b&c)|(c&a);
endmodule


module four_bit_adder(a,b,c,sum,carry);
    //Inputs
    input [3:0] a;
    input [3:0] b;
    input c;

    //Outputs
    output [3:0] sum;
    wire [3:0] sum;
    output carry;
    wire carry;

    //Intermediate Carry 
    wire [2:0] carry_intermediate;

    fulladder FA0(a[0], b[0], c, sum[0], carry_intermediate[0]);
    fulladder FA1(a[1], b[1], carry_intermediate[0], sum[1], carry_intermediate[1]);
    fulladder FA2(a[2], b[2], carry_intermediate[1], sum[2], carry_intermediate[2]);
    fulladder FA3(a[3], b[3], carry_intermediate[2], sum[3], carry);
endmodule

module five_bit_adder(a,b,c,sum,carry);
    //Inputs
    input [4:0] a;
    input [4:0] b;
    input c;

    //Outputs
    output [4:0] sum;
    wire [4:0] sum;
    output carry;
    wire carry;

    //Intermediate Carry 
    wire [3:0] carry_intermediate;

    fulladder FA0(a[0], b[0], c, sum[0], carry_intermediate[0]);
    fulladder FA1(a[1], b[1], carry_intermediate[0], sum[1], carry_intermediate[1]);
    fulladder FA2(a[2], b[2], carry_intermediate[1], sum[2], carry_intermediate[2]);
    fulladder FA3(a[3], b[3], carry_intermediate[2], sum[3], carry_intermediate[3]);
    fulladder FA4(a[4], b[4], carry_intermediate[3], sum[4], carry);
endmodule

module six_bit_adder(a,b,c,sum,carry);
    //Inputs
    input [4:0] a;
    input [3:0] b;
    input c;

    //Outputs
    output [5:0] sum;
    wire [5:0] sum;
    output carry;
    wire carry;

    //Intermediate Carry 
    wire [4:0] carry_intermediate;

    fulladder FA0(a[0], b[0], 1'b0, sum[0], carry_intermediate[0]);
    fulladder FA1(a[1], b[1], carry_intermediate[0], sum[1], carry_intermediate[1]);
    fulladder FA2(a[2], b[2], carry_intermediate[1], sum[2], carry_intermediate[2]);
    fulladder FA3(a[3], b[3], carry_intermediate[2], sum[3], carry_intermediate[3]);
    fulladder FA4(a[4], 1'b0, carry_intermediate[3], sum[4], carry_intermediate[4]);
    fulladder FA5(c, 1'b0, carry_intermediate[4], sum[5], carry);
endmodule

module fiveadder (PB1, PB2, PB3, PB4, ROT_SWITCH, t, sum, cout);

    // Inputs
    input PB1,PB2,PB3,PB4,ROT_SWITCH;
    reg [3:0] a,b,c,d,e;
	input [3:0] t;
	
	// Outputs
    output [5:0] sum;
    wire [5:0] sum;
    output cout;
    wire cout;
	
	always@ (posedge PB1) begin
		a[3:0] <= t[3:0];
	end
	
	always@ (posedge PB2) begin
		b[3:0] <= t[3:0];
	end
	
	always@ (posedge PB3) begin
		c[3:0] <= t[3:0];
	end
	
	always@ (posedge PB4) begin
		d[3:0] <= t[3:0];
	end
	
	always@ (posedge ROT_SWITCH) begin
		e[3:0] <= t[3:0];
	end

	
	wire [4:0] x,y;
	four_bit_adder A1(a,b,1'b0,x[3:0],x[4]);
	four_bit_adder A2(c,d,1'b0,y[3:0],y[4]);
	wire [4:0] z;
    wire f,s;
    wire [5:0] l;
	five_bit_adder A3(x,y,1'b0,z,f);
	six_bit_adder A4(z,e,f,l,s);
    assign sum = l;
    assign cout = s;
  
endmodule
