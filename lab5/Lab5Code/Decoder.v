`timescale 1ns/1ps

module Decoder(
    input [7-1:0]  instr_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump
    
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

/* Write your code HERE */
assign opcode = instr_i[6:0];

always @(*) begin
    RegWrite <= (opcode[5:2] == 4'b1000) ? 1'b0 : 1'b1;
    //only store and branch no need
    Branch   <= (opcode == 7'b1100011) ? 1'b1 : 1'b0;
    //only branch 
    Jump <= (opcode[2:0] == 3'b111) ? 1'b1 : 1'b0;
    //only jal jalr
    MemRead <= (opcode == 7'b0000011) ? 1'b1 : 1'b0;
    //only load need
    MemWrite <= (opcode == 7'b0100011) ? 1'b1 : 1'b0;
    //only store need
    ALUSrc <= (opcode[6:4] == 3'b001 || opcode[6:4] == 3'b000 || opcode[6:4] == 3'b010) ? 1'b1 : 1'b0;
    //choose imm
    ALUOp <= (opcode[6:4] == 3'b011) ? 2'b10 : (opcode[6:4] == 3'b001) ? 2'b11 : (opcode[6:4] == 3'b110) ? 2'b10 : 2'b00;

    MemtoReg <= (opcode[6:5] == 2'b00 || opcode[4:2] == 3'b001)? 1'b1 : 1'b0 ;
    //only load  jalr (check)
end

endmodule