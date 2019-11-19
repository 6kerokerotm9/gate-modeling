`include "prj_definition.v"

module mux_tb;
wire[31:0] Y;
reg[31:0] I0, I1;
reg S;

//MUX1_2x1 mux(Y,I0, I1, S);
MUX32_2x1 mux(Y, I0, I1, S);

initial
begin
  #5 I0 = 5; I1 = 0; S = 1;
  #5 S = 0;
end
endmodule;