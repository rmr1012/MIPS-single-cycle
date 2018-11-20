module ALU_Control(
	input  [5:0] InsOp,
	input  [1:0] ALUOp,
	output logic [2:0]outOp);
always_comb begin
	if (ALUOp==2'b00) begin outOp=3'b010; end
	else if (ALUOp==2'b01) begin outOp=3'b110; end
	else if (ALUOp[1] && InsOp==5'b100000) begin outOp=3'b010; end
	else if (ALUOp[1] && InsOp==5'b100010) begin outOp=3'b110; end
	else if (ALUOp[1] && InsOp==5'b100100) begin outOp=3'b000; end
	else if (ALUOp[1] && InsOp==5'b100101) begin outOp=3'b001; end
	else if (ALUOp[1] && InsOp==5'b101010) begin outOp=3'b111; end
end
endmodule


module Control(
	input[5:0]	ins,
	output	logic RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemToReg,PCSrc,Branch,
	output logic [2:0] ALUOp
);
always_comb begin

	case(ins)
		6'b001000: begin RegDst=0; ALUSrc=1; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;end // addi
		6'b000000: begin RegDst=1; ALUSrc=0; MemToReg=0; RegWrite=1; MemRead=0; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b10;end // Rtype
		6'b100011: begin RegDst=0; ALUSrc=1; MemToReg=1; RegWrite=1; MemRead=1; MemWrite=0; Branch=0; PCSrc=0; ALUOp=2'b00;end // lw
		6'b101011: begin 					 ALUSrc=1; 						 RegWrite=0; MemRead=0; MemWrite=1; Branch=0; PCSrc=0; ALUOp=2'b00;end //sw
		6'b000100: begin 					 ALUSrc=0; 						 RegWrite=0; MemRead=0; MemWrite=0; Branch=1; PCSrc=0; ALUOp=2'b01;end //beq
		6'b000010: begin 																 RegWrite=0; MemRead=0; MemWrite=0; Branch=0; PCSrc=1; ALUOp=2'b01;end //jump

	endcase
end

endmodule
