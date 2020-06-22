module alu(input  logic [31:0] a, b, 
           input  logic [2:0]  alucont, 
           output logic [31:0] result,
           output logic flag);
           
    parameter O1 = 3'b010; //ADD
    parameter O2 = 3'b110; //SUB
    parameter O3 = 3'b000; //AND
    parameter O4 = 3'b001; //OR
    parameter O5 = 3'b111; //SLT
    parameter O6 = 3'b011; //SGT
    
    always@(*)
    case(alucont)
    O1: 
    begin
        result <= a + b;
        flag <= (result == 32'b0);
    end
    O2: 
    begin 
        result <= a - b;
        flag <= (a == b);
    end
    O3: 
    begin
        result <= a & b;
        flag <= (result == 32'b0);
    end
    O4: 
    begin
        result <= a | b;
        flag <= (result == 32'b0);
    end
    O5: 
    begin
        result <= a < b;
        flag <= (result == 32'b0);
    end
    O6:
    begin
        result <= (a > b);
        flag <= ~(result == 32'b0);
    end
    default: result <= {32{1'bx}};
    endcase
endmodule