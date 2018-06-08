//Subject:     Architecture project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );

//I/O ports
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;

//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter


//Select exact operation, please finish the following code
always@(funct_i or ALUOp_i) begin
    case(ALUOp_i)
        3'b010:
            begin
                case(funct_i)
                    6'h20: ALUCtrl_o = 4'b0010; // AND
                    6'h22: ALUCtrl_o = 4'b0110; //
                    6'h24: ALUCtrl_o = 4'b0000; //
                    6'h25: ALUCtrl_o = 4'b0001; //
                    6'h2a: ALUCtrl_o = 4'b0111; //
                    default: ALUCtrl_o = 4'b1111;
                endcase
            end
        3'b000:
            begin
                case(funct_i)
                    default: ALUCtrl_o = 4'b0010;
                endcase
            end
        3'b001:
            begin
                case(funct_i)
                    default: ALUCtrl_o = 4'b0110;
                endcase
            end
        3'b011:
            begin
                case(funct_i)
                    default: ALUCtrl_o = 4'b0010;
                endcase
            end
        3'b111:
            begin
                case(funct_i)
                    6'b101010: ALUCtrl_o = 4'b0111; //
                    default: ALUCtrl_o = 4'b0111;
                endcase
            end

        default:begin
        end
    endcase
end
endmodule
