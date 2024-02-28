module full_operator(a,b,operation,cin,sum,cout);

	input a;
	input b;
	input operation;
	input cin;

	output sum;
	wire sum;
	output cout;
	wire cout;

	assign sum = a^(b^operation)^cin;
	assign cout = (a&b) | ((b^operation)&cin) | (cin&a);

endmodule