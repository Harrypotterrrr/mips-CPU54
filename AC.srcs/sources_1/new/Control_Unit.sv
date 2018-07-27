//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2018 11:55:34 PM
// Design Name: 
// Module Name: Control_Unit
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

module Control_Unit (
	input clk,                   
	input [31:0]Inst,   		
	input RD1_equal_RD2,         
	input RD1_greater_equal_ZERO,
	
	output[3:0]ALU_select,    	
	output ALU_a_select,   		
	output ALU_b_select,	  	     
	output PC_ena,  			
	output [2:0]PC_select,  		
	output Inst_ram_ena,    	
	output Inst_ram_wena,	     
	output Data_ram_ena,    	
	output Data_ram_wena,	     
	output Regfile_write_ena,        
	output reg[4:0]Regfile_write_addr,
	output [4:0]Regfile_read_addr1,	 
	output [4:0]Regfile_read_addr2,  
	output reg[3:0]Regfile_select_write_data,
	output Sign_entend,  		 
	output Sign_entend_L,        
	output w_Hi,                 
	output w_Lo,                 
	output reg [2:0]w_Hi_mux,    
	output reg [2:0]w_Lo_mux,    
	output mfc0,                 
	output mtc0,                 
	output byte_command,         
	output hbte_command,         
	output signal_sb,            
	output signal_sh,            
	output exception,            
	output eret                  
);

	wire [5:0]op	=	Inst[31:26];
	wire [5:0]func	= 	Inst[5:0];

	wire r_type=(op==6'h0)?1'b1:1'b0;

	wire i_add	=	r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_addu	=	r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] &  func[0];
	wire i_sub	=	r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
	wire i_subu =	r_type &  func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];
	wire i_and	=	r_type &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
	wire i_or	=	r_type &  func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] &  func[0];
	wire i_xor	=	r_type &  func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] & ~func[0];
	wire i_nor	=	r_type &  func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] &  func[0];
	wire i_slt	=	r_type &  func[5] & ~func[4] &  func[3] & ~func[2] &  func[1] & ~func[0];
	wire i_sltu	=	r_type &  func[5] & ~func[4] &  func[3] & ~func[2] &  func[1] &  func[0];
	wire i_sll	=	r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_srl	=	r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
	wire i_sra	=	r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];
	wire i_sllv	=	r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
	wire i_srlv	=	r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] & ~func[0];
	wire i_srav	=	r_type & ~func[5] & ~func[4] & ~func[3] &  func[2] &  func[1] &  func[0];
	wire i_jr	=	r_type & ~func[5] & ~func[4] &  func[3] & ~func[2] & ~func[1] & ~func[0];

	wire i_addi	 =	~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0] ;
	wire i_addiu =	~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] &  op[0] ;
	wire i_andi	 =	~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] & ~op[0] ;
	wire i_ori	 =	~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] &  op[0] ;
	wire i_xori	 =	~op[5] & ~op[4] &  op[3] &  op[2] &  op[1] & ~op[0] ;
	wire i_lw	 =	 op[5] & ~op[4] & ~op[3] & ~op[2] &  op[1] &  op[0] ;
	wire i_sw	 =	 op[5] & ~op[4] &  op[3] & ~op[2] &  op[1] &  op[0] ;
	wire i_beq	 =	~op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0] ;
	wire i_bne	 =	~op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] &  op[0] ;
	wire i_slti	 =	~op[5] & ~op[4] &  op[3] & ~op[2] &  op[1] & ~op[0] ;
	wire i_sltiu =	~op[5] & ~op[4] &  op[3] & ~op[2] &  op[1] &  op[0] ;
	wire i_lui	 =	~op[5] & ~op[4] &  op[3] &  op[2] &  op[1] &  op[0] ;

	wire i_j	 =	~op[5] & ~op[4] & ~op[3] & ~op[2] &  op[1] & ~op[0] ;
	wire i_jal	 =	~op[5] & ~op[4] & ~op[3] & ~op[2] &  op[1] &  op[0] ;

	wire i_div      =   r_type & ~func[5] &  func[4] &  func[3] & ~func[2] &  func[1] & ~func[0];
	wire i_divu     =   r_type & ~func[5] &  func[4] &  func[3] & ~func[2] &  func[1] &  func[0];
	wire i_mult     =   r_type & ~func[5] &  func[4] &  func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_multu    =   r_type & ~func[5] &  func[4] &  func[3] & ~func[2] & ~func[1] &  func[0];
	wire i_jalr     =   r_type & ~func[5] & ~func[4] &  func[3] & ~func[2] & ~func[1] &  func[0];
	wire i_mfhi     =   r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_mflo     =   r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
	wire i_mthi     =   r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] & ~func[1] &  func[0];
	wire i_mtlo     =   r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] &  func[1] &  func[0];

	wire i_break    =   r_type & ~func[5] & ~func[4] &  func[3] &  func[2] & ~func[1] &  func[0];
	wire i_syscall  =   r_type & ~func[5] & ~func[4] &  func[3] &  func[2] & ~func[1] & ~func[0];
	wire i_teq      =   r_type &  func[5] &  func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
	wire i_eret =   ~op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~func[5] &  func[4] &  func[3] & ~func[2] & ~func[1] & ~func[0];

	wire i_bgez =   ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0] ;
	wire i_lbu  =    op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0] ;
	wire i_lb   =    op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] ;
	wire i_lhu  =    op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] &  op[0] ;
	wire i_lh   =    op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0] ;
	wire i_sb   =    op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0] ;
	wire i_sh   =    op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] &  op[0] ;

	wire i_mfc0 =   ~op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] & ~Inst[23];
	wire i_mtc0 =   ~op[5] &  op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] &  Inst[23];

	wire i_clz  =   ~op[5] &  op[4] &  op[3] &  op[2] & ~op[1] & ~op[0] &  func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
	wire i_mul  =   ~op[5] &  op[4] &  op[3] &  op[2] & ~op[1] & ~op[0] & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
 
	assign ALU_select[3]	=	i_slt      | i_sltu	| i_sll	| i_srl | i_sra | i_sllv| i_srlv| i_srav | i_slti | i_sltiu | i_lui ;
	assign ALU_select[2]	=   i_and      | i_or	| i_xor | i_nor | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav  | i_andi | i_ori  | i_xori;
	assign ALU_select[1]	=	i_add      | i_sub	| i_xor | i_nor | i_lb  | i_lbu | i_lh  | i_lhu  | i_sh   | i_sb    | i_slt  | i_sltu | i_sll  | i_sllv  | i_addi | i_addiu | i_xori | i_beq  | i_bne  | i_slti | i_sltiu;
	assign ALU_select[0]	=	i_sub      | i_subu	| i_or	| i_nor | i_slt | i_srl | i_srlv| i_ori	 | i_beq  | i_bne   | i_slti;

	assign ALU_a_select	=	i_sll	| i_srl		| i_sra ;
	assign ALU_b_select	=	i_lb    | i_lbu     | i_lh  | i_lhu | i_sb  | i_sh  | i_addi| i_addiu| i_andi | i_ori   | i_xori| i_lw  | i_sw  | i_slti | i_sltiu| i_lui  ;

	assign PC_ena   =	1'b1;
	assign PC_select[2]	=	(i_break|i_syscall| (i_teq&RD1_equal_RD2) |i_jalr   )?1:0;
	assign PC_select[1]	=	(i_jr	|i_j	  |   i_jal  | i_jalr )?1:0;
	assign PC_select[0]	=	(i_jr	|   (i_beq&RD1_equal_RD2)	|(i_bne&~RD1_equal_RD2) | (RD1_greater_equal_ZERO & i_bgez)|i_eret)?1:0;

	assign exception    = (i_break|i_syscall|   (i_teq&RD1_equal_RD2) | i_eret )?1:0;
	assign eret         = i_eret;


	assign Inst_ram_ena		=	1'b1;
	assign Inst_ram_wena	=	1'b0;


	assign Data_ram_ena	=	i_lw | i_lb | i_lbu | i_lh | i_lhu;
	assign Data_ram_wena=	i_sw  ;


	always@(*)
		begin
		if(r_type==1&&i_j!=1)                   begin   Regfile_write_addr <=Inst[15:11];  end
		else if(i_clz|i_mul)                    begin   Regfile_write_addr <=Inst[15:11];  end
		else if(i_lb|i_lbu|i_lh|i_lhu|i_mfc0)   begin   Regfile_write_addr <=Inst[20:16];  end
		else if((r_type==0&&i_jal!=1))          begin   Regfile_write_addr <=Inst[20:16];  end
		else if(r_type==0&&i_jal==1)            begin   Regfile_write_addr <=5'd31;        end
		else                                    begin   Regfile_write_addr <=5'bxxxxx;     end
		end

	assign Regfile_write_ena			= (~(i_sw | i_beq | i_bne | i_j | i_jr | i_div|i_divu|i_mult|i_multu|i_bgez|i_sb|i_sh|i_break|i_syscall|i_eret|i_mthi|i_mtlo|i_teq|i_mtc0))&~clk;  //时钟的下降是有效 1-允许写不允许读 0-允许读不允许写
	assign Regfile_read_addr1[4:0]	= (i_sll|| i_srl||i_sra||i_lui||i_j||i_jal)?(5'bxxxxx):Inst[25:21];
	assign Regfile_read_addr2[4:0]	= ((r_type==1)|i_sb|i_sh|i_mtc0|i_mul)?((i_j)?5'bxxxxx:Inst[20:16]):((i_sw)?Inst[20:16]:5'bxxxxx);

	always@(*) begin
		if(i_lw)                begin   Regfile_select_write_data <=4'b0010;    end
		else if(i_jal|i_jalr)   begin   Regfile_select_write_data <=4'b0001;    end
		else if(i_mfhi)         begin   Regfile_select_write_data <=4'b0011;    end
		else if(i_mflo)         begin   Regfile_select_write_data <=4'b0100;    end
		else if(i_lb | i_lbu)   begin   Regfile_select_write_data <=4'b0101;    end
		else if(i_lh | i_lhu)   begin   Regfile_select_write_data <=4'b0110;    end
		else if(i_mfc0)         begin   Regfile_select_write_data <=4'b0111;    end
		else if(i_clz)          begin   Regfile_select_write_data <=4'b1000;    end
		else if(i_mul)          begin   Regfile_select_write_data <=4'b1001;    end

		else                    begin   Regfile_select_write_data <=4'b0000;    end
	end

	assign Sign_entend	=	i_addi | i_addiu |  i_lw | i_sw | i_beq | i_bne | i_slti | i_lb | i_lbu | i_lh | i_lhu ;
	assign Sign_entend_L =  i_lb   | i_lh ;

	assign w_Hi =   i_mthi | i_mult | i_multu | i_div | i_divu;
	assign w_Lo =   i_mtlo | i_mult | i_multu | i_div | i_divu;

	always@(*) begin
		if(i_mtlo)          begin   w_Hi_mux <= 3'bzzz; w_Lo_mux <= 3'b000;   end
		else if(i_mthi)     begin   w_Hi_mux <= 3'b000; w_Lo_mux <= 3'bzzz;   end
		else if(i_mult)     begin   w_Hi_mux <= 3'b001; w_Lo_mux <= 3'b001;   end
		else if(i_multu)    begin   w_Hi_mux <= 3'b010; w_Lo_mux <= 3'b010;   end
		else if(i_div)      begin   w_Hi_mux <= 3'b011; w_Lo_mux <= 3'b011;   end
		else if(i_divu)     begin   w_Hi_mux <= 3'b100; w_Lo_mux <= 3'b100;   end
	end

	assign mfc0 =   i_mfc0;
	assign mtc0 =   i_mtc0;

	assign byte_command    =   i_lb    |   i_lbu   ;
	assign hbte_command    =   i_lh    |   i_lhu   ;

	assign signal_sb    =   i_sb;
	assign signal_sh    =   i_sh;

endmodule
