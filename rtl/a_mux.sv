`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 12:22:30 PM
// Design Name: 
// Module Name: a_mux
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


module a_mux(
    input logic [31:0]pc,data1,
    input logic asel,
    output logic [31:0]a_mux_out
    );
    
    assign a_mux_out = asel ? pc : data1;
    
endmodule
