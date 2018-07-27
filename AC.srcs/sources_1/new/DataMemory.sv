//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2018 11:57:59 PM
// Design Name: 
// Module Name: DataMemory
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

module Data_ram (
	input clk,   
	input ena,   
	input wena,  
	input [4:0]  addr,          
	input signal_sb,            
	input signal_sh,            
	input [7:0]  sb_data,       
	input [15:0] sh_data,       
	input [31:0] store_addr,    
	input [31:0] data_in,       
	output[31:0] data_out       
);

	reg [31:0] dataMemory[0:31];


	integer i;
	initial begin
		for(i = 0; i < 32; i = i + 1)
			dataMemory[i] <= 0;
	end 


	assign data_out =   (ena)?dataMemory[addr]:0;

	wire [4:0]addr_storeData;
	assign addr_storeData=(signal_sb)?({2'b00,store_addr[31:2]}-32'h4004000):({1'b0,store_addr[31:1]}-32'h8008000);

	always@(negedge clk)
		begin
		if(wena==1) begin
			dataMemory[addr]<=data_in;
		end
	   
		if(signal_sb) begin
			case(store_addr[1:0])
				2'b00: dataMemory[addr_storeData][7:0]   <=  sb_data;
				2'b01: dataMemory[addr_storeData][15:8]  <=  sb_data;
				2'b10: dataMemory[addr_storeData][23:16] <=  sb_data;
				2'b11: dataMemory[addr_storeData][31:24] <=  sb_data;
				default:;
			endcase
		end
		
		if(signal_sh) begin
			case(store_addr[0])
				3'b000: dataMemory[addr_storeData][15:0]      <=  sh_data;
				3'b001: dataMemory[addr_storeData][31:16]     <=  sh_data;
				default:;
			endcase
		end
	end
   

endmodule