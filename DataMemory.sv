

module DataMemory(input [5:0] address,
	input [31:0] data_in,
	input clk,
	input memRead,memWrite, // 1 is read 0 is write
	output logic [31:0] data_out);

logic [8-1:0] mem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter MEM_INIT = "C:\\Users\\juren\\Desktop\\MIPS-single-cycle-master\\mips1_data.txt";

initial begin
	$readmemh(MEM_INIT, mem);
end

always_ff @ (negedge clk)  begin // suspecious

	if(memWrite) begin
		{mem[address],mem[address+1],mem[address+2],mem[address+3]} = data_in;
	end
end
always @ (address,memRead) begin // suspecious
	if (memRead) begin
		data_out = {mem[address],mem[address+1],mem[address+2],mem[address+3]};
	end
end

endmodule
