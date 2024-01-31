`import "fulladder.v"

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
    input [5:0] a;
    input [5:0] b;
    input c;

    //Outputs
    output [5:0] sum;
    wire [5:0] sum;
    output carry;
    wire carry;

    //Intermediate Carry 
    wire [4:0] carry_intermediate;

    fulladder FA0(a[0], b[0], c, sum[0], carry_intermediate[0]);
    fulladder FA1(a[1], b[1], carry_intermediate[0], sum[1], carry_intermediate[1]);
    fulladder FA2(a[2], b[2], carry_intermediate[1], sum[2], carry_intermediate[2]);
    fulladder FA3(a[3], b[3], carry_intermediate[2], sum[3], carry_intermediate[3]);
    fulladder FA4(a[4], b[4], carry_intermediate[3], sum[4], carry_intermediate[4]);
    fulladder FA5(a[5], b[5], carry_intermediate[5], sum[5], carry);
endmodule
