//Subject:     Architecture project 2 - Adder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Adder(
    src1_i,
	src2_i,
	sum_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals

wire    [32-1:0]	 sum_o;

//Parameter
    
wire [33-1:0] carry;
    
//Main function


assign carry[0] = 0;


function fa_s(input a, input b, input ci);
   fa_s = a ^ b ^ ci;
 endfunction
 
 function fa_co(input a, input b, input ci);
   fa_co = a & ci | a & b | b & ci;
 endfunction
 
 
     genvar i;
    generate
        for(i=0;i<32;i=i+1)begin:test
            assign sum_o[i]     = fa_s (src1_i[i], src2_i[i], carry[i]);
            assign carry[i+1] = fa_co(src1_i[i], src2_i[i], carry[i]);     
        end
    endgenerate
 
 


endmodule