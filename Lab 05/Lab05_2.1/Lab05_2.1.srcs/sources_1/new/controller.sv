module controller(input  logic[5:0] op, funct,
                  input  logic     flag,
                  output logic     memtoreg, memwrite,
                  output logic     pcsrc, alusrc,
                  output logic     regdst, regwrite,
                  output logic     jump, jalrOp,
                  output logic[2:0] alucontrol);

   logic [1:0] aluop;
   logic       branch;
   maindec md (op, funct, memtoreg, memwrite, branch, alusrc, regdst, regwrite, 
		 jump, aluop);

   aludec  ad (funct, aluop, alucontrol, jalrOp);

   assign pcsrc = branch & flag;

endmodule
