// External instruction memory used by MIPS single-cycle
// processor. It models instruction memory as a stored-program
// ROM, with address as input, and instruction as output


module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})		   	// word-aligned fetch
//		address		instruction
//		-------		-----------
		8'h00: instr = 32'h20020005;  	// addi $v0, $zero, 5
		8'h04: instr = 32'h2003000c;  	// addi $v1, $zero, 12
		8'h08: instr = 32'h2067fff7;  	// addi $a3, $v1, -9
		8'h0c: instr = 32'h00e22025;  	// or $a0, $a3, $v0
		8'h10: instr = 32'h00642824;    // and $a1, $v1, $a0
		8'h14: instr = 32'h00a42820;    // add $a1, $a1, $a0
		8'h18: instr = 32'hb8e5000b;    // bgt  $a3, $a1, end
		8'h1c: instr = 32'h0064202a;    // slt $a0, $v1, $a0
		8'h20: instr = 32'h10800001;    // beq $a0, $zero, 0x00000028
		8'h24: instr = 32'h20050000;    // addi $a1, $zero, 0
		8'h28: instr = 32'h00e2202a;    // slt $a0, $a3, $v0
		8'h2c: instr = 32'h00853820;    // add $a3, $a0, $a1
		8'h30: instr = 32'h00e23822;    // sub $a3, $a3, $v0
		8'h34: instr = 32'h20030048;    // addi $v1, $zero, 0x0048
		8'h38: instr = 32'h00600031;    // jalr $v1
		8'h3c: instr = 32'hac670044;    // sw $a3, 68($v1)
		8'h40: instr = 32'h8c020050;    // lw $v0, 80($zero)
		8'h44: instr = 32'h08000011;    // j 0x00000044
		8'h48: instr = 32'hb8e40001;    // bgt  $a0, $a3, end 
		8'h4c: instr = 32'h20020001;    // addi $v0, $zero, 1
		8'h50: instr = 32'hac020054;    // sw $v0, 84($zero)
		8'h54: instr = 32'h08000012;	// j 48, so it will loop here, terminate
	     default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule
