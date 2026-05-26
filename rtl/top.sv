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
    input logic clk,rst 
); 
    logic [31:0]next_pc; 
    logic [31:0]pc; 
    logic [31:0]instr; 
    logic regWen; 
    logic [31:0]alu_result; 
    logic [31:0]op1,op2; 
    logic [3:0]AluSel; 
    logic [31:0]imm_out; 
    logic bsel; 
    logic [31:0]b_mux_out;
    logic memRw; 
    logic [31:0]dataR; 
    logic [1:0]wbsel; 
    logic [31:0]wb_data; 
    logic [2:0]imm_sel; 
    logic asel,pcsel,jalr_sel,branch_taken;
    logic BrUn,Eq,Lt; 
    logic [31:0]a_mux_out,pc_mux_out; 

    program_counter PC (.clk(clk),.rst(rst),.next_pc(pc_mux_out),.pc(pc)); 
     
    pc_plus_4 new_pc (.pc_in(pc),.pc_out(next_pc)); 
     
    inst_mem imem (.addr(pc),.instr(instr)); 
     
    reg_file rf (.clk(clk),.rst(rst),.rs1(instr[19:15]),.rs2(instr[24:20]),.rd(instr[11:7]),.dataW(wb_data),.regWen(regWen),.data1(op1),.data2(op2)); 
     
    alu alu_logic (.op1(a_mux_out),.op2(b_mux_out),.AluSel(AluSel),.alu_result(alu_result)); 
     
    imm_gen immgen (.imm_in(instr[31:7]),.imm_sel(imm_sel),.imm_out(imm_out));
     
    b_mux bmux (.data1(op2),.data2(imm_out),.bsel(bsel),.b_mux_out(b_mux_out));
      
    control_unit cu (.opcode(instr[6:0]),.func3(instr[14:12]),.func7(instr[30]),.regWen(regWen),.bsel(bsel),.AluSel(AluSel),.memRw(memRw),.wbsel(wbsel),.imm_sel(imm_sel),.asel(asel),.pcsel(pcsel),.jalr_sel(jalr_sel));
      
    data_mem dmem (.clk(clk),.memRw(memRw),.func3(instr[14:12]),.addr(alu_result),.dataW(op2),.dataR(dataR));
      
    wb_mux wbmux (.alu_result(alu_result),.dataR(dataR),.pc_plus_4(next_pc),.wbsel(wbsel),.wb_data(wb_data));
       
    a_mux amux (.pc(pc),.data1(op1),.asel(asel),.a_mux_out(a_mux_out));
        
    pc_mux pcmux (.pc_plus_4(next_pc),.alu_result(alu_result),.pcsel(pcsel),.jalr_sel(jalr_sel),.branch_taken(branch_taken),.pc_mux_out(pc_mux_out));

    branch_comp bcomp (.data1(op1),.data2(op2),.BrUn(BrUn),.Eq(Eq),.Lt(Lt));
    
    branch_unit bu (.Eq(Eq),.Lt(Lt),.func3(instr[14:12]),.BrUn(BrUn),.branch_taken(branch_taken));
    
endmodule
