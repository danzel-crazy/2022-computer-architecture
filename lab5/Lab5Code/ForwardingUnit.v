`timescale 1ns/1ps
module ForwardingUnit (
    input [5-1:0] IDEXE_RS1,
    input [5-1:0] IDEXE_RS2,
    input [5-1:0] EXEMEM_RD,
    input [5-1:0] MEMWB_RD,
    input EXEMEM_RegWrite,
    input MEMWB_RegWrite,
    output reg [2-1:0] ForwardA,
    output reg [2-1:0] ForwardB
);
/* Write your code HERE */
always @(*) begin
    if(EXEMEM_RegWrite == 1 && EXEMEM_RD != 0)begin
        if(EXEMEM_RD == IDEXE_RS1)begin
            ForwardA <= 2'b10;
        end

        if(EXEMEM_RD == IDEXE_RS2)begin
            ForwardB <= 2'b10;
        end
    end
    
    else if(MEMWB_RegWrite == 1 && MEMWB_RD != 0)begin
        if(MEMWB_RD == IDEXE_RS1 && EXEMEM_RD != IDEXE_RS1)begin
        ForwardA <= 2'b01;        
        end
        if(MEMWB_RD == IDEXE_RS2 && EXEMEM_RD != IDEXE_RS2)begin
            ForwardB <= 2'b01;
        end
    end
    
    else begin
        ForwardA <= 2'b00; 
        ForwardB <= 2'b00; 
    end

    
end
endmodule

