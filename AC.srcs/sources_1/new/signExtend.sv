//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2018 6:22:45 PM
// Design Name: 
// Module Name: sign_extend
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

module sign_extend
        #(parameter INWIDTH = 16,OUTWIDTH=32)
        (in,out);
    input  [ INWIDTH-1:0] in;
    output [OUTWIDTH-1:0] out;
    assign out = {{OUTWIDTH-INWIDTH{in[INWIDTH-1]}}, in};
endmodule