//Subject:     Architecture project 3 - MUX 3to1
//--------------------------------------------------------------------------------
//Version:     
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_3to1(
               data0_i,
               data1_i,
			   data2_i,
               select_i,
               data_o
               );

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input   [size-1:0] data2_i;
input   [2-1:0]    select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function
always @(*) begin
	if (select_i == 0)
		data_o = data0_i;
	else if (select_i == 1)
		data_o = data1_i;
	else	
		data_o = data2_i;
end

endmodule      
          
          