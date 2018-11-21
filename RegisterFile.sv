
module RegisterFile (
	input logic rst,
	input logic [4:0] rs, rt, wn,
	input logic [31:0] wd,
	input logic RegWrite,
	output logic [31:0] rd1, rd2
);

logic [32-1:0] file [0:32-1]; //** is the power operator// 8 bit wide, 2^6=64 byte long
integer i;
always @(wd ,rst) begin
	if (rst) begin
		for (i=0;i<=31;i=i+1)
	   		file[i] = 0;
	end
	else if (RegWrite) begin
		file[wn]=wd;
	end
end
always @(rs,rt,wn) begin
	if({rs,rt} !== 10'bX) begin
		rd1=file[rs];
		rd2=file[rt];
	end
end

//

// initial begin
//

// end

endmodule
