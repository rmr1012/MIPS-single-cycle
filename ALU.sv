module ALU (a,b,op,c,zero);
	input [31:0] a;
	input [31:0] b;
	input [2:0] op;
	output logic [31:0] c;
	output logic zero;



always_comb begin

	case(op)
	0: c = a;
	1: c = b;
	2: c = a + b;
	3: c = a + (~b + 1'b1);
	4: c = {1'bx,(a&b)};  //a&b
	5: c = {1'bx,(a|b)};  //a|b
	6: c = {1'bx,(a^b)};  //a^b
	7: c = c;
	endcase
	zero = (c == 0) ? 1 : 0; // if output is 0, set zero to 1
end
endmodule
