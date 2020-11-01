module alu_risc(input_A,input_B,result,op_sel,flags,aorb);

input [15:0] input_A;									
input [15:0] input_B;
input [1:0] op_sel;
input aorb;
output [15:0] result;
output [15:0] flags;
reg  [15:0] result;
reg  [15:0] flags;

wire line1;
assign line1 = (input_A[15]) & (input_B[15]);
always @(*) begin
	case(op_sel)	
		2'b11: 													//Nop
		begin
		flags  <= 16'b0;
		if(aorb)
		result <= input_A;
		else 
		result <= input_B;
		end
		
		2'b00:													//Add
		begin
		result <= input_A + input_B;			
		flags[1] <= (result == 16'b0);
		flags[0] <=  line1 ;
		flags[15:2] = 14'b0;
		end

		2'b01:													//Equality
		begin 
		flags <= 16'b00;		
		result <= (input_A == input_B);		
		end
		
		2'b10:													//NAnd
		begin
		result <= ~(input_A & input_B);
		flags  <= 16'b0;
		end
		
		default:
		begin
		result <= 16'b0;
		flags  <= 16'b0;
		end
	endcase	
end

endmodule
	
	