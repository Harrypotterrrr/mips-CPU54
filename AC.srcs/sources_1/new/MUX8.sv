//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 3:37:08 PM
// Design Name: 
// Module Name: MUX8
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


module MUX8
#(parameter WIDTH = 32)(
	in_0,	
	in_1,	
	in_2,	
	in_3,	
	in_4,	
	in_5,	
	in_6,	
	in_7,	
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
	output reg	[WIDTH-1:0] Q; 

	input [2:0] A;

	always @(in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,A) begin
		if(A == 0) 
			Q = in_0;
		else if(A == 1)
			Q = in_1;
		else if(A == 2)
			Q = in_2; 
		else if(A == 3)
			Q = in_3;
		else if(A == 4)
			Q = in_4;
		else if(A == 5)
			Q = in_5;
		else if(A == 6)
			Q = in_6; 
		else if(A == 7)
			Q = in_7;
	end

endmodule

