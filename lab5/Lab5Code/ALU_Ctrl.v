`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */
// wire [2:0] func3;
// assign func3 = instr[2:0];

parameter aluadd = 4'b0010;
parameter alusub = 4'b0110;
parameter aluand = 4'b0000;
parameter aluor  = 4'b0001;
parameter aluslt = 4'b0111;

reg [3:0] alufunc;

always @(*) begin
	case (instr)
		4'b0000 : alufunc <= aluadd;
		4'b1000 : alufunc <= alusub;
		4'b0111 : alufunc <= aluand;
		4'b0110 : alufunc <= aluor;
		4'b0010 : alufunc <= aluslt;
		default: alufunc <= aluadd;
	endcase
end

always @(*) begin
	case (ALUOp)
		2'b00: ALU_Ctrl_o <= aluadd;
		2'b01: ALU_Ctrl_o <= alusub;
		2'b10: ALU_Ctrl_o <= alufunc;
		2'b11: ALU_Ctrl_o <= aluadd;
		default: ALU_Ctrl_o <= 4'b1111;
	endcase
end

endmodule
