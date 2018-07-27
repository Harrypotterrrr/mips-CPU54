`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2018 10:03:46 PM
// Design Name: 
// Module Name: DIV
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


module DIV(
	input  [31:0]dividend,  
	input  [31:0]divisor,   
	input  start,           
	input  clock,           
	input  reset,           
	output [31:0]q,         
	output [31:0]r,         
	output reg busy         
);

	reg [4:0]count;           
	reg [63:0]temp_dividend;  
	reg [31:0]temp_divisor;   

	assign q = temp_dividend[31:0]; 
	assign r = temp_dividend[63:32];

	initial begin
		count <= 0;
		busy <= 0;
		temp_dividend <= 0;
	end

	always@(posedge clock or posedge reset or negedge start) begin:CLOCK_RESET
		
		if(reset == 1) begin
			count <= 0;
			busy <= 0;
			temp_dividend <= 0;
		end
		
		else begin
	   
			if(start) begin
				busy <= 1;                          
				count <= 0;                         
				temp_dividend <= dividend[31] ? {32'b0,~(dividend-32'b1)}:{32'b0,dividend};  
				temp_divisor <= divisor[31] ? ~(divisor-32'b1):divisor;      
			end
		
			else if(busy) begin
				temp_dividend = temp_dividend << 1;
				temp_dividend = temp_dividend[63:32] >= temp_divisor?{temp_dividend[63:32]-temp_divisor,temp_dividend[31:1],1'b1}:{temp_dividend[63:1],1'b0};

				count = count + 5'b1;
				if(count == 5'h20) begin
					busy = 0;
					temp_dividend[31:0]=(dividend[31]^divisor[31])?~(temp_dividend[31:0]-32'b1):temp_dividend[31:0];
					temp_dividend[63:32]=dividend[31]?~(temp_dividend[63:32]-32'b1):temp_dividend[63:32];           
				end
			end
		end
	end
endmodule