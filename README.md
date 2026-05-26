# RISC-V Single-Cycle Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)

A complete **Single-Cycle RISC-V RV32I** processor implemented in SystemVerilog from scratch.

## Description

A complete Single-Cycle RISC-V RV32I Processor implemented in SystemVerilog. Supports all base integer instructions (R, I, S, B, U, J types) including LUI, AUIPC, JAL, JALR, and branches. Fully synthesizable with clean modular design.

## Features

- **Architecture**: Single-Cycle RV32I
- **Instruction Set**: Full Base Integer (RV32I)
- **Supported Types**: R, I, S, B, U, J
- **Memory**: Separate Instruction and Data Memory
- **Modular Design**: Clean separation of each stage

## Supported Instructions

- **R-type**: `add, sub, sll, slt, sltu, xor, srl, sra, or, and`
- **I-type**: `addi, slti, sltiu, xori, ori, andi, slli, srli, srai, lw, lh, lb, lhu, lbu, jalr`
- **S-type**: `sw, sh, sb`
- **B-type**: `beq, bne, blt, bge, bltu, bgeu`
- **U-type**: `lui, auipc`
- **J-type**: `jal`

## Project Structure
