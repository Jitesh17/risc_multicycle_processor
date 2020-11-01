module datapath(clk, count, reset, load, addr1, op_sel, regw, rw, mux_ccr_sel, mux_memw_sel, mux_a_sel, mux_a1_sel, mux_B_sel,mux_adi_sel, mux_alu_sel, mux_mem_sel, mux_reg_sel, mux_pc_sel, mux_pcw_sel, opcode, cz, wa, wb, wmdr, wccr, walu, wir, equal, aorb);  //other control signals from the controller will also be inputs

input clk;
input  [1:0] mux_B_sel;
input mux_ccr_sel,reset;
input [1:0] op_sel;
input [1:0] rw;
input [1:0] load;
input [1:0] mux_alu_sel;
input [1:0] mux_reg_sel;
input [1:0]mux_pc_sel;
input [1:0] mux_pcw_sel;
input [1:0] mux_a_sel;
input mux_a1_sel;
input [2:0] addr1;
input mux_mem_sel, mux_memw_sel;
input wa, wb, wir, wmdr, wccr, walu, regw,aorb, mux_adi_sel;
wire [5:0] addr;
wire [15:0] mux_a_out;
wire [15:0] mux_a1_out;
output [3:0] count;
//output [15:0] reg0;
//output [15:0] reg1;
//output [15:0] reg2;
wire [3:0] count;
wire [15:0] input_A;
wire [15:0] output_A;
wire [15:0] output_B;
wire [15:0] mux_alu_out;
wire [15:0] input_B;
wire [15:0] reg_alu_out;
wire [15:0] reg_ir;
wire [15:0] reg_mdr;
wire [15:0] ccr;
wire [15:0] data_out;
wire [15:0] dw_mux_out;
wire [15:0] mux_ccr_out;
wire [15:0] sign_ext6;
wire [15:0] sign_ext9;
wire [2:0] mux_pc_out;
wire [2:0] mux_pcw_out;
wire [2:0] mux_B_out;
wire [2:0] addrA;
wire [2:0] addrB;
wire [2:0] addrC;
wire [15:0] result;
wire [15:0] flags;
wire [15:0] const1;
wire [2:0] const7;
wire [2:0] adi_out;
wire [15:0] lhi;
wire [15:0] memwr;
wire [15:0] mzero;

assign mzero[1] = (data_out == 0);
assign mzero[0] = ccr[0];
assign addrA = reg_ir[11:9];
assign addrB = reg_ir[8:6];
assign addrC = reg_ir[5:3];
assign lhi[15:7] = reg_ir[8:0];
assign lhi[6:0] = 7'b0;
assign const1 = 16'd1;
assign const7 = 3'd7;
//assign reg0   = input_A;
//assign reg1   = reg_alu_out;
//assign reg2   = reg_mdr;
//assign sign_ext6[15:5] = reg_ir[5];
assign sign_ext6[15] = reg_ir[5];
assign sign_ext6[14] = reg_ir[5];
assign sign_ext6[13] = reg_ir[5];
assign sign_ext6[12] = reg_ir[5];
assign sign_ext6[11] = reg_ir[5];
assign sign_ext6[10] = reg_ir[5];
assign sign_ext6[9] = reg_ir[5];
assign sign_ext6[8] = reg_ir[5];
assign sign_ext6[7] = reg_ir[5];
assign sign_ext6[6] = reg_ir[5];
assign sign_ext6[5] = reg_ir[5];

assign sign_ext6[4:0] = reg_ir[4:0]; 
assign sign_ext9[15] = reg_ir[8];
assign sign_ext9[14] = reg_ir[8];
assign sign_ext9[13] = reg_ir[8];
assign sign_ext9[12] = reg_ir[8];
assign sign_ext9[11] = reg_ir[8];
assign sign_ext9[10] = reg_ir[8];
assign sign_ext9[9] = reg_ir[8];
assign sign_ext9[8] = reg_ir[8];
assign sign_ext9[7:0] = reg_ir[7:0]; 
output equal;
output [15:0] opcode;
output [1:0] cz;
assign cz = ccr[1:0];
assign opcode = reg_ir[15:0];
assign equal = result[0];

alu_risc alu(mux_a_out, mux_alu_out, result, op_sel, flags, aorb);//3bit

reg_file file(mux_pc_out, mux_B_out, mux_pcw_out,reset, dw_mux_out, output_A, output_B, regw, clk);//1bit

register regA(mux_a1_out, input_A, clk, wa, reset);//1
register regB(output_B, input_B, clk, wb, reset);//1
register alu_out(result, reg_alu_out, clk, walu, reset);//1
register IR(data_out, reg_ir, clk, wir, reset);//1
register MDR(data_out, reg_mdr, clk, wmdr, reset);//1
register CCR(mux_ccr_out, ccr, clk, wccr, reset);		//1										//Creedence \m/

memory Mem(memwr, data_out, addr, clk, rw);//1

mux2_to_1 mux_ccr(flags, mzero, mux_ccr_sel, mux_ccr_out);
mux2_to_1 memw(result, output_B, mux_memw_sel, memwr);
mux4_to_1 mux_A(output_A, input_A, reg_alu_out, output_B, mux_a_sel, mux_a_out);
mux2_to_1 mux_A1(mux_a_out, result, mux_a1_sel, mux_a1_out);
mux4_to_1 mux_alu(input_B, sign_ext9, const1, sign_ext6, mux_alu_sel, mux_alu_out);//2
mux4_to_1 mux_reg(reg_alu_out, data_out, lhi, result, mux_reg_sel, dw_mux_out);
mux2_to_1 mux_mem_addr(mux_a_out, reg_alu_out, mux_mem_sel, addr);
mux4_to_1 mux_pc(addrA, const7, addrB , count[3:1], mux_pc_sel, mux_pc_out);
mux4_to_1 mux_B(addrB,count[3:1],const7,,mux_B_sel,mux_B_out);
mux4_to_1 mux_pcw(addrC,const7, count[3:1], adi_out,mux_pcw_sel,mux_pcw_out);
mux2_to_1 mux_adi(addrA, addrB, mux_adi_sel, adi_out);
//counter c( clk, enable, count, load);
Priority_enc p(reg_ir[7:0], count, load, addr1, clk); 
endmodule



