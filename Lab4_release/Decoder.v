
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
assign opcode = instr_i[6:0]
assign funct3= 

assign RegWrite = (instr_i == ) ? 1'b1 : 1'b0;
assign Branch = (instr_i == ) ? 1'b1 : 1'b0;
assign Jump = (instr_i == ) ? 1'b1 : 1'b0;
assign WriteBack1 = (instr_i == ) ? 1'b1 : 1'b0;
assign WriteBack0 = (instr_i == ) ? 1'b1 : 1'b0;
assign MemRead = (instr_i == ) ? 1'b1 : 1'b0;
assign MemWrite = (instr_i == ) ? 1'b1 : 1'b0;
assign ALUSrcA = (instr_i == ) ? 1'b1 : 1'b0;
assign ALUSrcB = (instr_i == ) ? 1'b1 : 1'b0;
assign ALUOp = (instr_i == ) ? 1'b1 : 1'b0;


endmodule

