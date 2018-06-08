`timescale 1ns / 1ps
//Subject:     Architecture project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description: Structure for R-type
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
    clk_i,
	rst_i
);

//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] instr_w;//
wire [5 -1:0] mux_write_w;//
wire [32-1:0] pc_addr_w;//
wire [32-1:0] sign_extend_w;//
wire [32-1:0] shift_left_w;//
wire [32-1:0] mux_alusrc_w;//
wire [32-1:0] mux_pc_result_w;//
wire [32-1:0] add2_sum_w;//
wire [4-1:0]  alu_control_w;//
wire [32-1:0] alu_result_w;//
wire [32-1:0] dataMem_read_w;
wire [32-1:0] mux_dataMem_result_w;//
wire [32-1:0] rf_rs_data_w;//
wire [32-1:0] rf_rt_data_w;//
wire [32-1:0] add1_result_w;//
wire [32-1:0] add1_source_w;//
assign add1_source_w = 32'd4;
wire [3-1:0]  ctrl_alu_op_w;//
wire ctrl_write_mux_w;//
wire ctrl_register_write_w;//
wire ctrl_branch_w;//
wire ctrl_alu_mux_w;//
wire and_result_w;//
wire alu_zero_w;//
wire ctrl_mem_write_w;//
wire ctrl_mem_read_w;//
wire ctrl_mem_mux_w;//
assign and_result_w = alu_zero_w & ctrl_branch_w;
//Create components
ProgramCounter PC(
        .clk_i(clk_i),
	    .rst_i (rst_i),
	    .pc_in_i(mux_pc_result_w),
	    .pc_out_o(pc_addr_w)
	    );

Adder Adder1(
        .src1_i(pc_addr_w),
	    .src2_i(add1_source_w),
	    .sum_o(add1_result_w)
	    );

Instr_Memory IM(
        .pc_addr_i(pc_addr_w),
	    .instr_o(instr_w)
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_w[20:16]),
        .data1_i(instr_w[15:11]),
        .select_i(ctrl_write_mux_w),
        .data_o(mux_write_w)
        );

//DO NOT MODIFY	.RDdata_i && .RegWrite_i
Reg_File RF(
        .clk_i(clk_i),
		.rst_i(rst_i),
		.RSaddr_i(instr_w[25:21]) ,
		.RTaddr_i(instr_w[20:16]) ,
		.RDaddr_i(mux_write_w) ,
		.RDdata_i(mux_dataMem_result_w[31:0]),
		.RegWrite_i(ctrl_register_write_w),
		.RSdata_o(rf_rs_data_w) ,
		.RTdata_o(rf_rt_data_w)
        );

//DO NOT MODIFY	.RegWrite_o
Decoder Decoder(
        .instr_op_i(instr_w[31:26]),
	    .RegWrite_o(ctrl_register_write_w),
	    .ALU_op_o(ctrl_alu_op_w),
	    .ALUSrc_o(ctrl_alu_mux_w),
	    .RegDst_o(ctrl_write_mux_w),
		.Branch_o(ctrl_branch_w),
		.MemWrite_o(ctrl_mem_write_w),
		.MemRead_o(ctrl_mem_read_w),
		.MemtoReg_o(ctrl_mem_mux_w)
	    );

ALU_Ctrl AC(
        .funct_i(instr_w[5:0]),
        .ALUOp_i(ctrl_alu_op_w),
        .ALUCtrl_o(alu_control_w)
        );

Sign_Extend SE(
        .data_i(instr_w[15:0]),
        .data_o(sign_extend_w)
        );

MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(add1_result_w),
        .data1_i(add2_sum_w),
        .select_i(and_result_w),
        .data_o(mux_pc_result_w)
        );

ALU ALU(
        .src1_i(rf_rs_data_w),
	    .src2_i(mux_alusrc_w),
	    .ctrl_i(alu_control_w),
	    .result_o(alu_result_w),
		.zero_o(alu_zero_w)
	    );

Adder Adder2(
        .src1_i(add1_result_w),
	    .src2_i(shift_left_w),
	    .sum_o(add2_sum_w)
	    );

Shift_Left_Two_32 Shifter(
        .data_i(sign_extend_w),
        .data_o(shift_left_w)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rf_rt_data_w),
        .data1_i(sign_extend_w),
        .select_i(ctrl_alu_mux_w),
        .data_o(mux_alusrc_w)
        );

Data_Memory DataMemory(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.addr_i(alu_result_w),
		.data_i(rf_rt_data_w),
		.MemRead_i(ctrl_mem_read_w),
		.MemWrite_i(ctrl_mem_write_w),
		.data_o(dataMem_read_w)
		);

//DO NOT MODIFY	.data_o
 MUX_2to1 #(.size(32)) Mux_DataMem_Read(
        .data0_i(alu_result_w),
        .data1_i(dataMem_read_w),
        .select_i(ctrl_mem_mux_w),
        .data_o(mux_dataMem_result_w)
		);

endmodule
