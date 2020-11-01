module register(data_in,data_out,clk,w,reset_pin);

input [15:0] data_in;
input clk, reset_pin;
input w;
output [15:0] data_out;
reg [15:0] data_out;
reg [15:0] reg_m;

always@(posedge clk)
begin
   if (reset_pin)
	reg_m <= 16'b0;
	else if (w == 1)
	reg_m <= data_in;
	else 
	reg_m <= reg_m;
end

always @(*)
begin	
	data_out <= reg_m;	
end

endmodule
