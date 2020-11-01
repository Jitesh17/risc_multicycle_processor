module processor(clk, reset_pin, Clock50);
input clk, reset_pin, Clock50;
//output [4:0] s;
//output [15:0] reg0;
//output [15:0] reg1;
//output [15:0] reg2;
//wire [4:0] state;
wire equal;
wire [15:0] opcode;
wire [1:0] cz;
wire [2:0] addr1;
wire [3:0] count;
//wire  enable, load, op_sel, regw, rw, mux_B_sel, mux_alu_sel, mux_mem_sel, mux_reg_sel, mux_pc_sel, mux_pcw_sel, wa, wb, wmdr, wccr, walu, wir, aorb;
//assign s = state;
wire  [1:0]mux_B_sel;
wire [1:0] load;
wire [1:0] op_sel;
wire [1:0] rw;
wire [1:0] mux_alu_sel;
wire [1:0] mux_reg_sel;
wire [1:0]mux_pc_sel;
wire [1:0] mux_pcw_sel;
wire [1:0] mux_a_sel;
wire reset;
wire mux_mem_sel, mux_adi_sel, mux_memw_sel, mux_ccr_sel;
wire wa, wb, wir, wmdr, wccr, walu, regw, aorb;

controller c (clk, count, reset, reset_pin, load, addr1, op_sel, regw, rw, mux_ccr_sel, mux_memw_sel, mux_a_sel, mux_a1_sel, mux_B_sel, mux_adi_sel, mux_alu_sel, mux_mem_sel, mux_reg_sel, mux_pc_sel, mux_pcw_sel, opcode, cz, wa, wb, wmdr, wccr, walu, wir, equal, aorb); 

datapath d (clk, count,  reset, load, addr1, op_sel, regw, rw, mux_ccr_sel, mux_memw_sel, mux_a_sel, mux_a1_sel, mux_B_sel, mux_adi_sel, mux_alu_sel, mux_mem_sel, mux_reg_sel, mux_pc_sel, mux_pcw_sel, opcode, cz, wa, wb, wmdr, wccr, walu, wir, equal, aorb); 

endmodule
