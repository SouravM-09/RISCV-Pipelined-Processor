`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 02:31:05 PM
// Design Name: 
// Module Name: MEM_stage
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


module MEM_stage(

input clk,

input MemWriteM,

input [31:0] ALUResultM,
input [31:0] WriteDataM,

input [31:0] PCPlus4M,

output [31:0] ReadDataM,

output [31:0] ALUResultOutM,
output [31:0] PCPlus4OutM

);


// data memory

DataMem DM(

.clk(clk),

.A(ALUResultM),

.WD(WriteDataM),

.MemWrite(MemWriteM),

.RD(ReadDataM)

);


// pass-through outputs

assign ALUResultOutM = ALUResultM;

assign PCPlus4OutM = PCPlus4M;


endmodule
