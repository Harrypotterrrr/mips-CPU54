//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2018 11:55:34 PM
// Design Name: 
// Module Name: ALU
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

module ALU(
	input	[31:0] a,
	input	[31:0] b,
	input	[3:0] aluc,
	output	[31:0] r,
	output	zero,	
	output	carry,	
	output	negative,
	output	overflow
);

	wire signed [31:0] sa = a,sb = b;

	wire [31:0]ans_and	=	a & b ;
	wire [31:0]ans_or   =	a | b ;
	wire [31:0]ans_xor	=	a ^ b ;
	wire [31:0]ans_nor	= 	~(a | b);
	wire [31:0]ans_lui	=	{b[15:0],16'b0};
	wire [31:0]ans_slt	=	(sa<sb)?32'b1:32'b0;
	wire [31:0]ans_sltu	=	({1'b0,a}<{1'b0,b})?32'b1:32'b0;
	wire [31:0]ans_sl   =	b<<a;
	wire [31:0]ans_srl	=	b>>a;
	wire [31:0]ans_sra	=	({32{b[31]}} << ( 6'd32 - {1'b0, a[4:0]} ) ) | ( b >> a[4:0] ) ;
	wire signed [31:0]ans_add	= sa + sb;
	wire [31:0]ans_addu	= a+b;
	wire signed [31:0]ans_sub	= sa - sb;
	wire [31:0]ans_subu = a-b;

	wire s_zero		=	(r==32'b0)?1'b1:1'b0;
	wire s_add		=	(aluc == 4'd2);
	wire s_sub		=	(aluc == 4'd3);
	wire s_sltu		=	(aluc == 4'd10);
	wire s_slt		=	(aluc == 4'd11);

	assign zero		=	(s_slt|s_sltu)?(a-b==0)	:	s_zero;
	assign negative	=	((s_add|s_sub)&&(r[31]==1))|(s_slt&(a<b))|(~s_add&~s_sub&~s_slt&r[31]);
	assign overflow	=	(s_add&(~(a[31]^b[31])&(a[31]^r[31])))|(s_sub&((a[31]^b[31])&(a[31]^r[31])));
	
	MUX16
	ALU_mux16 (
		.in_0(ans_addu),
		.in_1(ans_subu),
		.in_2(ans_add),
		.in_3(ans_sub),
		.in_4(ans_and),
		.in_5(ans_or),
		.in_6(ans_xor),
		.in_7(ans_nor),
		.in_8(ans_lui),
		.in_9(ans_lui),
		.in_10(ans_sltu),
		.in_11(ans_slt),
		.in_12(ans_sra),
		.in_13(ans_srl),
		.in_14(ans_sl),
		.in_15(ans_sl),
		.A(aluc),	
		.Q(r)		
	);



endmodule