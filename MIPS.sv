
module MIPS(input clk);

  logic [5:0] PC;
  logic [4:0] wn;

  wire [31:0] b,instruciton,data_out,alu_result,addr_alu_result;
  wire [31:0] data,rd1,rd2,wd;
  wire	RegDst,RegWrite,ALUSrc,MemRead,MemToReg,PCSrc;
  wire [2:0] alu_op;// translated alu op
  logic [5:0] PC_4;

  DataMemory dm (
  .address(alu_result),
  .data_in(rd2),
  .data_out(data_out),
  .memRead(MemRead)
  );

  InstructionMemory im (
  .PC(PC),
  .instruction(instruction),
  .clk()
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

  module control(
  	.ins(instruction[31:26]),
  	.RegDst(RegDst),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
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
    .c(alu_result)
  );


  assign b= ALUSrc ? rd2 : {16{instruciton[15:0]},instruciton[15:0]}; // choose either sign extention or reg RegisterFile
  assign wd= MemToReg ? data_out : alu_result; // mux right of datamem
  assign wn= RegDst ? instruciton[15:11] : instruction[20:16];


  always @ (posedge clk) begin
    PC_4=PC+4;
  end

endmodule
