//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 9:57:58 PM
// Design Name: 
// Module Name: HiLo
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
module Special_Register(
	input  [31:0]wdata_Hi,
	input  [31:0]wdata_Lo,
	input  w_Hi,          
	input  w_Lo,          
	output [31:0]rdata_Hi,
	output [31:0]rdata_Lo 
);

	reg [31:0]Hi;
	reg [31:0]Lo;

	assign rdata_Hi = Hi;
	assign rdata_Lo = Lo;

	initial begin
		Hi <= 32'b0;
		Lo <= 32'b0;
	end

	always@(*) begin
		if(w_Lo) begin 
			Lo <= wdata_Lo; 
		end

		if(w_Hi) begin 
			Hi <= wdata_Hi; 
		end	
	end

endmodule