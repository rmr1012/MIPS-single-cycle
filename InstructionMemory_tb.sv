
module tb_IM;

logic [5:0] PC;
logic [31:0] instruction;
logic clk;

InstructionMemory uut (
.PC(PC),
.instruction(instruction),
.clk(clk)
); 

initial begin
clk=1;
#9
PC=0;
#10
PC=4;
#10
PC=8;
#10
PC=12;
#10
PC=16;
#10
PC=20;

end

always begin 
#5
clk=!clk;
end
endmodule