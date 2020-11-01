module mux2_to_1(input_a,input_b,sel,result);

input [15:0] input_a;
input [15:0] input_b;
input sel;

output [15:0] result;
reg    [15:0] result;

always@(*)
begin
	case(sel)
	0:begin result <= input_a; end
	1:begin result <= input_b; end
	default: begin result <= 16'b0; end
	endcase
end

endmodule
	
