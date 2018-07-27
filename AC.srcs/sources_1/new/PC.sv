`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/29 22:57:11
// Design Name: 
// Module Name: PC
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

module PC(
	input clk,  
	input Rst,  
	input We,   
	input [31:0] NPC,  
	input busy, 
	output reg[31:0] PC = 0   
);


    always @(posedge clk or posedge Rst) begin
       
		if (Rst === 1) begin
            PC = 0;
		end
        
		else if( We === 1 && busy == 0 ) begin
            PC = NPC;
		end
    end

 endmodule
