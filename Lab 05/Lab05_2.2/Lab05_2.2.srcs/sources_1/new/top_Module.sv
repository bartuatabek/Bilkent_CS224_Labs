//// Top level system including MIPS, memories and FGPA controls

module top_module(input logic clk, reset, sw_input1, sw_input2, 
                input logic [3:0] enables,
                output logic DP, memwrite, jalrOp, 
                output logic [3:0] AN,
                output logic [6:0] C);
   
    logic clkPulse1, clkPulse2, pcsrc;
    logic [31:0] pcOut, instrOut, writedata, dataadrr;
    
    top processor( clkPulse1, reset, writedata, dataadrr, pcOut, instrOut, memwrite, pcsrc, jalrOp);
    
    pulse_controller ps1(clk, sw_input1, reset, clkPulse1);
    pulse_controller ps2(clk, sw_input2, reset, clkPulse2);
    
    display_controller dc(clk, clkPulse2, enables, writedata[7:4], writedata[3:0], dataadrr[7:4], dataadrr[3:0], AN, C, DP);
endmodule