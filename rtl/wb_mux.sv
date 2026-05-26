`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:03:58 PM
// Design Name: 
// Module Name: wb_mux
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


module wb_mux(
    input logic [31:0]dataR,alu_result,pc_plus_4,
    input logic [1:0]wbsel,
    output logic [31:0]wb_data
);

    always_comb begin
        case(wbsel)
            2'b00: wb_data = dataR;
            2'b01: wb_data = alu_result;
            2'b10: wb_data = pc_plus_4;
            default: wb_data = 32'd0;
        endcase
    end
endmodule
