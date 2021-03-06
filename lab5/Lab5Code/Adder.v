`timescale 1ns/1ps

module Adder(
    input  [32-1:0] src1_i,
    input  [32-1:0] src2_i,
    output reg [32-1:0] sum_o
);

/* Write your code HERE */
always @(*) begin
    sum_o <= src1_i + src2_i;
end


endmodule
