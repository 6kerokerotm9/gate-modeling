`include "prj_definition.v"

module logic_32_tb;
wire Y;//[31:0] Y;
reg [31:0] A;
reg [31:0] B;

//NOR32_2x1 nor_32(Y,A,B);
//AND32_2x1 and_32(Y,A,B);
//INV32_1x1 inv_32(Y,A);
NOR2x1 nor_32(Y, A);

initial 
begin
  /*#5 A=0; B=0;
  #5 A=0; B=1;
  #5 A=1; B=0;
  #5 A=1; B=1;*/
  //#5 A=5;
  //#5 A=12;
  #5 A=1; 
  #5 A=10;
  #5 A=79;
  #5 A=0;
end
endmodule;