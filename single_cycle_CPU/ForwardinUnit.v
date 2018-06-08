`timescale 1ns / 1ps
/*******************************************************************
 * Create Date: 	2016/05/03
 * Design Name: 	Pipeline CPU
 * Module Name:		ForwardinUnit
 * Project Name: 	Architecture Project_3 Pipeline CPU

 * Please DO NOT change the module name, or your'll get ZERO point.
 * You should add your code here to complete the project 3 (bonus.)
 ******************************************************************/
module ForwardinUnit(EX_MEMRegWrite,MEM_WBRegWrite,EX_MEMRegisterRd,MEM_WBRegisterRd,ID_EXRegisterRs,ID_EXRegisterRt,ForwardA,ForwardB);
input EX_MEMRegWrite,MEM_WBRegWrite;
input [4:0] EX_MEMRegisterRd,MEM_WBRegisterRd,ID_EXRegisterRs,ID_EXRegisterRt;
output reg [1:0] ForwardA,ForwardB;

always@(*)begin

// add your code here


if (EX_MEMRegWrite && (EX_MEMRegisterRd!=0) && (EX_MEMRegisterRd==ID_EXRegisterRs))    ForwardA=2;
else if (MEM_WBRegWrite && (MEM_WBRegisterRd!=0) && (MEM_WBRegisterRd==ID_EXRegisterRs))    ForwardA=1;
else ForwardA=0;

if (EX_MEMRegWrite && (EX_MEMRegisterRd!=0) && (EX_MEMRegisterRd==ID_EXRegisterRt))    ForwardB=2;
else if (MEM_WBRegWrite && (MEM_WBRegisterRd!=0) && (MEM_WBRegisterRd==ID_EXRegisterRt))    ForwardB=1;
else ForwardB=0;

end


endmodule
