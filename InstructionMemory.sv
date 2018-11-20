
module InstructionMemory(input [5:0] PC,
	output logic [31:0] instruction);

logic [8-1:0] mem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter MEM_INIT = "//Mac/Home/Documents/MIPS-single-cycle/mips1.txt";

initial begin
	$readmemh(MEM_INIT, mem);
end

always_comb  begin
	instruction = {mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]};
end


endmodule
