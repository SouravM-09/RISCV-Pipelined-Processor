`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:24:39 PM
// Design Name: 
// Module Name: ID_EX
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




module ID_EX(
    input clk,
    input reset,
    input CLR, 

    // datapath signals
    input [31:0] RD1D,
    input [31:0] RD2D,
    input [31:0] PCD,
    input [31:0] ImmExtD,
    input [31:0] PCPlus4D,

    // register numbers
    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] RdD,

    // control signals
    input RegWriteD,
    input MemWriteD,
    input BranchD,
    input JumpD,
    input ALUSrcD,
    input [1:0] ResultSrcD,
    input [2:0] ALUControlD,

    // outputs to EX stage
    output reg [31:0] RD1E,
    output reg [31:0] RD2E,
    output reg [31:0] PCE,
    output reg [31:0] ImmExtE,
    output reg [31:0] PCPlus4E,

    output reg [4:0] Rs1E,
    output reg [4:0] Rs2E,
    output reg [4:0] RdE,

    output reg RegWriteE,
    output reg MemWriteE,
    output reg BranchE,
    output reg JumpE,
    output reg ALUSrcE,
    output reg [1:0] ResultSrcE,
    output reg [2:0] ALUControlE
);

    always @(posedge clk) begin
        if (reset || CLR) begin // If flushed, zero out all control signals!
            RD1E <= 0;
            RD2E <= 0;
            PCE <= 0;
            ImmExtE <= 0;
            PCPlus4E <= 0;

            Rs1E <= 0;
            Rs2E <= 0;
            RdE <= 0;

            // Setting control signals to 0 ensures this becomes a safe NOP
            RegWriteE <= 0;
            MemWriteE <= 0;
            BranchE <= 0;
            JumpE <= 0;
            ALUSrcE <= 0;
            ResultSrcE <= 0;
            ALUControlE <= 0;
        end 
        else begin // Normal transfer
            RD1E <= RD1D;
            RD2E <= RD2D;
            PCE <= PCD;
            ImmExtE <= ImmExtD;
            PCPlus4E <= PCPlus4D;

            Rs1E <= Rs1D;
            Rs2E <= Rs2D;
            RdE <= RdD;

            RegWriteE <= RegWriteD;
            MemWriteE <= MemWriteD;
            BranchE <= BranchD;
            JumpE <= JumpD;
            ALUSrcE <= ALUSrcD;
            ResultSrcE <= ResultSrcD;
            ALUControlE <= ALUControlD;
        end
    end

endmodule
