module alu(input  logic [31:0] a, b,
           input  logic [2:0]  alucontrol,
           output logic [31:0] result,
           output logic        zero);

        logic [31:0] condinvb, sum;
        logic [31:0] slt_val;

        assign condinvb = alucontrol[0] ? ~b : b;
        assign sum = a + condinvb + alucontrol[0];
        
        // Pre-calculating SLT result to avoid bit-select in always_comb
        assign slt_val = {31'b0, sum[31]};

        always_comb
                case (alucontrol)
                        3'b000:  result = sum;         // add
                        3'b001:  result = sum;         // subtract
                        3'b010:  result = a & b;       // and
                        3'b011:  result = a | b;       // or
                        3'b101:  result = slt_val;     // slt
                        default: result = 32'bx;
                endcase

        assign zero = (result == 32'b0);
endmodule
