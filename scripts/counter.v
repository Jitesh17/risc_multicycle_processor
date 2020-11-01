module counter(clk, enable, count, load);
input clk;
input enable, load;
output [3:0]count;
reg [3:0] count;

always @(posedge clk)
  begin
  if (load)
  count<=4'b1111;
  else if (enable) 
   count <= count + 4'd1;
  else
  count <= count;
  end
endmodule
