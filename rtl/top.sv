`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:09:48 PM
// Design Name: 
// Module Name: top
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


module top (
    input logic clk,
    input logic rst
);

    logic [31:0] pc, next_pc, pc_plus_4;
    logic [31:0] instr;
    logic [31:0] data1, data2, dataW;
    logic [31:0] imm;
    logic [31:0] alu_in1, alu_in2, alu_out;
    logic [31:0] dataR;
    logic Eq, Lt;
    logic BrUn, branch_taken;
    logic regWen, bsel, memRw, pcsel, jalr_sel;
    logic [1:0] asel, wbsel;
    logic [2:0] imm_sel;
    logic [3:0] AluSel;

    program_counter PC (.clk(clk), .rst(rst), .next_pc(next_pc), .pc(pc));

    pc_plus_4 PC4 (.pc_in(pc), .pc_out(pc_plus_4)
    );
    
    // pc mux
    assign next_pc = pcsel ? (jalr_sel ? {alu_out[31:1], 1'b0} : alu_out) : pc_plus_4;

    inst_mem IM (.addr(pc), .instr(instr));

    control_unit CU (.opcode(instr[6:0]), .func3(instr[14:12]), .func7(instr[30]), .branch_taken(branch_taken), .AluSel(AluSel), .regWen(regWen), .bsel(bsel), .memRw(memRw), .pcsel(pcsel), .jalr_sel(jalr_sel), .asel(asel), .wbsel(wbsel), .imm_sel(imm_sel));

    imm_gen IG (.imm_in(instr[31:7]), .imm_sel(imm_sel), .imm_out(imm));

    reg_file RF (.clk(clk), .rst(rst), .rs1(instr[19:15]), .rs2(instr[24:20]), .rd(instr[11:7]), .dataW(dataW), .regWen(regWen), .data1(data1), .data2(data2));

    branch_comp BC (.data1(data1), .data2(data2), .BrUn(BrUn), .Eq(Eq), .Lt(Lt));

    branch_unit BU (.Eq(Eq), .Lt(Lt), .func3(instr[14:12]), .BrUn(BrUn), .branch_taken(branch_taken));

    // a mux
    always_comb begin
        case (asel)
            2'b00: alu_in1 = data1;
            2'b01: alu_in1 = pc;
            2'b10: alu_in1 = 32'd0;
            default: alu_in1 = data1;
        endcase
    end

    // b mux
    assign alu_in2 = bsel ? imm : data2;

    alu ALU (.op1(alu_in1), .op2(alu_in2), .AluSel(AluSel), .alu_result(alu_out));

    data_mem DM (.clk(clk), .addr(alu_out), .dataW(data2), .memRw(memRw), .func3(instr[14:12]), .dataR(dataR));

    // wb mux
    always_comb begin
        case (wbsel)
            2'b00: dataW = dataR;
            2'b01: dataW = alu_out;
            2'b10: dataW = pc_plus_4;
            default: dataW = alu_out;
        endcase
    end
endmodule

















