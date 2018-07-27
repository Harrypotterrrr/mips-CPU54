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
    input clk, //�Ĵ�����ʱ���źţ��½���д������
    input rst, //reset �źţ��첽��λ���ߵ�ƽʱȫ���Ĵ�������
    input we, //�Ĵ�����д��Ч�źţ��ߵ�ƽʱ����Ĵ���д�����ݣ��͵�ƽʱ����Ĵ�����������
    input [4:0] raddr1, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] raddr2, //�����ȡ�ļĴ����ĵ�ַ
    input [4:0] waddr, //д�Ĵ����ĵ�ַ
    input [31:0] wdata, //д�Ĵ������ݣ������� clk �½���ʱ��д��
    output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ������������
    output [31:0] rdata2 //raddr2 ����Ӧ�Ĵ������������
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