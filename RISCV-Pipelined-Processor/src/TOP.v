`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 10:53:22 PM
// Design Name: 
// Module Name: TOP
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



module TOP(
    input clk,
    input reset
);

    

    // Hazard Unit Wires 
    wire [1:0]  ForwardAE;
    wire [1:0]  ForwardBE;
    wire        StallF;
    wire        StallD;
    wire        FlushD;
    wire        FlushE;

    // IF Stage Wires 
    wire [31:0] InstrF;
    wire [31:0] PCF;
    wire [31:0] PCPlus4F;
    wire        PCSrcE;      
    wire [31:0] PCTargetE;   

    //  IF/ID Pipeline Register Wires 
    wire [31:0] InstrD;
    wire [31:0] PCD;
    wire [31:0] PCPlus4D;

    //  ID Stage Wires
    wire [31:0] RD1D;
    wire [31:0] RD2D;
    wire [31:0] ImmExtD;
    wire [4:0]  Rs1D;
    wire [4:0]  Rs2D;
    wire [4:0]  RdD;
    wire        RegWriteD;
    wire        MemWriteD;
    wire        BranchD;
    wire        JumpD;
    wire        ALUSrcD;
    wire [1:0]  ResultSrcD;
    wire [2:0]  ALUControlD;

    // ID/EX Pipeline Register Wires 
    wire [31:0] RD1E;
    wire [31:0] RD2E;
    wire [31:0] PCE;
    wire [31:0] ImmExtE;
    wire [31:0] PCPlus4E;
    wire [4:0]  Rs1E;
    wire [4:0]  Rs2E;
    wire [4:0]  RdE;
    wire        RegWriteE;
    wire        MemWriteE;
    wire        BranchE;
    wire        JumpE;
    wire        ALUSrcE;
    wire [1:0]  ResultSrcE;
    wire [2:0]  ALUControlE;

    // EX Stage Wires
    wire [31:0] ALUResultE;
    wire [31:0] WriteDataE;
    wire [31:0] PCPlus4OutE;
    wire        ZeroE;

    // EX/MEM Pipeline Register Wires 
    wire [31:0] ALUResultM;
    wire [31:0] WriteDataM;
    wire [31:0] PCPlus4M;
    wire [4:0]  RdM;
    wire        RegWriteM;
    wire        MemWriteM;
    wire [1:0]  ResultSrcM;

    //  MEM Stage Wires 
    wire [31:0] ReadDataM;
    wire [31:0] ALUResultOutM;
    wire [31:0] PCPlus4OutM;

    //  MEM/WB Pipeline Register Wires 
    wire [31:0] ReadDataW;
    wire [31:0] ALUResultW;
    wire [31:0] PCPlus4W;
    wire [4:0]  RdW;
    wire        RegWriteW;
    wire [1:0]  ResultSrcW;

    //  WB Stage Wires 
    wire [31:0] ResultW;

    // IF stage
  
    IF_stage IF_S(
        .clk(clk),
        .reset(reset),
        .StallF(StallF),         
        .PCSrcE(PCSrcE),         
        .PCTargetE(PCTargetE),   
        .InstrF(InstrF),
        .PCF(PCF),
        .PCPlus4F(PCPlus4F)
    );

    
    // IF/ID REGISTER
   
    IF_ID IfId(
        .clk(clk),
        .reset(reset),
        .EN(~StallD),            
        .CLR(FlushD),           
        .InstrF(InstrF),
        .PCF(PCF),
        .PCPlus4F(PCPlus4F),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    
    // DECODE STAGE 
    
    ID_stage ID_S(
        .clk(clk),
        .reset(reset),
        .InstrD(InstrD),
        
        // Writeback Inputs
        .RegWriteW(RegWriteW),  
        .RDW(RdW),              
        .ResultW(ResultW),       
        
        // Outputs
        .RD1D(RD1D),
        .RD2D(RD2D),
        .ImmExtD(ImmExtD),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RdD(RdD),
        .ALUControlD(ALUControlD),
        .RegWriteD(RegWriteD),
        .MemWriteD(MemWriteD),
        .BranchD(BranchD),
        .JumpD(JumpD),
        .ALUSrcD(ALUSrcD),
        .ResultSrcD(ResultSrcD)
    );

    
    // ID/EX REGISTER
    
    ID_EX IdEx(
        .clk(clk),
        .reset(reset),
        .CLR(FlushE),           
        
        // Inputs
        .RD1D(RD1D),
        .RD2D(RD2D),
        .PCD(PCD),
        .ImmExtD(ImmExtD),
        .PCPlus4D(PCPlus4D),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RdD(RdD),
        .RegWriteD(RegWriteD),
        .MemWriteD(MemWriteD),
        .BranchD(BranchD),
        .JumpD(JumpD),
        .ALUSrcD(ALUSrcD),
        .ResultSrcD(ResultSrcD),
        .ALUControlD(ALUControlD),
        
        // Outputs
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .ImmExtE(ImmExtE),
        .PCPlus4E(PCPlus4E),
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdE(RdE),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .BranchE(BranchE),
        .JumpE(JumpE),
        .ALUSrcE(ALUSrcE),
        .ResultSrcE(ResultSrcE),
        .ALUControlE(ALUControlE)
    );

   
    // EXECUTE STAGE 
    
    EX_stage EX_S(
        // Datapath Inputs
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ImmExtE(ImmExtE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        
        // Control Inputs
        .ALUSrcE(ALUSrcE),
        .ALUControlE(ALUControlE),
        .BranchE(BranchE),
        .JumpE(JumpE),
        
        // Forwarding Inputs
        .ForwardAE(ForwardAE),       
        .ForwardBE(ForwardBE),       
        .ALUResultM(ALUResultOutM),  
        .ResultW(ResultW),           
        
        // Outputs
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCTargetE(PCTargetE),
        .PCPlus4OutE(PCPlus4OutE),
        .PCSrcE(PCSrcE),
        .ZeroE(ZeroE)
    );

    
    // EX/MEM REGISTER
    
    EX_MEM ExMem(
        .clk(clk),
        .reset(reset),
        
        // Inputs
        .ALUResultE(ALUResultE),
        .WriteDataE(WriteDataE),
        .PCPlus4E(PCPlus4OutE),
        .RdE(RdE),
        .RegWriteE(RegWriteE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        
        // Outputs
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM)
    );

    // MEMORY STAGE (MEM)
    
    MEM_stage MEM_S(
        .clk(clk),
        .MemWriteM(MemWriteM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .PCPlus4M(PCPlus4M),
        
        // Outputs
        .ReadDataM(ReadDataM),
        .ALUResultOutM(ALUResultOutM),
        .PCPlus4OutM(PCPlus4OutM)
    );

    // MEM/WB REGISTER

    MEM_WB MemWb(
        .clk(clk),
        .reset(reset),
        
        // Inputs
        .ReadDataM(ReadDataM),
        .ALUResultM(ALUResultOutM),
        .PCPlus4M(PCPlus4OutM),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        
        // Outputs
        .ReadDataW(ReadDataW),
        .ALUResultW(ALUResultW),
        .PCPlus4W(PCPlus4W),
        .RdW(RdW),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW)
    );

    // WRITEBACK STAGE (WB)

    WB_stage WB_S(
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .PCPlus4W(PCPlus4W),
        .ResultSrcW(ResultSrcW),
        .ResultW(ResultW)
    );

    // HAZARD UNIT (The Brains of the Pipeline)

    hazard_unit HU(
        // Forwarding inputs 
        .Rs1E(Rs1E),
        .Rs2E(Rs2E),
        .RdM(RdM),
        .RegWriteM(RegWriteM),
        .RdW(RdW),
        .RegWriteW(RegWriteW),
        
        // Stalling inputs 
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .RdE(RdE),
        .ResultSrcE0(ResultSrcE[0]), 
        
        // Flushing inputs 
        .PCSrcE(PCSrcE),
        
        // Control Outputs
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .StallF(StallF),
        .StallD(StallD),
        .FlushD(FlushD),
        .FlushE(FlushE)
    );

endmodule
