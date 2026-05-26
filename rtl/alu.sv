`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:22:19 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input logic signed [31:0]op1,op2,
    input logic [3:0]AluSel,
    output logic [31:0]alu_result
    );
    
    always_comb begin
        case (AluSel)
            4'd0: begin //add
            alu_result = op1 + op2;
        end
            4'd8: begin // sub
            alu_result = op1 - op2;
        end
            4'd1: alu_result = op1 << op2[4:0]; // sll
            4'd2: alu_result = {31'b0, (op1 < op2) ? 1'b1 : 1'b0}; // slt
            4'd3: alu_result = {31'b0, ($unsigned(op1) < $unsigned(op2)) ? 1'b1 : 1'b0}; // sltu
            4'd4: alu_result = op1 ^ op2; // xor
            4'd5: alu_result = op1 >> op2[4:0]; // srl
            4'd13: alu_result = op1 >>> op2[4:0]; // sra
            4'd6: alu_result = op1 | op2; // or
            4'd7: alu_result = op1 & op2; // and
            default: alu_result = 32'b0;
        endcase
    end
endmodule
