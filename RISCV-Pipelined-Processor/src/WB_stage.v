`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 02:35:14 PM
// Design Name: 
// Module Name: WB_stage
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
    
    
    module WB_stage(
    input [31:0] ALUResultW,
    input [31:0] ReadDataW,
    input [31:0] PCPlus4W,
    
    input [1:0] ResultSrcW,
    
    output reg [31:0] ResultW
        );
        
        always @(*) begin
    case(ResultSrcW)
    2'b00: ResultW = ALUResultW;
    2'b01: ResultW = ReadDataW;
    2'b10: ResultW = PCPlus4W;
    default: ResultW= 32'b0;
    endcase
        end
    endmodule
