//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2018 7:43:11 PM
// Design Name: 
// Module Name: CPU
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

module CPU(
	input 	clk,    			
	input 	rstn,	    		
	input	[31:0]Inst,	    	
	input   [31:0]Data_In,    
	input   Inst_ram_ena,     
	input   Inst_ram_wena,    
	input   Data_ram_ena,     
	input   Data_ram_wena,    
	output  [31:0]Data_out,   
	output  [4:0]Data_addr,   
	output	[31:0]PC,		  
	output  [31:0]alu_out,    
	output signal_sb,         
	output signal_sh,         
	output [7:0]  sb_data,    
	output [15:0] sh_data,    
	output [31:0] store_addr, 
	output  stemp,
	output  [31:0]temp	
);

	wire [3:0]ALU_select;     
	wire ALU_a_select;			
	wire ALU_b_select;			

	wire [31:0]ALU_a;
	wire [31:0]ALU_b;
	wire [31:0]ALU_return;

	wire zero,carry,neg,overflow; 


	wire PC_ena;			
	wire [2:0] PC_select;
	wire [31:0]NPC;			


	wire eret;     
	wire exception;


	wire Regfile_write_ena;
	wire [3:0]Regfile_select_write_data; 
	wire [4:0]Regfile_write_addr;
	wire [4:0]Regfile_read_addr1;
	wire [4:0]Regfile_read_addr2;
	wire [31:0]Regfile_return_data1;
	wire [31:0]Regfile_return_data2;


	wire Hi_write_ena;  
	wire Lo_write_ena;  
	wire [2:0]Hi_select_write;
	wire [2:0]Lo_select_write;
	reg [31:0] Hi_write_data; 
	reg [31:0] Lo_write_data; 
	wire [31:0] Hi_read_data; 
	wire [31:0] Lo_read_data; 

	wire is_sign_extend;
	wire is_sign_extend_half;
	wire [31:0]EXT_MUX_8_out;
	wire [31:0]EXT_5_out;
	wire [31:0]EXT_MUX_16_out;
	wire [31:0]EXT_16_out;

	wire RD1_equal_RD2;
	wire RD1_greater_equal_ZERO;
	assign RD1_equal_RD2            =   (Regfile_return_data1 == Regfile_return_data1);
	assign RD1_greater_equal_ZERO   =   (Regfile_return_data1[31] != 1);


	wire byte_command;   
	wire hbte_command;   


	wire busy;


	wire [63:0]mult_return;
	wire mult_busy;


	wire [63:0]multu_return;
	wire multu_busy;


	wire DIV_start;            
	wire div_busy;             
	wire [31:0]div_quotient;   
	wire [31:0]div_remainder;  


	wire DIVU_start;           
	wire divu_busy;            
	wire [31:0]divu_quotient;  
	wire [31:0]divu_remainder; 

	wire mfc0;
	wire mtc0;


	wire [31:0]clz_counter;

	Control_Unit
	cpu_cu (
		.clk(clk),                                         
		.Inst(Inst),						               
		.RD1_equal_RD2(RD1_equal_RD2),                     
		.RD1_greater_equal_ZERO(RD1_greater_equal_ZERO),   
		.ALU_select(ALU_select),				           
		.ALU_a_select(ALU_a_select),				       
		.ALU_b_select(ALU_b_select),				       
		.PC_ena(PC_ena),					               
		.PC_select(PC_select),						       
		.Inst_ram_ena(Inst_ram_ena),		               
		.Inst_ram_wena(Inst_ram_wena),		               
		.Data_ram_ena(Data_ram_ena),		               
		.Data_ram_wena(Data_ram_wena),		               
		.Regfile_write_ena(Regfile_write_ena),		       
		.Regfile_write_addr(Regfile_write_addr),		   
		.Regfile_read_addr1(Regfile_read_addr1),	       
		.Regfile_read_addr2(Regfile_read_addr2),	              
		.Regfile_select_write_data(Regfile_select_write_data),    
		.Sign_entend(is_sign_extend), 			      
		.Sign_entend_L(is_sign_extend_half),          
		.w_Hi(Hi_write_ena),                          
		.w_Lo(Lo_write_ena),                          
		.w_Hi_mux(Hi_select_write),                   
		.w_Lo_mux(Lo_select_write),                   
		.mfc0(mfc0),                                  
		.mtc0(mtc0),                                  
		.byte_command(byte_command),                  
		.hbte_command(hbte_command),                  
		.signal_sb(signal_sb),                        
		.signal_sh(signal_sh),                        
		.exception(exception),                        
		.eret(eret)                                   
	);

	wire [4:0]CP0_addr;
	wire [31:0]CP0_rdata; 
	wire [31:0]CP0_wdata; 
	wire [31:0]CP0_status;
	wire [31:0]CP0_cause;
	wire [31:0]epc_out;

	assign CP0_addr     =   Inst[15:11];
	assign CP0_wdata    =   Regfile_return_data2;

	CP0
	cpu_CP0 (
		.clk(clk),  			
		.rst(~rstn),			
		.mfc0(mfc0),			
		.mtc0(mtc0),			
		.addr(CP0_addr),		
		.exception(exception),	
		.eret(eret),
		.pc(PC),		        
		.cause(CP0_cause),		
		.wdata(CP0_wdata),	    
		.rdata(CP0_rdata),	    
		.status(CP0_status),
		.epc_out(epc_out)
	);

	assign Data_addr   =   (byte_command) ? 
						({2'b00,ALU_return[31:2]}-32'h4004000)
						:((hbte_command) ? 
						({1'b0,ALU_return[31:1]}-32'h8008000)
						:ALU_return);          
	assign Data_out    =   Regfile_return_data2; 

	assign store_addr   =   ALU_return;
	assign sb_data      =   Regfile_return_data2[7:0];
	assign sh_data      =   Regfile_return_data2[15:0];


	assign	ALU_a =	(ALU_a_select)?EXT_5_out:Regfile_return_data1 ;
	assign	ALU_b =	(ALU_b_select)?EXT_16_out:Regfile_return_data2 ;

	ALU
	ALU_inst (
		.a(ALU_a),			
		.b(ALU_b),			
		.aluc(ALU_select),	
		.r(ALU_return),		
		.zero(zero),		
		.carry(carry),		
		.negative(neg),		
		.overflow(overflow)	
	);

	assign alu_out=ALU_return;

	reg [31:0]Regfile_wdata;
	always@(*) begin
		if(Regfile_select_write_data===4'b0010)       begin Regfile_wdata <= Data_In ;                               end
		else if(Regfile_select_write_data===4'b0001)  begin Regfile_wdata <= ({PC[29:0]+30'h1,2'b00}+32'h400000);    end
		else if(Regfile_select_write_data===4'b0011)  begin Regfile_wdata <= Hi_read_data;                               end
		else if(Regfile_select_write_data===4'b0100)  begin Regfile_wdata <= Lo_read_data;                               end
		else if(Regfile_select_write_data===4'b0101)  begin Regfile_wdata <= EXT_MUX_8_out;                          end
		else if(Regfile_select_write_data===4'b0110)  begin Regfile_wdata <= EXT_MUX_16_out;                         end
		else if(Regfile_select_write_data===4'b0111)  begin Regfile_wdata <= CP0_rdata;                              end
		else if(Regfile_select_write_data===4'b1000)  begin Regfile_wdata <= clz_counter;                                end
		else if(Regfile_select_write_data===4'b1001)  begin Regfile_wdata <= mult_return[31:0];                      end
		else                                  begin Regfile_wdata <= ALU_return;                             end
		end


	Regfiles
	cpu_ref (
		.clk(clk),					
		.rst(~rstn),    			
		.we(Regfile_write_ena),		
		.raddr1(Regfile_read_addr1),
		.raddr2(Regfile_read_addr2),
		.waddr(Regfile_write_addr),	
		.wdata(Regfile_wdata),		
		.rdata1(Regfile_return_data1),	
		.rdata2(Regfile_return_data2)	
	);

	MULT
	cpu_MULT(
		.clk(clk),          
		.reset(~rstn),      
		.a(Regfile_return_data1),
		.b(Regfile_return_data2),
		.z(mult_return)
	);

	assign temp=mult_return[31:0];

	MULTU
	cpu_MULTU(
		.clk(clk),        
		.reset(~rstn),    
		.a(Regfile_return_data1),  
		.b(Regfile_return_data2),  
		.z(multu_return),   
		.busy(multu_busy)
	);

	DIV
	cpu_DIV(
		.dividend(Regfile_return_data1),
		.divisor(Regfile_return_data2), 
		.start(DIV_start),              
		.clock(clk),                    
		.reset(~rstn),                  
		.q(div_quotient),               
		.r(div_remainder),              
		.busy(div_busy)                 
	);

	DIVU
	cpu_DIVU(
		.dividend(Regfile_return_data1),
		.divisor(Regfile_return_data2), 
		.start(DIVU_start),             
		.clock(clk),                    
		.reset(~rstn),                  
		.q(divu_quotient),              
		.r(divu_remainder),             
		.busy(divu_busy)                
	);


	assign busy=1'b0;

	Special_Register
	cpu_sreg (
		.wdata_Hi(Hi_write_data),
		.wdata_Lo(Lo_write_data),
		.w_Hi(Hi_write_ena),        
		.w_Lo(Lo_write_ena),        
		.rdata_Hi(Hi_read_data),
		.rdata_Lo(Lo_read_data) 
	);

	always@(*)
		begin

		if(Lo_select_write==3'b000)        begin Lo_write_data <= Regfile_return_data1;     end
		else if(Lo_select_write==3'b001)   begin Lo_write_data <= mult_return[31:0];  end
		else if(Lo_select_write==3'b010)   begin Lo_write_data <= multu_return[31:0]; end
		else if(Lo_select_write==3'b011)   begin Lo_write_data <= div_quotient;       end
		else if(Lo_select_write==3'b100)   begin Lo_write_data <= divu_quotient;      end


		if(Hi_select_write==3'b000)        begin Hi_write_data <= Regfile_return_data1;     end
		else if(Hi_select_write==3'b001)   begin Hi_write_data <= mult_return[63:32]; end
		else if(Hi_select_write==3'b010)   begin Hi_write_data <= multu_return[63:32];end
		else if(Hi_select_write==3'b011)   begin Hi_write_data <= div_remainder;      end
		else if(Hi_select_write==3'b100)   begin Hi_write_data <= divu_remainder;     end

		end

	PC
	cpu_pc (
		.clk(clk),  
		.Rst(~rstn),
		.We(PC_ena),
		.NPC(NPC),  
		.busy(busy),
		.PC(PC)     
	);

	NPC
	cpu_NPC (
		.op(PC_select),				
		.PC(PC),					
		.Inst_26(Inst[25:0]),		
		.Rf_rdata1(Regfile_return_data1),	
		.epc_out(epc_out),          
		.NPC(NPC)					
	);

	CLZ_module 
	cpu_clz (
		.iReg(Regfile_return_data1),
		.cnt(clz_counter)
	);
	
	EXT
	#(5,32) 
	cpu_EXT5(	
		.Op(is_sign_extend),
		.in(Inst[10:6]),
		.out(EXT_5_out)
	);

	EXT
	#(16,32) 
	cpu_EXT16(	
		.Op(is_sign_extend),
		.in(Inst[15:0]),
		.out(EXT_16_out)
	);

	wire [7:0]EXT_8_IN;
	wire [15:0]EXT_16_IN;

	MUX4
	#(8)
	cpu_EXT8_MUX4 (
		.in_0(Data_In[7:0]),	
		.in_1(Data_In[15:8]),	
		.in_2(Data_In[23:16]),	
		.in_3(Data_In[31:24]),	
		.A(ALU_return[1:0]),	
		.Q(EXT_8_IN)		   
	);

	EXT
	#(8,32)    
	cpu_EXT_MUX8(
		.Op(is_sign_extend_half),
		.in(EXT_8_IN),
		.out(EXT_MUX_8_out)
	);

	assign EXT_16_IN    =   (ALU_return[0])?Data_In[31:16]:Data_In[15:0];

	EXT
	#(16,32)    
	cpu_EXT_MUX16(	
		.Op(is_sign_extend_half),
		.in(EXT_16_IN),
		.out(EXT_MUX_16_out)
	);

endmodule