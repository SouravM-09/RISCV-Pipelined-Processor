`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2026 03:54:08 PM
// Design Name: 
// Module Name: PC
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


module pc(
    input clk,
    input reset,
    input EN,          // NEW: Enable pin (Will be tied to ~StallF)
    input [31:0] PCNext,
    output reg [31:0] PC
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;
        end 
        else if (EN) begin // Only update PC if EN is high
            PC <= PCNext;
        end
        // If EN is low (stalled), PC simply holds its current value
    end
    
endmodule
