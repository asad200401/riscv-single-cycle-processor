`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 12:22:13 PM
// Design Name: 
// Module Name: pc_mux
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


module pc_mux(
    input logic [31:0]pc_plus_4,alu_result,
    input logic pcsel,jalr_sel,branch_taken,
    output logic [31:0]pc_mux_out
);

    always_comb begin
        if (jalr_sel) begin
            pc_mux_out = alu_result & 32'hFFFFFFFE;  // jalr
        end 
        else if (pcsel || branch_taken) begin
            pc_mux_out = alu_result;    // jal or branch
        end 
        else begin
            pc_mux_out = pc_plus_4;     // pc+4
        end
    end
endmodule