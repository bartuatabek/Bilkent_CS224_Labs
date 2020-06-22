module mips (input  logic        clk, reset,
             output logic[31:0]  pc,
             input  logic[31:0]  instr,
             output logic        memwrite, pcsrc, jalrOp,
             output logic[31:0]  aluout, writedata,
             input  logic[31:0]  readdata);

  logic        memtoreg, flag, alusrc, regdst, regwrite, jump, branchType;
  logic [2:0]  alucontrol;

  controller c (instr[31:26], instr[5:0], flag, memtoreg, memwrite, pcsrc,
                        alusrc, regdst, regwrite, jump, jalrOp, alucontrol);

  datapath dp (clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, jalrOp,
                          alucontrol, flag, pc, instr, aluout, writedata, readdata);

endmodule