`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:22:56 PM
// Design Name: 
// Module Name: sccomp_tb
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

module sccomp_tb;

	reg clk_in;
	reg reset;

	wire clk_true;


	initial begin 
		clk_in = 0;
		reset = 0;
		#1;
		reset = 1;
		#1
		reset = 0;	
	end

	always begin	
		#2;
		clk_in = ~clk_in;
	end

	wire [31:0]inst;
	wire [31:0]pc;
	wire [31:0]addr;
	wire [31:0]temp;
	wire stemp;


	// // assign clk_true = clk_in;
	// clk_wiz_0
	// clk_wiz_0_ins(
	// 	.clk_in1(clk_in),
	// 	.clk_out1(clk_true)
	// );
    

	sccomp_dataflow
	test (
		.clk_in(clk_in),
		.reset(reset),
		 .inst(inst),
		 .pc(pc),
		 .addr(addr),
		 .temp(temp),
		 .stemp(stemp)
	);

	// integer file_output;
	
	// initial begin
	// 	file_output=$fopen("C:\\Users\\JiaHL\\Desktop\\Desktop.exe\\Project\\Vivado_test\\AC\\AC.srcs\\sources_1\\result.txt");
	// end

	// always @(posedge clk_true) begin

	// 	$fdisplay(file_output,"pc: %h"    ,sccomp_tb.pc-32'h400000); //-32'h400000
	// 	$fdisplay(file_output,"instr: %h"    ,sccomp_tb.inst);

	// 	$fdisplay(file_output,"regfile0:  %h"   ,sccomp_tb.test.sccpu.cpu_ref.array_reg[0]);
	// 	$fdisplay(file_output,"regfile1:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[1]);
	// 	$fdisplay(file_output,"regfile2:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[2]);
	// 	$fdisplay(file_output,"regfile3:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[3]);
	// 	$fdisplay(file_output,"regfile4:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[4]);
	// 	$fdisplay(file_output,"regfile5:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[5]);
	// 	$fdisplay(file_output,"regfile6:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[6]);
	// 	$fdisplay(file_output,"regfile7:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[7]);
	// 	$fdisplay(file_output,"regfile8:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[8]);
	// 	$fdisplay(file_output,"regfile9:  %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[9]);
	// 	$fdisplay(file_output,"regfile10: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[10]);
	// 	$fdisplay(file_output,"regfile11: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[11]);
	// 	$fdisplay(file_output,"regfile12: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[12]);
	// 	$fdisplay(file_output,"regfile13: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[13]);
	// 	$fdisplay(file_output,"regfile14: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[14]);
	// 	$fdisplay(file_output,"regfile15: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[15]);
	// 	$fdisplay(file_output,"regfile16: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[16]);
	// 	$fdisplay(file_output,"regfile17: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[17]);
	// 	$fdisplay(file_output,"regfile18: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[18]);
	// 	$fdisplay(file_output,"regfile19: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[19]);
	// 	$fdisplay(file_output,"regfile20: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[20]);
	// 	$fdisplay(file_output,"regfile21: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[21]);
	// 	$fdisplay(file_output,"regfile22: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[22]);
	// 	$fdisplay(file_output,"regfile23: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[23]);
	// 	$fdisplay(file_output,"regfile24: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[24]);
	// 	$fdisplay(file_output,"regfile25: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[25]);
	// 	$fdisplay(file_output,"regfile26: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[26]);
	// 	$fdisplay(file_output,"regfile27: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[27]);
	// 	$fdisplay(file_output,"regfile28: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[28]);
	// 	$fdisplay(file_output,"regfile29: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[29]);
	// 	$fdisplay(file_output,"regfile30: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[30]);
	// 	$fdisplay(file_output,"regfile31: %h"	,sccomp_tb.test.sccpu.cpu_ref.array_reg[31]);

	// end

endmodule
