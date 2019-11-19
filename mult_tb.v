`include "prj_definition.v"

module mult_tb;
wire [31:0] HI;
wire [31:0] LO;
reg [31:0] A;
reg [31:0] B;

//MULT32_U mult(HI, LO, A, B);
MULT32 mult(HI, LO, A, B);

initial
begin
  
  #5 A = 5; B = -2;
  #5 A = 10; B = -3;
  #5 A = 5; B = 2;
  #5 A = 12; B = 7;
  #5 A = 10; B = 5;
  #5 A = 8; B = 9;
end
endmodule;