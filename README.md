# RISC-V Single-Cycle Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

## RISC-V Datapath

<img width="722" height="385" alt="image" src="https://github.com/user-attachments/assets/798d6b09-0b15-4289-a37b-1b8362bff9a4" />

## Instruction Flow

- PC
- Instruction Fetch
- Instruction Decode
- Register Read
- Immediate Generation
- ALU Execution
- Memory Access
- Write Back
- Next PC Update

## Simulation

**Vivado Simulation**

## Example Test Program

- addi x1, x0, 5
- addi x2, x0, 10
- addi x10, x0, 100
- add  x3, x1, x2
- sub  x4, x2, x1
- sw   x3, 0(x10)
- lw   x5, 0(x10)
- beq  x3, x5, label
- jal  x1, target
- label:
- addi x6, x0, 4
- target:
- sub  x7, x6, x1
- lui  x8, 0x12345
- auipc x9, 0x10
- jalr x11, x9, 0

## Simulation Results

<img width="1173" height="587" alt="image" src="https://github.com/user-attachments/assets/15ed1939-469f-4b8f-8e63-b4f372ff4db4" />

**Key Observations:**
- Correct execution of arithmetic operations (add, sub, addi)
- Successful Store and Load operations (sw → lw), with the value 15 correctly stored and retrieved.
- Correct Branch behavior (beq taken), successfully skipping the jal instruction and redirecting the PC to the label.
- Successful execution of Upper Immediate instruction (lui) with correct immediate loading into x8.
- Correct execution of AUIPC instruction, calculating the PC-relative address and storing the result in x9.
- Successful execution of JALR instruction, with correct PC redirection to the target address and link register (x11) update.
- Correct execution of subtraction using previously calculated register values (sub x7, x6, x1).

**Register File after execution:**

<img width="298" height="297" alt="image" src="https://github.com/user-attachments/assets/7355d0dd-9bb4-4512-90de-d1892116ee60" />

Register	Value
x1	5
x2	10
x3	15
x4	5
x5	15
x6	4
x7	-1
x8	305418240 (0x12345000)
x9	65584 (0x00010030)
x10	100
x11	56 (0x00000038)

**Data Memory:**

<img width="261" height="276" alt="image" src="https://github.com/user-attachments/assets/24522a43-3d70-4758-8b79-435c34cda203" />

- mem[25] = 15 (value stored by sw at byte address 100 and successfully retrieved by lw).

## Tools Used

- SystemVerilog
- Xilinx Vivado
- Venus RISC-V Simulator

## Author

**Asad Iqbal**


