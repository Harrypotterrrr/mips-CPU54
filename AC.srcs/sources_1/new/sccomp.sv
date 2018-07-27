//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2018 5:20:11 PM
// Design Name: 
// Module Name: sccomp_dataflow
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

module sccomp_dataflow(
	input clk_in,
	input reset,
	// output [31:0]inst,
	// output [31:0]pc,
	// output [31:0]addr,


	// output [31:0]temp,
	// output stemp,

	input [15:0] sw,
	output [7:0] o_seg,
	output [7:0] o_sel 
);

	wire [31:0]TPC;
	assign pc = 32'h400000 + {TPC[29:0], 2'b00};

	wire Inst_ram_ena;
	wire Inst_ram_wena;

	wire Data_ram_ena;
	wire Data_ram_wena;
	wire [31:0]alu_out;
	wire [31:0]Data_out;  
	wire [31:0]Data_In;   
	wire [4:0]Data_addr;

	wire signal_sb;
	wire signal_sh;
	wire [7:0]sb_data;     
	wire [15:0]sh_data;    
	wire [31:0]store_addr; 


	wire [31:0]cpu_temp;
	wire cpu_stemp;
	
	wire clk_true;

	// assign stemp = clk_true;
	// assign temp = cpu_temp;
	
	// assign clk_true = clk_in;
    clk_wiz_0 
    clk_wiz_0_ins(
        .clk_in1(clk_in),
        .clk_out1(clk_true)
    );
    
	wire seg7_cs,switch_cs;

    seg7x16  
	seg(
        .clk(clk_in),
        .reset(reset),
        .cs(seg7_cs),
        .i_data(Data_In),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );

    io_sel 
    io_mem(
        .addr(addr), 
        .cs(Data_ram_ena), 
        .sig_w(Data_ram_wena), 
        .sig_r(~Data_ram_wena), 
        .seg7_cs(seg7_cs), 
        .switch_cs(switch_cs)
    );
    
	wire [31:0]data_switch;
    sw_mem_sel
    sw_mem(
        .switch_cs(switch_cs),
        .sw(sw),
        .data(Data_out),
        .data_sel(data_switch)
    );
    
	CPU
	sccpu(
		.clk(clk_true),
		.rstn(~reset),
		.Inst(inst),

		// .Data_In(Data_out),           
		.Data_In(data_switch),  

		.Inst_ram_ena(Inst_ram_ena),	
		.Inst_ram_wena(Inst_ram_wena),
		.Data_ram_ena(Data_ram_ena),	
		.Data_ram_wena(Data_ram_wena),
		.Data_out(Data_In),           
		.Data_addr(Data_addr),        
		.PC(TPC),						
		.alu_out(alu_out), 
		.signal_sb(signal_sb),   
		.signal_sh(signal_sh),   
		.sb_data(sb_data),
		.sh_data(sh_data),       
		.store_addr(store_addr) 
		// ,.stemp(cpu_stemp),
		// .temp(cpu_temp)
	);

	assign addr=alu_out;

	imem
	imem_inst(
		.a(TPC[10:0]),
		.spo(inst)
	);


	Data_ram
	Data_ram_inst(
		.clk(clk_true), 			 
		.ena(Data_ram_ena),   	 
		.wena(Data_ram_wena),	 
		.addr(Data_addr),		 
		.signal_sb(signal_sb),   
		.signal_sh(signal_sh),   
		.sb_data(sb_data),       
		.sh_data(sh_data),       
		.store_addr(store_addr), 
		.data_in(Data_In),	    
		.data_out(Data_out) 	
	);

endmodule
