//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2018 8:00:02 PM
// Design Name: 
// Module Name: EXT
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


module EXT
        #(parameter IN = 16,OUT=32)
        (Op,in,out);
    
    input  wire   Op; 
    input  [ IN-1:0] in;
    output [OUT-1:0] out;
    
    wire [OUT-1:0] ans_signExtend;
    wire [OUT-1:0] ans_zeroExtend;

    sign_extend #(IN,OUT) sign_extend(in,ans_signExtend);
    zero_extend #(IN,OUT) zero_extend(in,ans_zeroExtend);
    
    MUX #(OUT) ext_MUX(
        .in_0(ans_zeroExtend),
        .in_1(ans_signExtend),
        .A(Op),
        .Q(out)
    );
	
endmodule