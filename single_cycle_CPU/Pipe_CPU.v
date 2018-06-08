`timescale 1ns / 1ps
/*******************************************************************
 * Create Date: 	2016/05/03
 * Design Name: 	Pipeline CPU
 * Module Name:		Pipe_CPU
 * Project Name: 	Architecture Project_3 Pipeline CPU

 * Please DO NOT change the module name, or your'll get ZERO point.
 * You should add your code here to complete the project 3.
 ******************************************************************/
module Pipe_CPU(
        clk_i,
		rst_i
		);

/****************************************
*            I/O ports                  *
****************************************/
input clk_i;
input rst_i;

/****************************************
*          Internal signal              *
****************************************/

//Internal Signles
wire [2-1:0] ForwardA;//
wire [2-1:0] ForwardB;//
wire [32-1:0] mux3to1_a;
wire [32-1:0] mux3to1_b;
wire [32-1:0] mux3to1_b_MEM;
wire [32-1:0] instr_w;//
wire [32-1:0] instr_w_ID;//
wire [32-1:0] instr_w_EX;//
wire [5 -1:0] mux_write_w;//
wire [5 -1:0] mux_write_w_MEM;//
wire [5 -1:0] mux_write_w_WB;//
wire [32-1:0] pc_addr_w;//
wire [32-1:0] sign_extend_w;//
wire [32-1:0] sign_extend_w_EX;//
wire [32-1:0] shift_left_w;//
wire [32-1:0] mux_alusrc_w;//
wire [32-1:0] mux_pc_result_w;//
wire [32-1:0] add2_sum_w;//
wire [4-1:0]  alu_control_w;//
wire [32-1:0] alu_result_w;//
wire [32-1:0] alu_result_w_MEM;//
wire [32-1:0] alu_result_w_WB;//
wire [32-1:0] dataMem_read_w;
wire [32-1:0] dataMem_read_w_WB;
wire [32-1:0] mux_dataMem_result_w;//
wire [32-1:0] rf_rs_data_w;//
wire [32-1:0] rf_rt_data_w;//
wire [32-1:0] rf_rs_data_w_EX;//
wire [32-1:0] rf_rt_data_w_EX;//
wire [32-1:0] rf_rt_data_w_MEM;//
wire [32-1:0] add1_result_w;//
wire [32-1:0] add1_result_w_ID;//
wire [32-1:0] add1_result_w_EX;//
wire [32-1:0] add1_source_w;//
assign add1_source_w = 32'd4;
wire [3-1:0]  ctrl_alu_op_w;//
wire ctrl_write_mux_w;//
wire ctrl_register_write_w;//
wire ctrl_branch_w;//
wire ctrl_alu_mux_w;//
wire and_result_w;//
wire alu_zero_w;//
wire alu_zero_w_MEM;//
wire ctrl_mem_write_w;//
wire ctrl_mem_read_w;//
wire ctrl_mem_mux_w;//

wire ctrl_mem_write_w_EX;//
wire ctrl_mem_read_w_EX;//
wire ctrl_mem_mux_w_EX;//
wire [3-1:0]  ctrl_alu_op_w_EX;//
wire ctrl_write_mux_w_EX;//
wire ctrl_register_write_w_EX;//
wire ctrl_branch_w_EX;//
wire ctrl_alu_mux_w_EX;//

wire ctrl_mem_write_w_MEM;//
wire ctrl_mem_read_w_MEM;//
wire ctrl_mem_mux_w_MEM;//
wire [3-1:0]  ctrl_alu_op_w_MEM;//
wire ctrl_write_mux_w_MEM;//
wire ctrl_register_write_w_MEM;//
wire ctrl_branch_w_MEM;//
wire ctrl_alu_mux_w_MEM;//

wire ctrl_mem_mux_w_WB;//
wire ctrl_register_write_w_WB;//
wire ctrl_write_mux_w_WB;//

assign and_result_w = alu_zero_w_MEM & ctrl_branch_w_MEM;

wire [2-1:0]mux_ccc;
wire [5-1:0]mux_ddd;

/**** IF stage ****/
//control signal...


/**** ID stage ****/
//control signal...


/**** EX stage ****/
//control signal...


/**** MEM stage ****/
//control signal...


/**** WB stage ****/
//control signal...


/**** Data hazard ****/
//control signal...


/****************************************
*       Instantiate modules             *
****************************************/
//Instantiate the components in IF stage
ProgramCounter PC(
        .clk_i(clk_i),
	    .rst_i (rst_i),
	    .pc_in_i(mux_pc_result_w),//
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

Pipe_Reg #(.size(32)) IF_ID1(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(add1_result_w),
			.data_o(add1_result_w_ID)
		);

Pipe_Reg #(.size(32)) IF_ID2(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(instr_w),
			.data_o(instr_w_ID)
		);


//Instantiate the components in ID stage
//DO NOT MODIFY	.RDdata_i && .RegWrite_i
Reg_File RF(
        .clk_i(clk_i),
		.rst_i(rst_i),
		.RSaddr_i(instr_w_ID[25:21]) ,
		.RTaddr_i(instr_w_ID[20:16]) ,
		.RDaddr_i(mux_write_w_WB) ,//
		.RDdata_i(mux_dataMem_result_w[31:0]),//
		.RegWrite_i(ctrl_register_write_w_WB),//
		.RSdata_o(rf_rs_data_w) ,
		.RTdata_o(rf_rt_data_w)
        );

//DO NOT MODIFY	.RegWrite_o
Decoder Decoder(
        .instr_op_i(instr_w_ID[31:26]),
	    .RegWrite_o(ctrl_register_write_w),//WB
	    .ALU_op_o(ctrl_alu_op_w),//EX
	    .ALUSrc_o(ctrl_alu_mux_w),//EX
	    .RegDst_o(ctrl_write_mux_w),//EX
		.Branch_o(ctrl_branch_w),//MEM
		.MemWrite_o(ctrl_mem_write_w),//MEM
		.MemRead_o(ctrl_mem_read_w),//MEM
		.MemtoReg_o(ctrl_mem_mux_w)//WB
	    );

Sign_Extend SE(
        .data_i(instr_w_ID[15:0]),
        .data_o(sign_extend_w)
        );

Pipe_Reg #(.size(32)) ID_EX1(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(add1_result_w_ID),
			.data_o(add1_result_w_EX)
		);

Pipe_Reg #(.size(32)) ID_EX2(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(sign_extend_w),
			.data_o(sign_extend_w_EX)
		);

Pipe_Reg #(.size(32)) ID_EX3(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(rf_rs_data_w),
			.data_o(rf_rs_data_w_EX)
		);

Pipe_Reg #(.size(32)) ID_EX4(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(rf_rt_data_w),
			.data_o(rf_rt_data_w_EX)
		);
Pipe_Reg #(.size(32)) ID_EX5(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(add1_result_w_ID),
			.data_o(add1_result_w_EX)
		);
Pipe_Reg #(.size(32)) ID_EX6(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(instr_w_ID),
			.data_o(instr_w_EX)
		);

Pipe_Reg #(.size(3)) ID_EX8(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_alu_op_w),
			.data_o(ctrl_alu_op_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX9(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_register_write_w),
			.data_o(ctrl_register_write_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX10(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_alu_mux_w),
			.data_o(ctrl_alu_mux_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX11(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_write_mux_w),
			.data_o(ctrl_write_mux_w_EX)
		);

Pipe_Reg #(.size(1)) aaa(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_write_mux_w_EX),
			.data_o(ctrl_write_mux_w_MEM)
		);
Pipe_Reg #(.size(1)) bbb(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_write_mux_w_MEM),
			.data_o(ctrl_write_mux_w_WB)
		);
/*
MUX_2to1 #(.size(2)) ccc(
        .data0_i(2'b00),
        .data1_i(ForwardB),
        .select_i(ctrl_write_mux_w_EX),
        .data_o(mux_ccc)
        );
*/
Pipe_Reg #(.size(1)) ID_EX12(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_branch_w),
			.data_o(ctrl_branch_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX13(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_write_w),
			.data_o(ctrl_mem_write_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX14(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_read_w),
			.data_o(ctrl_mem_read_w_EX)
		);
Pipe_Reg #(.size(1)) ID_EX15(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_mux_w),
			.data_o(ctrl_mem_mux_w_EX)
		);





//Instantiate the components in EX stage

ALU ALU(
        .src1_i(mux3to1_a),
	    .src2_i(mux3to1_b),
	    .ctrl_i(alu_control_w),
	    .result_o(alu_result_w),
		.zero_o(alu_zero_w)
	    );

ALU_Ctrl AC(
        .funct_i(sign_extend_w_EX[5:0]),
        .ALUOp_i(ctrl_alu_op_w_EX),
        .ALUCtrl_o(alu_control_w)
        );
MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rf_rt_data_w_EX),
        .data1_i(sign_extend_w_EX),
        .select_i(ctrl_alu_mux_w_EX),
        .data_o(mux_alusrc_w)
        );
MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_w_EX[20:16]),
        .data1_i(instr_w_EX[15:11]),
        .select_i(ctrl_write_mux_w_EX),
        .data_o(mux_write_w)
        );
 Shift_Left_Two_32 Shifter(
        .data_i(sign_extend_w_EX),
        .data_o(shift_left_w)
        );

Adder Adder2(
        .src1_i(add1_result_w_EX),
	    .src2_i(shift_left_w),
	    .sum_o(add2_sum_w)
	    );
Pipe_Reg #(.size(1)) EX_MEM1(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_branch_w_EX),
			.data_o(ctrl_branch_w_MEM)

		);

Pipe_Reg #(.size(1)) EX_MEM2(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_write_w_EX),
			.data_o(ctrl_mem_write_w_MEM)

		);
Pipe_Reg #(.size(1)) EX_MEM3(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_read_w_EX),
			.data_o(ctrl_mem_read_w_MEM)

		);
Pipe_Reg #(.size(1)) EX_MEM4(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_mux_w_EX),
			.data_o(ctrl_mem_mux_w_MEM)

		);
Pipe_Reg #(.size(1)) EX_MEM5(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_register_write_w_EX),
			.data_o(ctrl_register_write_w_MEM)

		);
Pipe_Reg #(.size(32)) EX_MEM6(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(alu_result_w),
			.data_o(alu_result_w_MEM)

		);

Pipe_Reg #(.size(32)) EX_MEM7(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(add2_sum_w),
			.data_o(add2_sum_w_MEM)

		);
Pipe_Reg #(.size(1)) EX_MEM8(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(alu_zero_w),
			.data_o(alu_zero_w_MEM)

		);

Pipe_Reg #(.size(5)) EX_MEM9(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(mux_write_w),
			.data_o(mux_write_w_MEM)

		);
Pipe_Reg #(.size(32)) EX_MEM10(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(rf_rt_data_w_EX),
			.data_o(rf_rt_data_w_MEM)

		);

Pipe_Reg #(.size(32)) EX_MEM11(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(mux3to1_b),
			.data_o(mux3to1_b_MEM)

		);

//Instantiate the components in MEM stage
Data_Memory DataMemory(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.addr_i(alu_result_w_MEM),
		.data_i(rf_rt_data_w_MEM),
		.MemRead_i(ctrl_mem_read_w_MEM),
		.MemWrite_i(ctrl_mem_write_w_MEM),
		.data_o(dataMem_read_w)
		);


Pipe_Reg #(.size(1)) MEM_WB1(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_mem_mux_w_MEM),
			.data_o(ctrl_mem_mux_w_WB)

		);

Pipe_Reg #(.size(1)) MEM_WB2(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(ctrl_register_write_w_MEM),
			.data_o(ctrl_register_write_w_WB)

		);

Pipe_Reg #(.size(32)) MEM_WB3(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(alu_result_w_MEM),
			.data_o(alu_result_w_WB)

		);

Pipe_Reg #(.size(32)) MEM_WB4(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(dataMem_read_w),
			.data_o(dataMem_read_w_WB)

		);

Pipe_Reg #(.size(5)) MEM_WB5(
            .rst_i(rst_i),
			.clk_i(clk_i),
			.data_i(mux_write_w_MEM),
			.data_o(mux_write_w_WB)

		);

//Instantiate the components in WB stage

 MUX_2to1 #(.size(32)) Mux_DataMem_Read(
        .data0_i(alu_result_w_WB),
        .data1_i(dataMem_read_w_WB),
        .select_i(ctrl_mem_mux_w_WB),
        .data_o(mux_dataMem_result_w)
		);

MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(add1_result_w),
        .data1_i(add2_sum_w_MEM),
        .select_i(and_result_w),
        .data_o(mux_pc_result_w)
        );



MUX_3to1 #(.size(32)) Mux3a(
               .data0_i(rf_rs_data_w_EX),
               .data1_i(mux_dataMem_result_w),
			   .data2_i(alu_result_w_MEM),
               .select_i(ForwardA),
               .data_o(mux3to1_a)

        );


MUX_3to1 #(.size(32)) Mux3b(
               .data0_i(mux_alusrc_w),
               .data1_i(mux_dataMem_result_w),
			   .data2_i(alu_result_w_MEM),
               .select_i(ForwardB),
               .data_o(mux3to1_b)

        );

ForwardinUnit  f4din(

.EX_MEMRegWrite(ctrl_register_write_w_MEM),
.MEM_WBRegWrite(ctrl_register_write_w_WB),
.EX_MEMRegisterRd(mux_write_w_MEM),
.MEM_WBRegisterRd(mux_write_w_WB),
.ID_EXRegisterRs(instr_w_EX[25:21]),
.ID_EXRegisterRt(instr_w_EX[20:16]),
.ForwardA(ForwardA),
.ForwardB(ForwardB)

        );
/****************************************
*         Signal assignment             *
****************************************/

endmodule

