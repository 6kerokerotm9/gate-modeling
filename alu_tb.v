`include "prj_definition.v"

module alu_tb;
wire [`DATA_INDEX_LIMIT:0] OUT;
wire ZERO;
reg [`DATA_INDEX_LIMIT:0] OP1; // operand 1
reg [`DATA_INDEX_LIMIT:0] OP2; // operand 2
reg [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code

ALU alu(OUT, ZERO, OP1, OP2, OPRN);

initial
begin
  #5 OP1 = 2; OP2 = 1; OPRN = 2;
  #5 OP1 = 100; OP2 = 79; OPRN = 2;
  #5 OP1 = -12; OP2 = 15; OPRN = 1;
  #5 OP1 = 10; OP2 = 3; OPRN = 1;

end
endmodule
