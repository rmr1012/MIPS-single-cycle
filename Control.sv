module ALU_Control(
	input [5:0] InsOp,
	input [1:0] ALUOp,
	output [2:0]outOp);

	case({ALUOp,InsOP})
		8'b00xxxxxx: outOp=3'b010;
		8'b01xxxxxx: outOp=3'b110;
		8'b1xxx0000: outOp=3'b010;
		8'b1xxx0010: outOp=3'b110;
		8'b1xxx0100: outOp=3'b000;
		8'b1xxx0101: outOp=3'b001;
		8'b1xxx1010: outOp=3'b111;
endmodule


module Control(
	input[5:0]	ins,
	output	RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemToReg,PCSrc,Branch,
	output [2:0] ALUOp
);

always_comb begin

	case(ins)
		6'b000000: begin RegDst=1; ALUSrc=0; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; ALUOp=2'b10;end
		6'b100011: begin RegDst=0; ALUSrc=1; MemToReg=1; RegWrite=1; MemRead=1; MemWrite=0; Branch=0; ALUOp=2'b00;end
		6'b101011: begin RegDst=x; ALUSrc=1; MemToReg=x; RegWrite=0; MemRead=0; MemWrite=1; Branch=0; ALUOp=2'b00;end
		6'b000100: begin RegDst=x; ALUSrc=0; MemToReg=x; RegWrite=0; MemRead=0; MemWrite=0; Branch=1; ALUOp=2'b01;end

	endcase
end

endmodule
