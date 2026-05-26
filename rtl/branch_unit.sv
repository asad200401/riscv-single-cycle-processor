`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 02:45:26 PM
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
    input logic Eq,Lt,
    input logic [2:0]func3,
    output logic BrUn,
    output logic branch_taken
);

    always_comb begin
        case(func3)
            3'b000: branch_taken = Eq;   // beq
            3'b001: branch_taken = ~Eq;  // bne
            3'b100: branch_taken = Lt;   // blt
            3'b101: branch_taken = ~Lt;  // bge
            3'b110: begin BrUn = 1'b1; branch_taken = Lt; end   // bltu
            3'b111: begin BrUn = 1'b1;  branch_taken = ~Lt; end  // bgeu
            default: begin BrUn = 1'b0; branch_taken = 1'b0; end 
        endcase
    end
endmodule