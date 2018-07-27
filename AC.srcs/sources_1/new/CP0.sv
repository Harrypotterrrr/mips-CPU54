//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2018 08:22:39 PM
// Design Name: 
// Module Name: CP0
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

module CP0 (
	input  clk,  			
	input  rst,				
	input  mfc0,			
	input  mtc0,			
	input  [4:0]addr,		
	input  exception,		
	input  eret,			
	input  [31:0]pc,		
	input  [31:0]cause,		
	input  [31:0]wdata,		
	
	
	output [31:0]rdata,		
	output [31:0]status,
	output [31:0]epc_out
);

	reg [31:0]CP0[31:0];	
	reg [31:0]status_temp;  

	integer i;

	initial begin
	
		for(i = 0;i <= 11;i = i+1) begin 
			CP0[i]<=32'b0; 
		end
		
		CP0[12]<={28'b0,4'b1};
		for(i = 13;i <= 31;i = i+1) begin
			CP0[i]<=32'b0;
		end
		
	end 

	assign rdata	 = 	(mfc0==1)?32'h24:32'bz;
	assign epc_out	 = 	(exception && eret)? CP0[14]:((exception && (eret==0))?32'b1:32'bz);
	assign status	 = 	CP0[12];

	always@(negedge clk or posedge rst) begin
		if(rst==1) begin
			
			for(i = 0;i <= 11;i = i+1) begin 
				CP0[i]<=32'b0;
			end
			
			CP0[12]<={28'b0,4'b1};
			
			for(i = 13;i <= 31;i = i+1) begin 
				CP0[i]<=32'b0;
			end
		end
		
		else begin
			if(!exception) begin
				
				if(mtc0) begin
					CP0[addr]  <= wdata;
				end		
			end
			
			if(exception) begin
				status_temp <= CP0[12];	
				if(!eret) begin
					CP0[14]<=pc;
					CP0[12]<={CP0[12],5'b0};
					CP0[13][6:2]<=cause;
				end
				
				else begin
					CP0[12]<=status_temp;
				end
			end	
		end
	end

endmodule
