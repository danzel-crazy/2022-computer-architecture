`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

parameter aluadd = 4'b0010;
parameter alusub = 4'b0110;
parameter aluand = 4'b0000;
parameter aluor  = 4'b0001;
parameter alusra = 4'b1000;
parameter alusll = 4'b1001;
parameter aluxor = 4'b1010;
parameter aluslt = 4'b0111;

reg [4:0] alufunc;

always @(*) begin
	case (instr)
		4'b0000 : alufunc <= aluadd;
		4'b1000 : alufunc <= alusub;
		4'b0111 : alufunc <= aluand;
		4'b0110 : alufunc <= aluor;
		4'b1101 : alufunc <= alusra;
		4'b0001 : alufunc <= alusll;
		4'b0010 : alufunc <= aluslt;
		4'b0100 : alufunc <= aluxor;
		default : alufunc <= aluadd;
	endcase
end

always @(*) begin
	case (ALUOp)
		2'b00: ALU_Ctrl_o <= aluadd;
		2'b01: ALU_Ctrl_o <= alusub;
		2'b10: ALU_Ctrl_o <= alufunc;
		default: ALU_Ctrl_o <= aluadd;
	endcase
end

endmodule
