`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 10:41:25 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(

input clk,
input reset,

// datapath signals
input [31:0] ReadDataM,
input [31:0] ALUResultM,
input [31:0] PCPlus4M,

// destination register
input [4:0] RdM,

// control signals
input RegWriteM,

input [1:0] ResultSrcM,


// outputs to WB stage

output reg [31:0] ReadDataW,
output reg [31:0] ALUResultW,
output reg [31:0] PCPlus4W,

output reg [4:0] RdW,

output reg RegWriteW,

output reg [1:0] ResultSrcW

);

always @(posedge clk)
begin

    if(reset)
    begin

        // datapath reset

        ReadDataW <= 0;
        ALUResultW <= 0;
        PCPlus4W <= 0;

        // register reset

        RdW <= 0;

        // control reset

        RegWriteW <= 0;

        ResultSrcW <= 0;

    end

    else
    begin

        // datapath transfer

        ReadDataW <= ReadDataM;
        ALUResultW <= ALUResultM;
        PCPlus4W <= PCPlus4M;

        // register transfer

        RdW <= RdM;

        // control transfer

        RegWriteW <= RegWriteM;

        ResultSrcW <= ResultSrcM;

    end

end

endmodule
