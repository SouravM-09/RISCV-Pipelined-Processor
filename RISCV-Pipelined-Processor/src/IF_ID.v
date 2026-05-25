`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 09:12:40 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk,
    input reset,
    input EN,   
    input CLR,  
    
    input [31:0] InstrF,
    input [31:0] PCF,
    input [31:0] PCPlus4F,
    
    output reg [31:0] InstrD,
    output reg [31:0] PCD,
    output reg [31:0] PCPlus4D
);

    always @(posedge clk) begin
        if (reset || CLR) begin 
            InstrD   <= 0; // 
            PCD      <= 0;
            PCPlus4D <= 0;
        end 
        else if (EN) begin // Only pass data forward if NOT stalled
            InstrD   <= InstrF;
            PCD      <= PCF;
            PCPlus4D <= PCPlus4F;
        end
    end

endmodule

