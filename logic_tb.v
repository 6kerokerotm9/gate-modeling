`include "prj_definition.v"

module logic_tb;
wire [31:0] Y;
reg [31:0] A;

TWOSCOMP32 compliment(Y, A);

initial
begin
  #5 A = 0;
  /*#5 A = -12;
  #5 A = -8;
  #5 A = 4;
  #5 A = 5;
  #5 A = 37;*/
end
endmodule
