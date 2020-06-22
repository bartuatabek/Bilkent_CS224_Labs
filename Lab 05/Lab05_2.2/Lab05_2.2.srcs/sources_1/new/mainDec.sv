module maindec (input logic[5:0] op, funct,
	            output logic memtoreg, memwrite, branch,
	            output logic alusrc, regdst, regwrite, jump,		
	            output logic[1:0] aluop );
   logic [8:0] controls;

   assign {regwrite, regdst, alusrc, branch, memwrite,
                memtoreg, aluop, jump} = controls;

  always_comb
    case(op)
      6'b100011: controls <= 9'b101001000; // LW
      6'b101011: controls <= 9'b0x101x000; // SW
      6'b000100: controls <= 9'b0x010x010; // BEQ
      6'b001000: controls <= 9'b101000000; // ADDI
      6'b000010: controls <= 9'b0xxx0xxx1; // J
      6'b101110: controls <= 9'b0x010x110; // BGT
      6'b000000: 
      case (funct)
        6'b110001: 
              begin // JALR - Funct: 0x31
                 controls <= 9'b110000101;
              end
        default: controls <= 9'b110000100;//R - Type 
      endcase
      default:   controls <= 9'bxxxxxxxxx; // illegal op
    endcase
endmodule

