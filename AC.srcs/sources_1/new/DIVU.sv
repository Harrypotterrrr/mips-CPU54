`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2018 9:55:40 PM
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

module DIVU(
	input  [31:0]dividend,
	input  [31:0]divisor, 
	input  start,         
	input  clock,         
	input  reset,         
	output [31:0]q,       
	output [31:0]r,       
	output reg busy       
);

	reg [4:0]ctr_divide;          
	reg [63:0]temp_dividend; 

	assign q=temp_dividend[31:0]; 
	assign r=temp_dividend[63:32];

	initial begin
		ctr_divide <= 0;
		busy <= 0;
		temp_dividend <= 0;
    end


	always@(posedge clock or posedge reset or negedge start)begin:CLOCK_RESET
		if(reset == 1) begin
			ctr_divide <= 0;
			busy <= 0;
			temp_dividend <= 0;
		end
		else  begin
			if(start) begin
				busy <= 1;                        
				ctr_divide <= 0;                       
				temp_dividend <= {32'b0,dividend};
			end 
			else if(busy) begin
				temp_dividend = temp_dividend << 1;
				temp_dividend = temp_dividend[63:32] >= divisor ? 
					{temp_dividend[63:32]-divisor,temp_dividend[31:1],1'b1}
					:	{temp_dividend[63:1],1'b0};
				ctr_divide = ctr_divide + 5'b1;
				if(ctr_divide == 5'h20)
					busy = 0;
			end
		end
	end
	
endmodule