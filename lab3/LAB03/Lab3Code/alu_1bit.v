`timescale 1ns/1ps

module alu_1bit(
	input				src1,      //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout,       //1 bit carry out (output)
	output reg          set         //1 bit set       (output)
	);
/* Write your code HERE */
wire and_o, or_o, sum_o;
MUX2to1 MUX1 (.result(result1), .src1(src1), .src2(~src1), .select(Ainvert));
MUX2to1 MUX2 (.result(result2), .src1(src2), .src2(~src2), .select(Binvert));
MUX4to1 MUX3 (.result(result3), .src1(and_o), .src2(or_o), .src3(sum_o), .src4(less), .select(operation));
assign and_o = result1 & result2;
assign or_o = result1 | result2;
assign sum_o = result1 ^ result2 ^ cin;

always @(*) begin
	set = sum_o;
	cout = (result1 & result2) | (result1 & cin) | (result2 & cin);
	result = result3;
end

endmodule
