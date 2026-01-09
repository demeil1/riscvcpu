module extend(input  logic [31:7] instr,
              input  logic [1:0]  immsrc,
              output logic [31:0] immext);

        // Pre-slice all necessary instruction bits to avoid selections in always_comb
        logic        sign;
        logic [11:0] imm_I;
        logic [6:0]  imm_S_hi;
        logic [4:0]  imm_S_lo;
        logic        imm_B_7;
        logic [5:0]  imm_B_30_25;
        logic [3:0]  imm_B_11_8;
        logic [7:0]  imm_J_19_12;
        logic        imm_J_20;
        logic [9:0]  imm_J_30_21;

        assign sign        = instr[31];
        assign imm_I       = instr[31:20];
        assign imm_S_hi    = instr[31:25];
        assign imm_S_lo    = instr[11:7];
        assign imm_B_7     = instr[7];
        assign imm_B_30_25 = instr[30:25];
        assign imm_B_11_8  = instr[11:8];
        assign imm_J_19_12 = instr[19:12];
        assign imm_J_20    = instr[20];
        assign imm_J_30_21 = instr[30:21];

        always_comb
                case(immsrc)
                        // I-type
                        2'b00:   immext = {{20{sign}}, imm_I};
                        // S-type (stores)
                        2'b01:   immext = {{20{sign}}, imm_S_hi, imm_S_lo};
                        // B-type (branches)
                        2'b10:   immext = {{20{sign}}, imm_B_7, imm_B_30_25, imm_B_11_8, 1'b0};
                        // J-type (jal)
                        2'b11:   immext = {{12{sign}}, imm_J_19_12, imm_J_20, imm_J_30_21, 1'b0};
                        default: immext = 32'bx; // undefined
                endcase
endmodule
