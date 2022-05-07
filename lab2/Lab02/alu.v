`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire [32-1: 0] carry_out;
wire [33-1: 0] carry_in;
wire [32-1: 0] set;
wire [32-1: 0] res;
assign carry_in[0] = ALU_control[2];
assign carry_in[31:1] = carry_out[30:0];

genvar  i;
generate
	for(i = 0; i < 32; i=i+1) begin : label 
		if (i == 0)
			alu_1bit alu(.src1(src1[i]), .src2(src2[i]), .less(set[31]), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .cin(carry_in[i]), .operation(ALU_control[1:0]), .result(res[i]), .cout(carry_out[i]), .set(set[i]));
		else 
			alu_1bit alu(.src1(src1[i]), .src2(src2[i]), .less(1'b0), .Ainvert(ALU_control[3]), .Binvert(ALU_control[2]), .cin(carry_in[i]), .operation(ALU_control[1:0]), .result(res[i]), .cout(carry_out[i]), .set(set[i]));
	end
endgenerate

always @(*) begin
	result = res;
	zero = res == 32'b0;
	cout = carry_out[31] & ((ALU_control == 4'b0010) | (ALU_control == 4'b0110));
	overflow = (carry_out[31] ^ carry_in[31]) & ((ALU_control == 4'b0010) | (ALU_control == 4'b0110));
end

// always @(*) begin
// 	if (ALU_control[3:0]==7|ALU_control[3:0]==7) begin
// 		#1;
// 		$display(" fuck %h, %h, %h, %h, %h, %h", src1[31:0], src2[31:0], carry_in[31:0], carry_out[31:0], res[31:0], set[31:0]);
// 	end
// end

endmodule
