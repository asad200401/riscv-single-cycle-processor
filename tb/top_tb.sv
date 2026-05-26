`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:22:21 PM
// Design Name: 
// Module Name: top_tb
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

module top_tb;

    logic clk;
    logic rst;

    // Instantiate the top module
    top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period (100 MHz)
    end

    // Test stimulus
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        rst = 1;
        #20;
        rst = 0;

        $display("=== RISC-V Single Cycle Processor Test Started ===");

        // Run for sufficient cycles to execute all instructions
        repeat(100) @(posedge clk);

        $display("=== Simulation Finished ===");
        $display("Final Register Values:");
        $display("x1  = %0d", dut.rf.reg_file[1]);
        $display("x2  = %0d", dut.rf.reg_file[2]);
        $display("x3  = %0d", dut.rf.reg_file[3]);
        $display("x5  = %0d", dut.rf.reg_file[5]);
        $display("x6  = %0d", dut.rf.reg_file[6]);
        $display("x7  = %0d", dut.rf.reg_file[7]);

        #50;
        $finish;
    end

endmodule