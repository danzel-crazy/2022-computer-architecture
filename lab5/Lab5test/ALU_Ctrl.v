`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */
wire [2:0] func3;
assign func3 = instr[2:0];

parameter aluadd = 4'b0010;
parameter alusub = 4'b0110;
parameter aluand = 4'b0000;
parameter aluor  = 4'b0001;
parameter aluslt = 4'b0111;
parameter aluxor = 4'b1000;
parameter alusra = 4'b1001;
parameter alusll = 4'b1010;
parameter alusrl = 4'b1011;

reg [3:0] alufunc;

reg [3:0] alufunct3;

always @(*) begin
	case (func3)
		3'b000  : alufunct3 <= aluadd; //addi
		3'b001  : alufunct3 <= alusll; //slli
		3'b010  : alufunct3 <= aluslt; //slti
		3'b101  : alufunct3 <= alusrl; //srli
	endcase
end

always @(*) begin
	case (instr)
		4'b0000 : alufunc <= aluadd;
		4'b1000 : alufunc <= alusub;
		4'b0111 : alufunc <= aluand;
		4'b0110 : alufunc <= aluor;
		4'b0010 : alufunc <= aluslt;
		4'b0100 : alufunc <= aluxor;
		4'b1101 : alufunc <= alusra;
		4'b0001 : alufunc <= alusll;
	endcase
end

always @(*) begin
	case (ALUOp)
		2'b00: ALU_Ctrl_o <= aluadd; 
		2'b01: ALU_Ctrl_o <= alusub; 
		2'b10: ALU_Ctrl_o <= alufunc;
		2'b11: ALU_Ctrl_o <= alufunct3; 
		default: ALU_Ctrl_o <= 4'b1111;
	endcase
end

endmodule
