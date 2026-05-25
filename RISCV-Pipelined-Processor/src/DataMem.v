`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 02:23:36 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem(
input clk,
input [31:0] A,
input [31:0] WD,
input MemWrite,
output [31:0] RD
    );
    
   reg[31:0] memory[0:255];
   initial begin

    memory[0] = 32'd7;

end
   assign   RD = memory[A[31:2]];
   always @(posedge clk) begin
    if(MemWrite)
        memory[A[31:2]] <= WD;
    end
endmodule
