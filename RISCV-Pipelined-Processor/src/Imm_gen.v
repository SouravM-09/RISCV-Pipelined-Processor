`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 03:38:03 PM
// Design Name: 
// Module Name: extend
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


module Imm_gen(
    input [31:7] Instr,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);

always @(*)
begin
    case (ImmSrc)

        2'b00:  // I-type (addi, lw)
            ImmExt = {{20{Instr[31]}}, Instr[31:20]};

        2'b01:  // S-type (sw)
            ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

        2'b10:  // B-type (beq)
            ImmExt = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
        
        2'b11:  //J-type
            ImmExt={{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0};
            
        default:
            ImmExt = 32'b0;

    endcase
end

endmodule
