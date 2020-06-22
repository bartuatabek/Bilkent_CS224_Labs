module alu(input  logic [31:0] a, b, 
           input  logic [2:0]  alucont, 
           output logic [31:0] result,
           output logic zero);

    logic [31:0] sub;
    assign sub = a - b;
    
    always_comb 
    case (alucont)
        3'b000: assign result = a & b;
        3'b001: assign result = a | b;
        3'b010: assign result = a + b;
        3'b100: assign result = a & ~b;
        3'b101: assign result = a | ~b;
        3'b110: assign result = sub;
        3'b111: assign result = sub[31];
        default: result = {32{1'bx}};
    endcase
    
    assign zero = result ? 0:1;
endmodule