
module MIPS_12(input clk, rst,
output y );
  assign y = ^data;

  logic [5:0] PC,PC_next; // the only state vars, rest are connections

  wire [5:0] PC_4,b_addr;
  wire [4:0] wn;
  wire [31:0] b,instruciton,data_out,alu_result,addr_alu_result;
  wire [31:0] data,rd1,rd2,wd;
  wire	RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,PCSrc,Branch,alu_zero;
  wire [2:0] alu_op;// translated alu op

  DataMemory dm (
    .address(alu_result),
    .data_in(rd2),
    .data_out(data_out),
    .memRead(MemRead),
    .memWrite(MemWrite),
  );

  InstructionMemory im (
    .PC(PC),
    .instruction(instruction),
  );

  RegisterFile reg (
    .rs(instruciton[25:21]),
    .rt(instruciton[20:16]), // break down instruciton
    .wn(wn),
    .wd(wd),
    .RegWrite(RegWrite),
    .rd1(rd1),
    .rd2(rd2)
  );

  module Control(
  	.ins(instruction[31:26]),
  	.RegDst(RegDst),
    .Branch(Branch),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemToReg(MemToReg),
    .PCSrc(PCSrc),
  	.ALUOp(ALUOp)
  );

  ALU_Control alu_ctr(
    .InsOp(instruciton[5:0]),
    .ALUOp(ALUOp),
    .outOp(alu_op)
    );
  ALU alu_m(
    .a(rd1),// connect Reg to ALU
    .b(b),
    .op(alu_op),
    .c(alu_result),
    .zero(alu_zero)
  );


  assign b = ALUSrc ? rd2 : {16{instruciton[15:0]},instruciton[15:0]}; // choose either sign extention or reg RegisterFile
  assign wd = MemToReg ? data_out : alu_result; // mux right of datamem
  assign wn = RegDst ? instruciton[15:11] : instruction[20:16];
  assign b_addr = PC_4+ ({16{instruciton[15:0]},instruciton[15:0]} << 2 ); // ALU top right
  assign PC_next = (Branch && alu_zero) ? b_addr : PC_4; // top right mux
  assign PC_4=PC+4;

  always @ (posedge clk) begin
    PC=PC_next;
  end

endmodule
