`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 11:52:33 PM
// Design Name: 
// Module Name: CLZ
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


module CLZ_module(
	input [31:0]iReg,
	output[31:0]cnt  
);

		assign cnt = 
				iReg[31] == 1 ? 0  :
				iReg[30] == 1 ? 1  :
				iReg[29] == 1 ? 2  :
				iReg[28] == 1 ? 3  :
				iReg[27] == 1 ? 4  :
				iReg[26] == 1 ? 5  :
				iReg[25] == 1 ? 6  :
				iReg[24] == 1 ? 7  :
				iReg[23] == 1 ? 8  :
				iReg[22] == 1 ? 9  :
				iReg[21] == 1 ? 10 :
				iReg[20] == 1 ? 11 :
				iReg[19] == 1 ? 12 :
				iReg[18] == 1 ? 13 :
				iReg[17] == 1 ? 14 :
				iReg[16] == 1 ? 15 :
				iReg[15] == 1 ? 16 :
				iReg[14] == 1 ? 17 :
				iReg[13] == 1 ? 18 :
				iReg[12] == 1 ? 19 :
				iReg[11] == 1 ? 20 :
				iReg[10] == 1 ? 21 :
				iReg[ 9] == 1 ? 22 :
				iReg[ 8] == 1 ? 23 :
				iReg[ 7] == 1 ? 24 :
				iReg[ 6] == 1 ? 25 :
				iReg[ 5] == 1 ? 26 :
				iReg[ 4] == 1 ? 27 :
				iReg[ 3] == 1 ? 28 :
				iReg[ 2] == 1 ? 29 :
				iReg[ 1] == 1 ? 30 :
				iReg[ 0] == 1 ? 31 : 32;

endmodule


