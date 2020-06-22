`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench();

    logic clk;
    logic reset;
    logic pcsrc;
    
    logic [31:0] writedata, dataadr, pc, instr;
    logic memwrite;
    logic jalrOp;
    
    // instantiate the module
    top top(clk, reset, writedata, dataadr, pc, instr, memwrite,pcsrc, jalrOp);
    
    // initialize test
    initial begin
        reset <= 1; #5; reset <= 0;
        #5;
    end
    
    // generate clock to sequence tests
    always begin
        clk <=1; #5; clk <= 0; #5;
    end
endmodule
