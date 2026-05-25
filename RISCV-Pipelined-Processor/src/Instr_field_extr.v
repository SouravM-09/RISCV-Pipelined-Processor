`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:28:50 PM
// Design Name: 
// Module Name: Instr_field_extr
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


module Instr_field_extr(

input [31:0] instr,

output [6:0] op,
output [2:0] funct3,
output [6:0] funct7,

output [4:0] rs1,
output [4:0] rs2,
output [4:0] rd

);

assign op     = instr[6:0];

assign rd     = instr[11:7];

assign funct3 = instr[14:12];

assign rs1    = instr[19:15];

assign rs2    = instr[24:20];

assign funct7 = instr[31:25];

endmodule