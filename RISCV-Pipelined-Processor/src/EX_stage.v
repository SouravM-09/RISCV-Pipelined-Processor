`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:47:55 AM
// Design Name: 
// Module Name: EX_stage
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



module EX_stage(
    // Datapath Inputs from ID/EX
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] ImmExtE,
    input [31:0] PCE,
    input [31:0] PCPlus4E,
    
    // Control Inputs
    input        ALUSrcE,
    input [2:0]  ALUControlE,
    input        BranchE,
    input        JumpE,
    
    // NEW: Forwarding Inputs (From Hazard Unit & Later Stages)
    input [1:0]  ForwardAE,
    input [1:0]  ForwardBE,
    input [31:0] ALUResultM, // Data forwarded from MEM stage
    input [31:0] ResultW,    // Data forwarded from WB stage

    // Outputs to EX/MEM and Hazard Unit
    output [31:0] ALUResultE,
    output [31:0] WriteDataE,
    output [31:0] PCTargetE,
    output [31:0] PCPlus4OutE,
    output        PCSrcE,
    output        ZeroE
);

    wire [31:0] SrcAE;           // The final A input to the ALU
    wire [31:0] ForwardedRD2E;   // The forwarded value of Rs2
    wire [31:0] SrcBE;           // The final B input to the ALU (after ALUSrc mux)

    // --------------------------------------------------
    // Forwarding Multiplexer for ALU Input A
    // --------------------------------------------------
    mux3 srcA_mux(
        .d0(RD1E),
        .d1(ResultW),
        .d2(ALUResultM),
        .s(ForwardAE),
        .y(SrcAE)
    );

    // --------------------------------------------------
    // Forwarding Multiplexer for Rs2 (Used for ALU or WriteData)
    // --------------------------------------------------
    mux3 srcB_forward_mux(
        .d0(RD2E),
        .d1(ResultW),
        .d2(ALUResultM),
        .s(ForwardBE),
        .y(ForwardedRD2E)
    );

    // --------------------------------------------------
    // ALUSrc Multiplexer (Chooses between Rs2 or Immediate)
    // Notice: We pass the FORWARDED Rs2 data into it
    // --------------------------------------------------
    mux2 m2(
        .RD2E(ForwardedRD2E), 
        .ImmExtE(ImmExtE),
        .ALUSrcE(ALUSrcE),
        .SrcBE(SrcBE)
    );

    // --------------------------------------------------
    // ALU and Adders
    // --------------------------------------------------
    Alu ALU(
        .SrcA(SrcAE),
        .SrcB(SrcBE),
        .ALUControl(ALUControlE),
        .ALUResult(ALUResultE),
        .Zero(ZeroE)
    );

    adder PCTarget(
        .A(PCE),
        .B(ImmExtE),
        .Y(PCTargetE)
    );

    // --------------------------------------------------
    // Output Assignments
    // --------------------------------------------------
    // Store instructions need the forwarded data!
    assign WriteDataE  = ForwardedRD2E; 
    
    assign PCSrcE      = (BranchE & ZeroE) | JumpE;
    assign PCPlus4OutE = PCPlus4E;

endmodule