
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);

wire [2:0] func3;
assign func3 = instr[2:0];

/* Write your code HERE */
reg [3:0] result;
assign ALU_Ctrl_o = result;

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
		2'b00: result <= aluadd;
		2'b01: result <= alusub;
		2'b10: result <= alufunc;
		2'b11: result <= aluadd;
		default: result <= 4'b1111;
	endcase
end

endmodule

