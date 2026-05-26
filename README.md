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


**2. PC + 4**

**Function**
Calculates sequential next instruction address.

**Equation**
- PC + 4

**Block Diagram**
 
<img width="278" height="113" alt="image" src="https://github.com/user-attachments/assets/477333f1-f2a4-4da1-b222-2d5da5710273" />
 
**3. Instruction Memory**

**Function**
Fetches instructions from memory.

**Features**
- Word aligned access
- Uses $readmemh

**Block Diagram**

<img width="261" height="106" alt="image" src="https://github.com/user-attachments/assets/76826071-82c1-4be3-936b-4f2f62a1de4b" />

**4. Register File**

**Function**
Stores 32 general-purpose registers.

**Features**
- Two read ports
- One write port
- x0 hardwired to zero

**Block Diagram**

<img width="378" height="245" alt="image" src="https://github.com/user-attachments/assets/96ed161c-026f-4f6c-8c9f-0494a18c0f96" />

**5. Arithmetic Logic Unit (ALU)**

**Function**
Performs arithmetic and logical operations.

**Supported Operations**
- Addition
- Subtraction
- Shift Operations
- Comparisons
- AND / OR / XOR

**Block Diagram**

<img width="402" height="196" alt="image" src="https://github.com/user-attachments/assets/e1d442ec-2d05-4b25-bf48-ee1ad82471d1" />
     
**6. Immediate Generator**

**Function**
Generates sign-extended immediates.

**Supported Formats**
- I-Type
- S-Type
- B-Type
- J-Type
- U-Type

**Block Diagram

<img width="385" height="143" alt="image" src="https://github.com/user-attachments/assets/638c7f87-8716-48bc-9bbe-cf59a7bbb96b" />

**7. Control Unit**

**Function**
Decodes instruction opcode and generates control signals.

**Generated Signals**
- regWen
- memRw
- wbsel
- pcsel
- asel
- bsel
- imm_sel
- jalr_sel
- AluSel
  
**Block Diagram**

<img width="409" height="142" alt="image" src="https://github.com/user-attachments/assets/02ddf836-4d4c-40c5-86be-6eb4520f17c4" />

**8. Data Memory**

**Function**
Performs load and store operations.

**Supported Instructions**

**Loads**
- lb
- lh
- lw
- lbu
- lhu

**Stores**
- sb
- sh
- sw
  
**Block Diagram**

<img width="372" height="224" alt="image" src="https://github.com/user-attachments/assets/19251d87-6a41-4521-9172-bd0c400e9ca7" />

**9. Write Back Multiplexer**

**Function**
Selects data written back to register file.

**Sources**
- ALU Result
- Data Memory Output
- PC + 4

**Block Diagram**    

<img width="386" height="224" alt="image" src="https://github.com/user-attachments/assets/d68996a7-d8c5-43f6-a8b8-a72918436e1b" />

**10. A_MUX**

**Function**
Selects ALU operand A.

**Sources**
- PC
- data1
  
**Block Diagram**

<img width="386" height="224" alt="image" src="https://github.com/user-attachments/assets/c460ab03-3555-4b58-b5cc-083a0a5c689c" />

       
**11. PC MUX**

**Function**
Selects next PC source.

**Sources**
- PC + 4
- Branch Target
- Jump Target

**Block Diagram**


**12. Branch Comparator**

**Function**
Performs branch comparisons.

**Outputs**
- Eq
- Lt

**Block Diagram**

            
**13. Branch Unit**

**Function**
Determines whether branch should be taken.

**Supported Branches**
- beq
- bne
- blt
- bge
- bltu
- bgeu

**Block Diagram**






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
