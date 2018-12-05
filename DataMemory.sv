

module DataMemory(input [5:0] address,
	input [31:0] data_in,
	input clk,
	input memRead,memWrite, // 1 is read 0 is write
	output logic [31:0] data_out);

logic [8-1:0] mem [0:2**6-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long

parameter MEM_INIT = "//Mac/Home/Documents/MIPS-single-cycle/mips1_data.txt";

initial begin
	$readmemh(MEM_INIT, mem);
end

always_ff @ (posedge clk)  begin // suspecious

	if(memWrite) begin
		{mem[address],mem[address+1],mem[address+2],mem[address+3]} = data_in;
	end
end

assign data_out = memRead ? {mem[address],mem[address+1],mem[address+2],mem[address+3]}:0;


endmodule
