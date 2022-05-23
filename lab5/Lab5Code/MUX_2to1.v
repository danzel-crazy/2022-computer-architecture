`timescale 1ns/1ps

module MUX_2to1(
    input       [32-1:0] data0_i,
    input       [32-1:0] data1_i,
    input                select_i,
    output reg  [32-1:0] data_o
);
/* Write your code HERE */
always @(*) begin
    if(select_i == 0) data_o <= data0_i;
    else data_o <= data1_i;
end

endmodule

