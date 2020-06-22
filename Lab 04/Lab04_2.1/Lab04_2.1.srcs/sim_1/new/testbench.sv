`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for simulating ALU operations
//////////////////////////////////////////////////////////////////////////////////


module alu_testbench();

    logic [31:0] a, b;
    logic [2:0] alucont;
    logic [31:0]result;
    logic zero;
    
    alu alu(a, b, alucont, result, zero);
    
    initial begin
        // A AND B
        alucont = 3'b000; 
        a = 32'hFFFF_FFFF;
        b = 32'h1234_5678;
        #10;
        
        // A OR B
        alucont = 3'b001; 
        a = 32'h1234_5678;
        b = 32'h8765_4321;
        #10;
        
        // A + B
        alucont = 3'b010; 
        a = 32'h0000_00FF;
        b = 32'h0000_0001;
        #10;
        
        // not used
        alucont = 3'b011; 
        a = 32'h0000_0000;
        b = 32'h0000_0000;
        #10;
        
        // A AND ~B
        alucont = 3'b100; 
        a = 32'h0000_0000;
        b = 32'h0000_0000;
        #10;
        
        // A OR ~B
        alucont = 3'b101; 
        a = 32'h0000_0000;
        b = 32'h0000_0000;
        #10;
        
        // A - B
        alucont = 3'b110; 
        a = 32'h0000_0100;
        b = 32'h0000_0001;
        #10;
        
        // SLT
        alucont = 3'b111; 
        a = 32'h0000_0000;
        b = 32'h0000_0001;
        #10;
    end
endmodule
