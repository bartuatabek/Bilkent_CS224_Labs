// Top level system including MIPS and memories

module top  (input   logic 	 clk, reset,            
	     output  logic[31:0] writedata, dataadr, pc, instr,            
	     output  logic       memwrite);  

   logic [31:0] readdata;    

   // instantiate processor and memories  
   mips mips (clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);  
   imem imem (pc[7:2], instr);  
   dmem dmem (clk, memwrite, dataadr, writedata, readdata);

endmodule