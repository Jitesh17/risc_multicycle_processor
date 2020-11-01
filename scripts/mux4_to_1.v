module mux4_to_1(input_a,input_b,input_c,input_d,sel,result);

input [15:0] input_a;
input [15:0] input_b;
input [15:0] input_c;
input [15:0] input_d;
input [1:0] sel;

output [15:0] result;
reg    [15:0] result;

always@(*)
begin
	case(sel)
	2'b00:begin result <= input_a; end
	2'b01:begin result <= input_b; end
	2'b10:begin result <= input_c; end
	2'b11:begin result <= input_d; end
	default: begin result <= 16'b0; end
	endcase
end

endmodule
	
