`include "prj_definition.v"

module barrel_shifter_tb;
wire [31:0] Y;
reg [31:0] D;
reg [5:0] S;
reg LnR;

//SHIFT32_L left(Y,D,S);
//SHIFT32_R right(Y,D,S);
//BARREL_SHIFTER32 shift(Y,D,S, LnR);
SHIFT32 shift(Y,D,S, LnR);

initial
begin
  #5 D = 32; S = 2; LnR = 0;
  #5 D = 31; S = 0; LnR = 0;
  #5 D = 32; S = 2; LnR = 1;
  #5 D = 15; S = 10; LnR = 1;
  #5 D = 16; S = 4; LnR = 0; 
  #5 D = 16; S = 3; LnR = 1;
  #5 D = 16; S = 32; LnR = 1;
  #5 D = 12; S = 64; LnR = 0;
  /*#5 D = 2; S = 4;
  #5 D = 15; S = 16;*/
end
endmodule; 