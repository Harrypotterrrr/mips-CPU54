//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 3:34:44 PM
// Design Name: 
// Module Name: MUX4
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


module MUX4
#(parameter WIDTH = 32)(
	in_0,	
	in_1,	
	in_2,	
	in_3,	
	A,		
	Q		
);

	input		[WIDTH-1:0] in_0;
	input		[WIDTH-1:0] in_1;
	input		[WIDTH-1:0] in_2;
	input		[WIDTH-1:0] in_3;
	output reg	[WIDTH-1:0] Q; 

	input [1:0] A;

	always @(in_0,in_1,in_2,in_3,A) begin
		if(A == 0) 
			Q = in_0;
		else if(A == 1)
			Q = in_1;
		else if(A == 2)
			Q = in_2; 
		else if(A == 3)
			Q = in_3;
	end

endmodule