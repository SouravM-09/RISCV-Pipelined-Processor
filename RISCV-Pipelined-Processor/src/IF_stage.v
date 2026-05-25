`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2026 04:32:05 PM
// Design Name: 
// Module Name: IF_stage
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




module IF_stage(
    input clk,
    input reset,
    
    input StallF,        
    
    input PCSrcE,
    input [31:0] PCTargetE,
    
    output [31:0] InstrF,
    output [31:0] PCF,
    output [31:0] PCPlus4F
);

    wire [31:0] PCNext;
    
  
    assign PCNext = PCSrcE ? PCTargetE : PCPlus4F;

    // --------------------------------------------------
    // Program Counter
    // --------------------------------------------------
    pc PC_reg(
        .clk(clk),
        .reset(reset),
        .EN(~StallF),    
        .PCNext(PCNext),
        .PC(PCF)
    );

    // --------------------------------------------------
    // PC + 4 Adder
    // --------------------------------------------------
    adder PCAdder(
        .A(PCF),
        .B(32'd4),
        .Y(PCPlus4F)
    );

    // --------------------------------------------------
    // Instruction Memory
    // --------------------------------------------------
    instruction_mem IMEM(
        .A(PCF),
        .RD(InstrF)
    );

endmodule
