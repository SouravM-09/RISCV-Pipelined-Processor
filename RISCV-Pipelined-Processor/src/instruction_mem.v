`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2026 03:35:12 PM
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(
input [31:0] A,
output [31:0] RD
    );
        reg [31:0] memory [0:255];


initial begin

memory[0] = 32'h00500093; // addi x1,x0,5
memory[1] = 32'h00500113; // addi x2,x0,5

memory[2] = 32'h00208463; // beq x1,x2,+8

memory[3] = 32'h00100193; // addi x3,x0,1

memory[4] = 32'h00900213; // addi x4,x0,9


end
         assign RD= memory[A[31:2]];
endmodule
