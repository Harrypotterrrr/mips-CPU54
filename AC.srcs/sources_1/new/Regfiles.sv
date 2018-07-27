// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 04/28/2018 9:57:58 PM
// // Design Name: 
// // Module Name: Regfiles
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////
// `timescale 1ns / 1ps

// module Regfiles(
// 	input clk,               
// 	input rst,               
// 	input we,                
// 	input [4:0] raddr1,      
// 	input [4:0] raddr2,      
// 	input [4:0] waddr,       
// 	input [31:0] wdata,      
	
// 	output [31:0] rdata1,    
// 	output [31:0] rdata2     
// );

// 	reg [31:0] array_reg [0:31];

// 	integer i;
	

// 	initial begin
// 		for(i = 0; i < 32; i = i + 1)
// 			array_reg[i] <= 0;
// 	end

// 	assign rdata1   =   (raddr1==0) ? 0 : array_reg[raddr1];
// 	assign rdata2   =   (raddr2==0) ? 0 : array_reg[raddr2];

// 	always@(negedge clk or posedge rst) begin
// 		if(rst == 1) begin:RESET
// 			for(i=0;i<32;i=i+1)
// 				array_reg[i]<=0;
// 		end
// 		else begin:WRITE
// 			if(we == 1 && waddr != 5'h0)
// 				array_reg[waddr]<=wdata;
// 		end
// 	end

// endmodule
`timescale 1ns / 1ps
module Regfiles(
    input clk, //寄存器组时钟信号，下降沿写入数据
    input rst, //reset 信号，异步复位，高电平时全部寄存器置零
    input we, //寄存器读写有效信号，高电平时允许寄存器写入数据，低电平时允许寄存器读出数据
    input [4:0] raddr1, //所需读取的寄存器的地址
    input [4:0] raddr2, //所需读取的寄存器的地址
    input [4:0] waddr, //写寄存器的地址
    input [31:0] wdata, //写寄存器数据，数据在 clk 下降沿时被写入
    output [31:0] rdata1, //raddr1 所对应寄存器的输出数据
    output [31:0] rdata2 //raddr2 所对应寄存器的输出数据
);
    reg [31:0] array_reg[31:0];
    
    assign rdata1 = array_reg[raddr1];
    assign rdata2 = array_reg[raddr2];
    
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1)
        begin:PC_RST    
            always @ (posedge clk or posedge rst)
            begin
                if(rst)
                begin
                    array_reg[i] <= 32'b0;
                end
                else if(we && waddr == i && waddr != 32'b0)
                begin
                    array_reg[waddr] <= wdata;
                end
            end
        end
    endgenerate
    
    
endmodule