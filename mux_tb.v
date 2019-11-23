`include "prj_definition.v"

module mux_tb;
wire[31:0] Y;
reg[31:0] I0, I1, I2, I3, I4, I5, I6, I7;
reg[31:0] I8, I9, I10, I11, I12, I13, I14, I15;
reg[31:0] inputs[31:0];
//reg S;
//reg [2:0] S;
reg [4:0] S;

//MUX1_2x1 mux(Y,I0, I1, S);
//MUX32_2x1 mux(Y, I0, I1, S);
//MUX32_4x1 mux(Y, I0, I1, I2, I3, S);
//MUX32_8x1 mux(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
/*MUX32_16x1 mux(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);*/
MUX32_32x1 mux(Y, inputs[0], inputs[1], inputs[2], inputs[3], inputs[4], inputs[5], inputs[6], inputs[7],
	inputs[8], inputs[9], inputs[10], inputs[11], inputs[12], inputs[13], inputs[14], inputs[15], inputs[16], inputs[17],
	inputs[18], inputs[19], inputs[20], inputs[21], inputs[22], inputs[23], inputs[24], inputs[25], inputs[26], inputs[27], inputs[28],
	inputs[29], inputs[30], inputs[31], S);
integer count;
initial
begin
  for(count = 0; count < 32; count = count + 1)
    inputs[count] = count;
  //#5 I0 = 5; I1 = 0; I2 = 13; I3 = 32;
  //#5 I0 = 5; I1 = 0; I2 = 13; I3 = 32; I4 = 2; I5 = 1; I6 = 45; I7 = 12; S = 0;
  #5 S = 3;
  #5 S = 4;
  #5 S = 5;
  #5 S = 7;
  #5 S = 9;
  #5 S = 12;
  #5 S = 27;
  #5 S = 30;
end
endmodule;