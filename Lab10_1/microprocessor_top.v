`include "microprocessor.v"

module microprocessor_top();
	reg clk = 0;
	wire [7:0] out_led;
	always begin
		#50;
		clk = ~clk;
	end
	microprocessor uut(
		.clk(clk), .data_out(out_led)
	);
	
	always @(posedge clk) begin
		$display("%d, ",$signed(out_led));
	end
endmodule