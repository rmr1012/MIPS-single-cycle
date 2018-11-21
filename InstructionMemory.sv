
module InstructionMemory(input [5:0] PC,
	input rst,
	output logic [31:0] instruction,
	output logic halt);

logic [8-1:0] mem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter MEM_INIT = "C:\\Users\\juren\\Desktop\\MIPS-single-cycle-master\\mips2.txt";

initial begin
	$readmemh(MEM_INIT, mem);
end


	

always_comb  begin
	if(rst) begin halt=0; end
	instruction = {mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]};
	halt = ({mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]}==0 || {mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]}=== 32'bX) ? 1:0;
end


endmodule
