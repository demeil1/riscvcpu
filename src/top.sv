module top(
    input  logic        clk, reset,
    output logic [31:0] WriteData, DataAdr,
    output logic        MemWrite,
    input  logic [31:0] ReadData,
    output logic [31:0] PC,
    input  logic [31:0] Instr
);

    riscvsingle rvsingle(
        clk, reset, 
        PC, Instr, 
        MemWrite, DataAdr, 
        WriteData, ReadData
    );

endmodule
