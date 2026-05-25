`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 01:01:51 AM
// Design Name: 
// Module Name: Hazard_Unit
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




module hazard_unit(
    // Inputs for Forwarding 
    input [4:0] Rs1E,
    input [4:0] Rs2E,
    input [4:0] RdM,
    input       RegWriteM,
    input [4:0] RdW,
    input       RegWriteW,
    
    // Inputs for Stalling 
    input [4:0] Rs1D,
    input [4:0] Rs2D,
    input [4:0] RdE,
    input       ResultSrcE0, 
    
    // Inputs for Flushing 
    input       PCSrcE,     
    
    // Outputs
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output wire      StallF,
    output wire      StallD,
    output wire      FlushD,
    output wire      FlushE
);

   
    // 1. Data Forwarding Logic 
    
    always @(*) begin
        // ForwardAE
        if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 5'b00000))
            ForwardAE = 2'b10;
        else if (((Rs1E == RdW) && RegWriteW) && (Rs1E != 5'b00000))
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;

        // ForwardBE
        if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 5'b00000))
            ForwardBE = 2'b10;
        else if (((Rs2E == RdW) && RegWriteW) && (Rs2E != 5'b00000))
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
    end


    // 2. Load Stalling Logic 
 
    // A load hazard occurs if an instruction in EX is a Load (ResultSrcE0 == 1)
    // AND its destination register matches either source register in ID.
    wire lwStall;
   assign lwStall = ResultSrcE0 &
                 (RdE != 5'b00000) &
                 ((Rs1D == RdE) | (Rs2D == RdE));
    
    // If a load hazard occurs, stall the Fetch and Decode stages
    assign StallF = lwStall;
    assign StallD = lwStall;

  
    // 3. Control Flushing Logic (Solves Branch Hazards)
   
    // If a branch is taken (PCSrcE == 1), flush the instructions behind it.
    // Also, if we stall for a load, we must flush the EX stage to insert a NOP.
    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;

endmodule
