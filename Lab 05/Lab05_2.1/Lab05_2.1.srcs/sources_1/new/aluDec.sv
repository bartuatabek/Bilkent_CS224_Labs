module aludec (input    logic[5:0] funct,
               input    logic[1:0] aluop,
               output   logic[2:0] alucontrol,
               output logic jalrOp
		       );
    always_comb
    case(aluop)
      2'b00: 
      begin
          jalrOp = 1'b0;
          alucontrol  = 3'b010;  // add  (for lw/sw/addi)
      end
      2'b01: begin 
          alucontrol  = 3'b110; 
          jalrOp = 1'b0; 
      end// sub   (for beq)
      
      2'b11: 
      begin 
          alucontrol  = 3'b011; 
          jalrOp = 1'b0; 
      end// sgt - (for bgt)

      default: case(funct)          // R-TYPE instructions
          6'b100000: 
		begin
		    jalrOp = 1'b0;
			alucontrol  = 3'b010; // ADD
		end
          6'b100010: 
		begin
		    jalrOp = 1'b0;
			alucontrol  = 3'b110; // SUB
		end
          6'b100100: 
		begin
		    jalrOp = 1'b0;
			alucontrol  = 3'b000; // AND
		end
          6'b100101: 
		begin
		    jalrOp = 1'b0;
			alucontrol  = 3'b001; // OR
		end
          6'b101010: 
		begin
		    jalrOp = 1'b0;
			alucontrol  = 3'b111; // SLT
		end
          6'b110001: 
		begin // JALR - Funct: 0x31
		    jalrOp = 1'b1;
			alucontrol = 3'bxxx;
		end
          default:   begin alucontrol  = 3'bxxx; jalrOp = 1'b0; end // ???
        endcase
    endcase
endmodule
