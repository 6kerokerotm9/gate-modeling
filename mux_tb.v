`include "prj_definition.v"

module mux_tb;
wire[31:0] Y;
reg[31:0] I0, I1, I2, I3, I4, I5, I6, I7;
reg[31:0] I8, I9, I10, I11, I12, I13, I14, I15;
//reg S;
//reg [2:0] S;
reg [3:0] S;

//MUX1_2x1 mux(Y,I0, I1, S);
//MUX32_2x1 mux(Y, I0, I1, S);
//MUX32_4x1 mux(Y, I0, I1, I2, I3, S);
//MUX32_8x1 mux(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
MUX32_16x1 mux(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);

initial
begin
  //#5 I0 = 5; I1 = 0; I2 = 13; I3 = 32;
  //#5 I0 = 5; I1 = 0; I2 = 13; I3 = 32; I4 = 2; I5 = 1; I6 = 45; I7 = 12; S = 0;
  #5 I0 = 0; I1 = 1; I2 = 2; I3 = 3; I4 = 4; I5 = 5; I6 = 6; I7 = 7; I8 = 8; I9 = 9; I10 = 10; I11 = 11; I12 = 12; I13 = 13; I14 = 14; I15 = 15; S = 0;
  #5 S = 3;
  #5 S = 4;
  #5 S = 5;
  #5 S = 7;
  #5 S = 9;
  #5 S = 12;
end
endmodule;