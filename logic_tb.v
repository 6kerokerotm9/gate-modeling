`include "prj_definition.v"

module logic_tb;
wire [31:0] Y;
reg [31:0] A;
//wire Q, Qbar;
//reg S, R; 
reg C, nP, nR, L;
//reg D;
wire [31:0] Q;
reg[31:0] D;
//wire [31:0] D;
//reg [4:0] I;

//TWOSCOMP32 compliment(Y, A);
//SR_LATCH sr(Q,Qbar, S, R, C, nP, nR);
//D_LATCH dl(Q, Qbar, D, C, nP, nR);
//D_FF flipflop(Q, Qbar, D, C, nP, nR);
//REG1 register(Q, Qbar, D, L, C, nP, nR);
REG32 register(Q, D, L, C, nR);
//DECODER_2x4 decoder(D,I);
//DECODER_3x8 decoder(D,I);
//DECODER_4x16 decoder(D,I);
//DECODER_5x32 decoder(D,I);

initial
begin
  /*Decoder testing
  #5 I = 5'b1;
  #5 I = 5'b101;
  #5 I = 5'b100;
  #5 I = 5'b1100;
  #5 I = 5'b1101;
  #5 I = 5'b10000;
  #5 I = 5'b10100;
  #5 I = 5'b10011;
  #5 I = 5'b11111;*/
  
  /*register testing*/
  nP = 1; nR = 0; 
  #5 D = 5; L = 1; C = 0;
  #5 C = 1;
  #5 nP = 1; nR = 1; D = 2; L = 1; C = 0;
  #5 C = 1;
  #5 D = 3; L = 0; C = 0;
  #5 C = 1;
  #5 C = 0;
  #5 C = 1; 
  #5 nP = 1; nR = 0; C = 0;
  #5 C = 1;

  /*SR latch testing
  #5 nP = 1; nR = 1; C = 1; S = 1; R = 1;
  #5 C = 1; S = 1; R = 0;
  #5 C = 1; S = 0; R = 0;
  #5 nP = 1; nR = 0; C = 1; S = 1; R = 0;
  #5 nP = 1; nR = 1; C = 1; S = 0; R = 0;
  #5 C = 1; S = 0; R = 1;
  #5 C = 0; S = 1; R = 1;
  #5 C = 1; S = 1; R = 0;
  #5 C = 0; S = 1; R = 0;*/

  /*D latch testing
  #5 nP = 1; nR = 1; C = 1; D = 1; 
  #5 C = 0; D = 0;
  #5 C = 1; D = 0;
  #5 C = 0; D = 0;*/
  
  /*D flip flop testing
  #5 nP = 1; nR = 1; C = 0; D = 1;
  #5 nR = 0; C = 1; D = 0;
  #5 nR = 1; C = 1; D = 1;
  #5 C = 0; D = 0;
  #5 C = 0; D = 1;  
  #5 nP = 1; nR = 0; D = 1; C = 1;
  //#5 nP = 1; nR = 1;  C = 1; D = 1;
  #5 nR = 1; C = 0; D = 1; 
  #5 nP = 0; nR = 1;    
  #5 nP = 1; nR = 1;*/

  /* 2s compliment testing
  #5 A = -12;
  #5 A = -8;
  #5 A = 4;
  #5 A = 5;
  #5 A = 37;*/
end
endmodule
