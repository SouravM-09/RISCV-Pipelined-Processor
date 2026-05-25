`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:03:33 AM
// Design Name: 
// Module Name: ID_stage
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


module ID_stage(
    input clk,
    input reset,

    input [31:0] InstrD,

    // writeback inputs
    input RegWriteW,
    input [4:0] RDW,
    input [31:0] ResultW,

    // outputs to EX stage
    output [31:0] RD1D,
    output [31:0] RD2D,
    output [31:0] ImmExtD,
    output [4:0] Rs1D,
    output [4:0] Rs2D,
    output [4:0] RdD,
    output [2:0] ALUControlD,

    output RegWriteD,
    output MemWriteD,
    output BranchD,
    output JumpD,
    output ALUSrcD,

    output [1:0] ResultSrcD

    );
    
wire [6:0] op;
wire [2:0] funct3;
wire [6:0] funct7;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

wire [1:0] ImmSrcD;
wire [1:0] ALUOpD;

    //instruction field extraction
    Instr_field_extr IFR(
    .instr(InstrD),
    .op(op),
    .funct3(funct3),
    .funct7(funct7),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
    );
    
    //control unit
    control_unit cu(
    .op(op),
    .Branch(BranchD),
    .Jump(JumpD),
    .ResultSrc(ResultSrcD),
    .MemWrite(MemWriteD),
    .ALUSrc(ALUSrcD),
    .ImmSrc(ImmSrcD),
    .RegWrite(RegWriteD),
    .ALUOp(ALUOpD)
    );
    
    //register file
    reg_file RF(
    .clk(clk),
    .we3(RegWriteW),
    .a1(rs1),
    .a2(rs2),
    .a3(RDW),
    .wd3(ResultW),
    .rd1(RD1D),
    .rd2(RD2D)
    );
    
    //immidiate generator
    Imm_gen IMM(
    .Instr(InstrD[31:7]),
    .ImmSrc(ImmSrcD),
    .ImmExt(ImmExtD)
    );
    
    //Alu decoder
    Alu_dec  DEC(
   .op5(op[5]),
    .ALUOp(ALUOpD),
    .funct3(funct3),
    .funct75(funct7[5]),
    .ALUControl(ALUControlD)
    );
    assign Rs1D = rs1;
    assign Rs2D = rs2;
    assign RdD = rd;
    
endmodule
