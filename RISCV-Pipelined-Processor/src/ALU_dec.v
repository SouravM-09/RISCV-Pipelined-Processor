`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 04:29:15 PM
// Design Name: 
// Module Name: AluControl
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


module Alu_dec(
input op5,
input [1:0] ALUOp,
input [2:0] funct3,
input funct75,
output reg [2:0] ALUControl
);

always @(*)
begin
    case(ALUOp)

        2'b00: ALUControl = 3'b000; // ADD (lw, sw)

        2'b01: ALUControl = 3'b001; // SUB (beq)

        2'b10:
        begin
            case(funct3)

                3'b000:
                begin
                    case({op5, funct75})
                        2'b00,
                        2'b01,
                        2'b10: ALUControl = 3'b000; // ADD
                        2'b11: ALUControl = 3'b001; // SUB
                        default: ALUControl = 3'b000;
                    endcase
                end

                3'b010: ALUControl = 3'b101; // SLT
                3'b110: ALUControl = 3'b011; // OR
                3'b111: ALUControl = 3'b010; // AND

                default: ALUControl = 3'b000;

            endcase
        end

        default: ALUControl = 3'b000;

    endcase
end

endmodule
