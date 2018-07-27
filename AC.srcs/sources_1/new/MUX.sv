//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2018 3:31:55 PM
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

module MUX
#(parameter WIDTH = 32)(
	in_0,	
	in_1,	
	A,		
	Q		
);
	input		[WIDTH-1:0] in_0;
	input		[WIDTH-1:0] in_1;
	output reg	[WIDTH-1:0] Q; 
		
	input A;

	always @(in_0,in_1,A) begin
		if(A === 0) 
			Q = in_0;
		else if(A === 1)
			Q = in_1;
	end

endmodule