module datapath (input  logic clk, reset, memtoreg, pcsrc, alusrc, regdst,
                 input  logic regwrite, jump, jalrOp,
		         input  logic[2:0]  alucontrol, 
                 output logic flag, 
		         output logic[31:0] pc,
	             input  logic[31:0] instr,
                 output logic[31:0] aluout, writedata, 
	             input  logic[31:0] readdata);

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  logic [31:0] signimm, signimmsh, srca, srcb, result, jumpTo;
  //logic zero, isGt;
  logic [31:0] resultToWriteRF;
  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(pc, 32'b100, pcplus4);
  sl2         immsh(signimm, signimmsh);
  adder       pcadd2(pcplus4, signimmsh, pcbranch);
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc,
                      pcnextbr);
  //mux2 #(32) jumpMux(result, srca, jalrOp, jumpTo);
  mux2 #(32) jalrOrJump({pcplus4[31:28], instr[25:0], 2'b00}, srca, jalrOp, jumpTo);
  mux2 #(32)  pcmux(pcnextbr, jumpTo, jump, pcnext);
                    
   logic [4:0] a3;
   // register file logic
   regfile     rf (clk, regwrite, instr[25:21], instr[20:16], a3,
                   resultToWriteRF, srca, writedata);

   mux2 #(5)    wrmux (instr[20:16], instr[15:11], regdst, writereg);
   mux2 #(32)   jalrWrite(writereg, {5'b11111}, jalrOp, a3);
   //logic [4:0] jalr = 5'b1;
   //mux2 #(5) jalrmux(writereg, jalr, jalrOp, a3);
   mux2 #(32)  resmux (aluout, readdata, memtoreg, result);
   mux2 #(32) resultToRFMux(result, pcplus4, jalrOp, resultToWriteRF);
   //mux2 #(32) jalrmux2(result, pcbranch, jalrOp);
   signext         se (instr[15:0], signimm);

   // ALU logic
   mux2 #(32)  srcbmux (writedata, signimm, alusrc, srcb);
   alu         alu (srca, srcb, alucontrol,aluout, flag);
   //assign validBranch = branchType ? (aluout[0]):zero;
   
   

endmodule