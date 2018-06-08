//Subject:     Architecture project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);

    `define ADD 4'b0010
    `define SUB 4'b0110
    `define AND 4'b0000
    `define OR 4'b0001
    `define SLT 4'b0111


    `define opADDI 4'b0010
    `define opLW 4'b0010
    `define opSW 4'b0010
    `define opSLTI 4'b0111
    `define opBEQ 4'b0110

//I/O ports
input signed  [32-1:0]  src1_i;
input signed  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output signed [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
reg             zero_o;

//Parameter

//Main function
always@(*)begin
case(ctrl_i)
`ADD:begin
result_o = src1_i + src2_i;
zero_o = ~|result_o;
end
`SUB: begin
result_o = src1_i - src2_i;
zero_o = ~|result_o;
end
`AND:begin
result_o = src1_i & src2_i;
zero_o = ~|result_o;
end
`OR:begin
result_o = src1_i | src2_i;
zero_o = ~|result_o;
end
`SLT: begin
result_o = (src1_i < src2_i) ? 1:0;
zero_o = ~|result_o;
end
endcase
end

endmodule
