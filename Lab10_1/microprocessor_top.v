`include "microprocessor.v"

module microprocessor_top();
	reg clk = 0;
	always begin
		#50;
		clk = ~clk;
	end
	microprocessor uut(
		.clk(clk)
	);
endmodule