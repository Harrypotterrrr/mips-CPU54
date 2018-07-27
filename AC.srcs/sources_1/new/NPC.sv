//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 9:57:58 PM
// Design Name: 
// Module Name: NPC
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

module NPC(
	input	[2:0]op,		
	input	[31:0]PC,		
	input	[25:0]Inst_26,
	input	[31:0]Rf_rdata1,
	input	[31:0]epc_out,   
	output	[31:0]NPC		
);

	wire	[15:0]Inst_16;
	wire	[31:0]PC_plus_1;
	assign PC_plus_1 = PC + 1;
	assign Inst_16 = Inst_26[15:0];



	MUX8 npc_mux8 (
		.in_0(PC_plus_1),								      
		.in_1({16'b0, Inst_16} + PC_plus_1),                 
		.in_2({2'b00,PC[30:27], Inst_26}-32'h100000),
		.in_3(32'h1 + (Rf_rdata1-32'h400000) >> 2),       
		.in_4(32'h1),								  
		.in_5(epc_out),                               
		.in_6(PC_plus_1),                                   
		.in_7(32'h0),                                 
		.A(op),		                                  
		.Q(NPC)		                                  
	);

endmodule