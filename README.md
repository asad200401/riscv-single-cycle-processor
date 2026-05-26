# RISC-V Single-Cycle Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)

A complete **Single-Cycle RISC-V RV32I** processor implemented in SystemVerilog from scratch.

## Description

A complete Single-Cycle RISC-V RV32I Processor implemented in SystemVerilog. Supports all base integer instructions (R, I, S, B, U, J types).

## Features

- 32-bit datapath
- Single-cycle architecture
- Separate instruction and data memory
- Register file with 32 registers
- ALU supporting arithmetic and logical operations
- Immediate generator for multiple instruction formats
- Control unit for instruction decoding
- Jump and branch support
- Load/store memory interface
- Modular SystemVerilog design

## Supported RV32I Instructions

**R-type**
- add
- sub
- sll
- slt
- sltu
- xor
- srl
- sra
- or
- and
  
**I-Type**
- addi
- slli
- slti
- sltiu
- xori
- srli
- srai
- ori
- andi

**Load Instructions**
- lb
- lh
- lw
- lbu
- lhu

**Store Instructions**
- sb
- sh
- sw

**Branch Instructions**
- beq
- bne
- blt
- bge
- bltu
- bgeu

**Jump Instructions**
- jal
- jalr

**U-Type Instructions**
- lui
- auipc

## RISC-V Datapath

<img width="722" height="385" alt="image" src="https://github.com/user-attachments/assets/798d6b09-0b15-4289-a37b-1b8362bff9a4" />

## Module Descriptions
**1. Program Counter**

**Function**
Stores the current instruction address.

**Inputs**
- clk
- rst
- next_pc

**Outputs**
- pc
Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **
## Block Diagram
**  **



```mermaid
flowchart TD
    PC[Program Counter] --> IMEM[Instruction Memory]
    IMEM --> CU[Control Unit]
    IMEM --> RF[Register File]
    IMEM --> IMM[Immediate Generator]
    RF --> AMUX[A-MUX]
    RF --> BMUX[B-MUX]
    IMM --> BMUX
    AMUX --> ALU[ALU]
    BMUX --> ALU
    ALU --> DMEM[Data Memory]
    ALU --> PCMUX[PC MUX]
    DMEM --> WBMUX[Writeback MUX]
    ALU --> WBMUX
    PC_PLUS4[PC+4] --> WBMUX
    WBMUX --> RF
    PC_PLUS4 --> PCMUX
    PCMUX --> PC

How to Run

Clone the repository
Open in Vivado / Quartus / EDA Playground
Add all files from src/ folder
Set top.sv as top module
Load inst_mem.mem in instruction memory
Run Simulation
