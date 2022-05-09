
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */
wire [6:0] opcode;
wire [2:0] funct3;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

assign RegWrite = (opcode[5:2] == 4'b1000) ? 1'b0 : 1'b1;
//only store and branch no need
assign Branch = (opcode == 7'b1100011) ? 1'b1 : 1'b0;
//only branch 
assign Jump = (opcode[2:0] == 3'b111) ? 1'b1 : 1'b0;
//only jal jalr
assign WriteBack1 = (opcode[2:0] == 3'b111) ? 1'b1 : 1'b0;
//only jal jalr
assign WriteBack0 = (opcode[6:4] == 3'b011 || opcode[6:4] == 3'b001) ?1'b0 : 1'b1 ;
//R-type and addi no need
assign MemRead = (opcode == 7'b0000011) ? 1'b1 : 1'b0;
//only load need
assign MemWrite = (opcode == 7'b0100011) ? 1'b1 : 1'b0;
//only store need
assign ALUSrcA = (opcode == 7'b1100111) ? 1'b1 : 1'b0;
//only jalr
assign ALUSrcB = (opcode[6:4] == 3'b001 || opcode[6:4] == 3'b000 || opcode[6:4] == 3'b010) ? 1'b1 : 1'b0;
//choose imm
assign ALUOp = (opcode[6:4] == 3'b011) ? 2'b10 : (opcode[6:4] == 3'b001) ? 2'b11 : (opcode[6:4] == 3'b110) ? 2'b10 : 2'b00;

endmodule

