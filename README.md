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
  
**Block Diagram**

<img width="306" height="180" alt="image" src="https://github.com/user-attachments/assets/07666edb-ce08-4f8d-beb3-3461c631cb97" />


2. PC + 4
Function

Calculates sequential next instruction address.

Equation
PC + 4
Block Diagram
        +-----------+
pc ---->| PC + 4    |-----> next_pc
        +-----------+
3. Instruction Memory
Function

Fetches instructions from memory.

Features
Word aligned access
Uses $readmemh
Block Diagram
        +------------------+
addr -->| Instruction Mem  |-----> instruction
        +------------------+
4. Register File
Function

Stores 32 general-purpose registers.

Features
Two read ports
One write port
x0 hardwired to zero
Block Diagram
               +----------------+
rs1 ---------->|                |-----> data1
rs2 ---------->| Register File  |-----> data2
rd ------------|                |
dataW -------->|                |
regWen ------->|                |
clk ---------->|                |
               +----------------+
5. Arithmetic Logic Unit (ALU)
Function

Performs arithmetic and logical operations.

Supported Operations
Addition
Subtraction
Shift Operations
Comparisons
AND / OR / XOR
Block Diagram
            +----------------+
op1 -------->|                |
op2 -------->|      ALU       |-----> result
AluSel ----->|                |
            +----------------+
6. Immediate Generator
Function

Generates sign-extended immediates.

Supported Formats
I-Type
S-Type
B-Type
J-Type
U-Type
Block Diagram
            +----------------+
instruction->| Immediate Gen |
             +-------+--------+
                     |
                     v
               immediate
7. Control Unit
Function

Decodes instruction opcode and generates control signals.

Generated Signals
regWen
memRw
wbsel
pcsel
asel
bsel
imm_sel
branch
BrUn
AluSel
Block Diagram
            +----------------+
opcode ---->|                |
func3 ----->| Control Unit   |-----> control signals
func7 ----->|                |
            +----------------+
8. Data Memory
Function

Performs load and store operations.

Supported Instructions
Loads
lb
lh
lw
lbu
lhu
Stores
sb
sh
sw
Block Diagram
             +----------------+
address ---->|                |
write_data ->|   Data Memory  |-----> read_data
memRw ------>|                |
func3 ------>|                |
clk -------->|                |
             +----------------+
9. Write Back Multiplexer
Function

Selects data written back to register file.

Sources
ALU Result
Data Memory Output
PC + 4
Block Diagram
               +----------------+
alu_result --->|                |
dataR -------->|    WB MUX      |-----> wb_data
pc_plus_4 ---->|                |
wbsel -------->|                |
               +----------------+
10. A MUX
Function

Selects ALU operand A.

Sources
PC
rs1 data
Block Diagram
          +--------------+
PC ------>|              |
rs1 ----->|    A MUX     |-----> ALU op1
asel ---->|              |
          +--------------+
11. PC MUX
Function

Selects next PC source.

Sources
PC + 4
Branch Target
Jump Target
Block Diagram
                 +----------------+
PC+4 ----------->|                |
ALU Result ------>|    PC MUX     |-----> next_pc
pcsel ----------->|                |
                  +----------------+
12. Branch Comparator
Function

Performs branch comparisons.

Outputs
Eq
Lt
Block Diagram
             +----------------+
data1 ------>|                |
data2 ------>| Branch Compare |-----> Eq
BrUn ------->|                |-----> Lt
             +----------------+
13. Branch Unit
Function

Determines whether branch should be taken.

Supported Branches
beq
bne
blt
bge
bltu
bgeu
Block Diagram



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
