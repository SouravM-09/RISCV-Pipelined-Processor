`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:40:40 PM
// Design Name: 
// Module Name: control_unit
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2026 07:01:42 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input [6:0] op,
output reg Branch,
output reg Jump,
output reg [1:0] ResultSrc,
output reg MemWrite,
output reg ALUSrc,
output reg [1:0] ImmSrc,
output reg RegWrite,
output reg [1:0] ALUOp
    );
   
    always @(*)
begin

// default values
RegWrite = 0;
ImmSrc = 2'b00;
ALUSrc = 0;
MemWrite = 0;
ResultSrc = 2'b00;
Branch = 0;
ALUOp = 2'b00;
Jump = 0;

case(op)

7'b0000011: begin // lw
RegWrite = 1;
ALUSrc = 1;
ResultSrc = 2'b01;
end

7'b0100011: begin // sw
ALUSrc = 1;
MemWrite = 1;
ImmSrc = 2'b01;
end

7'b0110011: begin // R type
RegWrite = 1;
ALUOp = 2'b10;
end

7'b1100011: begin // beq
Branch = 1;
ImmSrc = 2'b10;
ALUOp = 2'b01;
end

7'b0010011: begin // I type ALU
RegWrite = 1;
ALUSrc = 1;
ImmSrc = 2'b00;
ALUOp = 2'b10;
end

7'b1101111: begin // jal
RegWrite = 1;
Jump = 1;
ALUSrc = 1;
ImmSrc = 2'b11;
ResultSrc = 2'b10;
end

endcase

end
endmodule
