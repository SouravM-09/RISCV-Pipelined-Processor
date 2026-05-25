`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:44:36 AM
// Design Name: 
// Module Name: mux
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


module mux2(
input [31:0] RD2E,
input [31:0] ImmExtE,
input ALUSrcE,
output [31:0] SrcBE
    );
    assign SrcBE= ALUSrcE? ImmExtE:RD2E;
endmodule

module mux3(
    input  [31:0] d0,  // From ID/EX Register (Normal path)
    input  [31:0] d1,  // From Writeback Stage (ResultW)
    input  [31:0] d2,  // From Memory Stage (ALUResultM)
    input  [1:0]  s,   // Forwarding control signal
    output reg [31:0] y
);

    always @(*) begin
        case(s)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            default: y = 32'b0;
        endcase
    end

endmodule