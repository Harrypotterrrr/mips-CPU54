`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/02 23:21:49
// Design Name: 
// Module Name: MULTU
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


module MULTU(
	input clk,     
	input reset,   
	input [31:0]a, 
	input [31:0]b, 
	output[63:0]z, 
	output reg busy
);

	wire [65:0]ans_tempMult;
	assign ans_tempMult = {1'b0,a} * {1'b0,b};
	assign z = ans_tempMult[63:0];

endmodule