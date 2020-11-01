module reg_file(addrA,addrB,addrC,reset,data_write,output_A,output_B,regw,clk);

input [2:0] addrA;
input [2:0] addrB;
input [2:0] addrC;
input [15:0] data_write;
input clk, regw;
input reset;
output [15:0] output_A;
output [15:0] output_B;
reg 	 [15:0] regs_file [7:0];
reg 	 [15:0] output_A;
reg 	 [15:0] output_B;

initial begin
	regs_file [0] <= 16'd0;
	regs_file [1] <= 16'd0;
	regs_file [2] <= 16'd0;//16'b1100_001_010_000001;
	regs_file [3] <= 16'd0;
	regs_file [4] <= 16'h0;
	regs_file [5] <= 16'd0;//r1+4
	regs_file [6] <= 16'd0;
	regs_file [7] <= 16'd0;
end

always @(*)
begin
	output_A <= regs_file[addrA];
	output_B <= regs_file[addrB];
end
	
always @(posedge clk)
begin
	if (regw)
	regs_file[addrC] <= data_write;
	if (reset)
	regs_file[7]     <= 16'd0;
end	

endmodule