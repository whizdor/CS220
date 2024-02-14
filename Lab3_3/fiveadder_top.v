`include "fiveadder.v"
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:59 02/02/2024
// Design Name:   fiveadder
// Module Name:   /media/mahaarajan/HP USB20FD/CS220/Lab3_3/fiveadder/fiveadder_top.v
// Project Name:  fiveadder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fiveadder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fiveadder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg ROT_SWITCH;
	reg [3:0] t;

	// Outputs
	wire [5:0] sum;
	wire cout;

	// Instantiate the Unit Under Test (UUT)
	fiveadder uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.ROT_SWITCH(ROT_SWITCH), 
		.t(t), 
		.sum(sum), 
		.cout(cout)
	);

    reg [3:0] a1,a2,a3,a4,a5;

	initial begin
        t=0;
		PB1=1;
        PB2=0;
        PB3=0;
        PB4=0;
		ROT_SWITCH = 0;
	end

	always begin
        PB1=~PB1;
        #25;
        PB1=~PB1;
    end

    always begin
        #5;
        PB2=~PB2;
        #20;
        PB2=~PB2;
    end

    always begin
        #10;
        PB3=~PB3;
        #15;
        PB3=~PB3;
    end

    always begin
        #15;
        PB4=~PB4;
        #10;
        PB4=~PB4;
    end

    always begin
        #20;
        ROT_SWITCH=~ROT_SWITCH;
        #5;
        ROT_SWITCH=~ROT_SWITCH;
    end

	always begin
        for(integer i=1;i<16;i++) begin
            #5;
            t = i;
            for(integer j=1;j<16;j++) begin
                #5;
                t = j;
                for(integer k=1;k<16;k++) begin
                    #5;
                    t = k;
                end
            end
        end
    end

    always begin
        #26;
        $display("%b %b %b %b %b %d %d %d",PB1,PB2,PB3,PB4,ROT_SWITCH,t,sum,cout);
    end

    initial begin
        #5000;
        $finish;
    end

endmodule