`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:00:16 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit( 
    input logic [6:0]opcode, 
    input logic [2:0]func3, 
    input logic func7, 
    output logic [3:0]AluSel, 
    output logic regWen, 
    output logic bsel,memRw,asel,pcsel,jalr_sel, 
    output logic [1:0]wbsel,
    output logic [2:0]imm_sel
); 
    always_comb begin 
        case (opcode) 
            7'b0110011: begin // r-type 
                regWen = 1'b1; 
                AluSel = {func7, func3}; 
                bsel = 1'b0; // rs2 
                asel = 1'b0; // rs1 
                memRw = 1'bx; 
                wbsel = 2'b01; // alu_result 
                imm_sel=3'bxxx; 
                pcsel = 1'b0; // pc+4 
                jalr_sel = 1'bx;  
            end 
            7'b0010011: begin // i-type 
                regWen = 1'b1; 
                AluSel = ((func3 == 3'b101) || (func3 == 3'b001)) ? {func7, func3} : {1'b0, func3}; 
                bsel = 1'b1; // imm 
                asel = 1'b0; // rs1 
                memRw = 1'bx; 
                wbsel = 2'b01; // alu_result 
                imm_sel=3'b000; // i type imm 
                pcsel = 1'b0; // pc+4 
                jalr_sel = 1'bx; 
                end 
            7'b0000011: begin // load 
                regWen = 1'b1; 
                AluSel = 4'b0000; 
                bsel = 1'b1; // imm 
                asel = 1'b0; // rs1 
                memRw = 1'b0; // read 
                wbsel = 2'b00; // mem data 
                imm_sel=3'b000; // i type imm 
                pcsel = 1'b0; // pc+4 
                jalr_sel = 1'bx; 
                end
            7'b0100011: begin // store 
                regWen = 1'b0; 
                AluSel = 4'b0000; 
                bsel = 1'b1; // imm 
                asel = 1'b0; // rs1 
                memRw = 1'b1; // write 
                wbsel = 2'bxx; 
                imm_sel=3'b001; // s type imm 
                pcsel = 1'b0; // pc+4 
                jalr_sel = 1'bx;  
                end 
            7'b1101111: begin // jal 
                regWen = 1'b1; 
                AluSel = 4'b0000; 
                bsel = 1'b1; // imm 
                asel = 1'b1; // pc 
                memRw = 1'bx; 
                wbsel = 2'b10; // pc+4 
                imm_sel = 3'b010; // j type imm 
                pcsel = 1'b1; // pc+imm 
                jalr_sel = 1'b0; 
                end 
            7'b1100111: begin // jalr 
                regWen = 1'b1; 
                AluSel = 4'b0000; 
                bsel = 1'b1; // imm 
                asel = 1'b0; // rs1 
                memRw = 1'bx; 
                wbsel = 2'b10; // pc+4 
                imm_sel = 3'b000; // i type imm 
                pcsel = 1'b1; // pc+imm 
                jalr_sel = 1'b1; 
                end 
            7'b1100011: begin //  branch
                regWen = 1'b0;
                AluSel = 4'b0000;      //  pc+imm
                bsel = 1'b1;           // imm
                asel = 1'b1;           // pc
                memRw = 1'bx;
                wbsel = 2'bxx;
                imm_sel = 3'b011;       // b type imm
                pcsel = 1'b0;          
                jalr_sel = 1'bx;
            end
            7'b0110111: begin // lui
                regWen = 1'b1;
                AluSel = 4'b0000;      // add (0+imm)
                bsel = 1'b1;           // imm
                asel = 1'b0;           // rs1=0 
                memRw = 1'bx;
                wbsel = 2'b01;         // alu_result
                imm_sel = 3'b100;      // u type imm
                pcsel = 1'b0;
                jalr_sel = 1'bx;
            end

            7'b0010111: begin // auipc
                regWen = 1'b1;
                AluSel = 4'b0000;      // add (pc+imm)
                bsel = 1'b1;           // imm
                asel = 1'b1;           // pc
                memRw = 1'bx;
                wbsel = 2'b01;         // alu_result
                imm_sel = 3'b100;      // u type imm
                pcsel = 1'b0;
                jalr_sel = 1'bx;
            end
            default: begin 
                regWen = 1'b0; 
                AluSel = 4'b0000; 
                bsel = 1'b0; 
                asel = 1'b0; 
                memRw =0; 
                wbsel =2'b00; 
                imm_sel=3'b000; 
                pcsel = 1'b0; 
                jalr_sel = 1'b0; 
                end 
            endcase 
       end 
endmodule