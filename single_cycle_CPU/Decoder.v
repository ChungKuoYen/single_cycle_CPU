//Subject:     Architecture project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemWrite_o,
	MemRead_o,
	MemtoReg_o
	);

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output		   MemWrite_o;
output		   MemRead_o;
output		   MemtoReg_o;

//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg			   MemWrite_o;
reg			   MemRead_o;
reg			   MemtoReg_o;

//Parameter


//Main function
always@(  instr_op_i  ) begin
   if( instr_op_i == 6'h00 )begin
               ALU_op_o = 3'b010;
               ALUSrc_o = 0;
               RegWrite_o = 1;
               RegDst_o = 1;
               Branch_o = 0;
               MemWrite_o = 0;
               MemRead_o = 0;
               MemtoReg_o = 0;
   end
   else if (instr_op_i == 6'h08 )begin
                ALU_op_o = 3'b011;//addi
                  ALUSrc_o = 1;
                  RegWrite_o = 1;
                  RegDst_o = 0;
                  Branch_o = 0;
                  MemWrite_o = 0;
                  MemRead_o = 0;
                  MemtoReg_o = 0;
   end
    else if (instr_op_i == 6'h23 )begin
                    ALU_op_o = 3'b000;//lw
                   ALUSrc_o = 1;
                   RegWrite_o = 1;
                   RegDst_o = 0;
                   Branch_o = 0;
                   MemWrite_o = 0;
                   MemRead_o = 1;
                   MemtoReg_o = 1;
     end
      else if (instr_op_i == 6'h2B )begin
                    ALU_op_o = 3'b000;//sw
                     ALUSrc_o = 1;
                     RegWrite_o = 0;
                     RegDst_o = 0;
                     Branch_o = 0;
                     MemWrite_o = 1;
                     MemRead_o = 0;
                     MemtoReg_o = 0;
       end
        else if (instr_op_i == 6'h04 )begin
                    ALU_op_o = 3'b001;//beq
                       ALUSrc_o = 0;
                       RegWrite_o = 0;
                       RegDst_o = 1;
                       Branch_o = 1;
                       MemWrite_o = 0;
                       MemRead_o = 0;
                       MemtoReg_o = 0;
         end
         else if (instr_op_i == 6'h0A )begin
                         ALU_op_o = 3'b111;//slti
                           ALUSrc_o = 1;
                           RegWrite_o = 1;
                           RegDst_o = 0;
                           Branch_o = 0;
                           MemWrite_o = 0;
                           MemRead_o = 0;
                           MemtoReg_o = 0;
            end


end

endmodule
