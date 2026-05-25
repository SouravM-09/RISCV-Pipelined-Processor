`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 10:38:18 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(

input clk,
input reset,

// datapath signals
input [31:0] ALUResultE,
input [31:0] WriteDataE,
input [31:0] PCPlus4E,

// register destination
input [4:0] RdE,

// control signals
input RegWriteE,
input MemWriteE,

input [1:0] ResultSrcE,


// outputs to MEM stage

output reg [31:0] ALUResultM,
output reg [31:0] WriteDataM,
output reg [31:0] PCPlus4M,

output reg [4:0] RdM,

output reg RegWriteM,
output reg MemWriteM,

output reg [1:0] ResultSrcM

);

always @(posedge clk)
begin

    if(reset)
    begin

        // datapath reset

        ALUResultM <= 0;
        WriteDataM <= 0;
        PCPlus4M <= 0;

        // register reset

        RdM <= 0;

        // control reset

        RegWriteM <= 0;
        MemWriteM <= 0;

        ResultSrcM <= 0;

    end

    else
    begin

        // datapath transfer

        ALUResultM <= ALUResultE;
        WriteDataM <= WriteDataE;
        PCPlus4M <= PCPlus4E;

        // register transfer

        RdM <= RdE;

        // control transfer

        RegWriteM <= RegWriteE;
        MemWriteM <= MemWriteE;

        ResultSrcM <= ResultSrcE;

    end

end

endmodule
