# 32-bit Pipelined RISC-V Processor 🚀

**Author:** Sourav  
**Language:** Verilog HDL  
**Simulation Tool:** Xilinx Vivado  

A fully functional, 5-stage pipelined RISC-V processor designed from scratch in Verilog. This project implements a complete datapath and control unit, along with a robust custom Hazard Unit to automatically resolve data and control hazards on the fly.

---

## 🏗️ Architecture Overview

The processor follows the classic 5-stage RISC pipeline architecture to maximize instruction throughput:
1. **Instruction Fetch (IF):** Program Counter and Instruction Memory integration.
2. **Instruction Decode (ID):** Register File reading and Control Unit (Main & ALU Decoders).
3. **Execute (EX):** ALU operations and Branch Target Address calculation.
4. **Memory (MEM):** Data Memory read/write operations.
5. **Writeback (WB):** Result selection and register file update.

---

## 🛡️ Hazard Handling (The Hazard Unit)

To ensure pipeline efficiency and mathematical accuracy, a dedicated **Hazard Unit** continuously monitors the pipeline registers and resolves structural and data conflicts dynamically:

* **Data Forwarding:** 3-input multiplexers in the Execute stage bypass the register file to forward the most recent data directly from the MEM or WB stages, completely solving Read-After-Write (RAW) data hazards.
* **Load Stalls:** The unit detects when an instruction depends on a `lw` that is still retrieving data from memory. It dynamically freezes the PC and IF/ID registers while inserting a bubble (NOP) into the EX stage.
* **Control Flushes:** When a branch instruction (e.g., `beq`) evaluates as true, the Hazard Unit instantly flushes the incorrectly fetched sequential instructions from the ID and EX stages to prevent erroneous execution.

---

## 💻 Supported Instruction Set

The processor currently supports a core subset of the 32-bit RISC-V base integer instruction set (RV32I):
* **Arithmetic/Logic (R-Type):** `add`, `sub`, `and`, `or`, `slt`
* **Immediate (I-Type):** `addi`, `ori`
* **Memory (Load/Store):** `lw`, `sw`
* **Control Flow:** `beq` (with framework for `jal`)

---

## 📂 Repository Structure

* `/src` - Contains all core Verilog modules (`TOP.v`, `ALU.v`, `Hazard_Unit.v`, `IF_stage.v`, pipeline registers, etc.)
* `/sim` - Contains the simulation testbench (`tb.v`) and the compiled machine code (`program.hex`).
* `/images` - Waveform screenshots demonstrating successful hazard resolution.

---

## 🛠️ Simulation & Testing

The processor was verified using a custom Verilog testbench. The design was stressed against a specifically crafted machine code program (`program.hex`) designed to intentionally trigger simultaneous data hazards, load stalls, and branch flushes. 

Cycle-by-cycle waveform analysis confirms the Hazard Unit successfully protects the pipeline, forwards correct data, and calculates the correct final register states.

### How to Run the Simulation locally:
1. Clone this repository to your local machine.
2. Open the project in Xilinx Vivado (or your preferred Verilog simulator).
3. Ensure all files from the `/src` and `/sim` folders are added to the project hierarchy.
4. Verify that `program.hex` is located in your active simulation directory (update the path in `instruction_mem.v` if necessary).
5. Set `tb.v` as the top-level simulation module and run the behavioral simulation.
