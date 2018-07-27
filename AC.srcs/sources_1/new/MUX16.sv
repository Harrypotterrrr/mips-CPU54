//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 3:46:01 PM
// Design Name: 
// Module Name: MUX16
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

module MUX16
#(parameter WIDTH = 32)(
	in_0,	
	in_1,	
	in_2,	
	in_3,	
	in_4,	
	in_5,	
	in_6,	
	in_7,	
	in_8,	
	in_9,	
	in_10,	
	in_11,	
	in_12,	
	in_13,	
	in_14,	
	in_15,	
	A,		
	Q		
);

	input		[WIDTH-1:0] in_0;
	input		[WIDTH-1:0] in_1;
	input		[WIDTH-1:0] in_2;
	input		[WIDTH-1:0] in_3;
	input		[WIDTH-1:0] in_4;
	input		[WIDTH-1:0] in_5;
	input		[WIDTH-1:0] in_6;
	input		[WIDTH-1:0] in_7;
	input		[WIDTH-1:0] in_8;
	input		[WIDTH-1:0] in_9;
	input		[WIDTH-1:0] in_10;
	input		[WIDTH-1:0] in_11;
	input		[WIDTH-1:0] in_12;
	input		[WIDTH-1:0] in_13;
	input		[WIDTH-1:0] in_14;
	input		[WIDTH-1:0] in_15;
	output reg	[WIDTH-1:0] Q; 

	input [3:0] A;

	always @(in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,
			 in_8,in_9,in_10,in_11,in_12,in_13,in_14,in_15,A) begin
		if(A == 0) 
			Q = in_0;
		else if(A == 1)		Q = in_1;
		else if(A == 2)		Q = in_2; 
		else if(A == 3)		Q = in_3;
		else if(A == 4)		Q = in_4;
		else if(A == 5)		Q = in_5;
		else if(A == 6)		Q = in_6; 
		else if(A == 7)		Q = in_7;
		else if(A == 8)		Q = in_8;
		else if(A == 9)		Q = in_9;
		else if(A == 10)	Q = in_10;
		else if(A == 11)	Q = in_11;
		else if(A == 12)	Q = in_12;
		else if(A == 13)	Q = in_13;
		else if(A == 14)	Q = in_14;
		else if(A == 15)	Q = in_15;
	end

endmodule