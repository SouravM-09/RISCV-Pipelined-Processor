`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 03:57:03 PM
// Design Name: 
// Module Name: Alu
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


module Alu(
input [31:0] SrcA,
input [31:0] SrcB,
input [2:0] ALUControl,
output reg [31:0] ALUResult,
output Zero
);

always @(*)
begin
    case(ALUControl)

        3'b000: ALUResult = SrcA + SrcB;   // ADD
        3'b001: ALUResult = SrcA - SrcB;   // SUB
        3'b010: ALUResult = SrcA & SrcB;   // AND
        3'b011: ALUResult = SrcA | SrcB;   // OR
        3'b101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // SLT

        default: ALUResult = 32'b0;

    endcase
end

assign Zero = (ALUResult == 0);

endmodule