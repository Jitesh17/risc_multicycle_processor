module Priority_enc(in8, out3, load, addr, clk);

input [7:0] in8;
input [1:0]load;
input clk;
input [2:0] addr;
output [3:0] out3;
reg [3:0] out3;
reg [7:0] in;
always @(*)
begin
	if (in[0] == 1'b1)
	out3 <= 4'd0001;
	else if (in[1] == 1'b1)
	out3 <= 4'b0011;
	else if (in[2] == 1'b1)
	out3 <= 4'b0101;
	else if (in[3] == 1'b1)
	out3 <= 4'b0111;
	else if (in[4] == 1'b1)
	out3 <= 4'b1001;
	else if (in[5] == 1'b1)
	out3 <= 4'b1011;
	else if (in[6] == 1'b1)
	out3 <= 4'b1101;
	else if (in[7] == 1'b1)
	out3 <= 4'b1111;
	else 
	out3 <= 4'd0000;
end

always @(posedge clk)
begin
	if (load == 2'b01)
	in       <= in8;
	else if (load == 2'b00)
	in[out3[3:1]] <= 1'b0;
	else 
	in			<= in;
//	else
//	in       <= in8;
end
	
endmodule
	
	
	
	