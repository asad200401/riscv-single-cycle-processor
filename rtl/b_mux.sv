`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 09:40:28 PM
// Design Name: 
// Module Name: b_mux
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


module b_mux(
    input logic [31:0]data1,data2,
    input logic bsel,
    output logic [31:0]b_mux_out
    );
    
    assign b_mux_out = bsel ? data2 : data1;
    
endmodule