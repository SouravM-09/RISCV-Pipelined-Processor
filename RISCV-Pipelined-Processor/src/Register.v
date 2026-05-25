`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2026 02:23:45 PM
// Design Name: 
// Module Name: Register
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

module reg_file(
    input clk,
    input we3,

    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,

    input [31:0] wd3,

    output [31:0] rd1,
    output [31:0] rd2
);

    reg [31:0] registers [0:31];

    integer i;

    // initialize registers
    initial begin
        for(i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end

    // synchronous write
    always @(posedge clk) begin

        if(we3 && (a3 != 5'b00000))
            registers[a3] <= wd3;

    end

    // asynchronous read
   assign rd1 = (a1 == 5'b00000) ? 32'b0 :
             ((we3 && (a1 == a3)) ? wd3 : registers[a1]);

assign rd2 = (a2 == 5'b00000) ? 32'b0 :
             ((we3 && (a2 == a3)) ? wd3 : registers[a2]);
endmodule
