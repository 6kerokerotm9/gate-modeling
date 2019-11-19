`include "prj_definition.v"

module barrel_shifter_tb;
wire [31:0] Y;
reg [31:0] D;
reg [5:0] S;

SHIFT32_L left(Y,D,S);

initial
begin
  #5 D = 32; S = 2;
  #5 D = 2; S = 4;
end
endmodule; 