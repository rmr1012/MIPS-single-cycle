
module control(
	input[31:0]	ins,
	output	RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemToReg,PCSrc,
	output [2:0] ALUOp
);

always_comb begin

case({ins[31:26],ins[5:0]})
xxx : 

endcase
end

endmodule