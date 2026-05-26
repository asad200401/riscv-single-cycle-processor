`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 09:01:32 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input logic clk,rst,
    input logic [4:0] rs1,rs2,rd,
    input logic [31:0] dataW,
    input logic regWen,
    output logic [31:0] data1,data2
);

    logic [31:0] reg_file [31:0];

    // read data (comb)
    always_comb begin
        data1 = reg_file[rs1];
        data2 = reg_file[rs2];
    end

    // write data (seq)
    always_ff @(negedge clk or posedge rst) begin
        if(rst)
            reg_file[0] <= 32'd0;

        else if(regWen) begin
            if(rd != 5'd0)
                reg_file[rd] <= dataW;

            reg_file[0] <= 32'd0; // keep x0 always zero
        end
    end

endmodule
