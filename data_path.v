// Name: data_path.v
// Module: DATA_PATH
// Output:  DATA : Data to be written at address ADDR
//          ADDR : Address of the memory location to be accessed
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - 32 bit processor implementing cs147sec05 instruction set
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module DATA_PATH(DATA_OUT, ADDR, ZERO, INSTRUCTION, DATA_IN, CTRL, CLK, RST);

// output list
output [`ADDRESS_INDEX_LIMIT:0] ADDR;
output ZERO;
output [`DATA_INDEX_LIMIT:0] DATA_OUT, INSTRUCTION;

// input list
input [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
input CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_IN;

wire [31:0] pc, pc_3, addpc, addpc2, ir_address, pc_sel_1, pc_sel_2, r1_data, r1_result,
	wa_1_result, wa_2_result, wa_3_result, op2_1_res, op2_2_res, op2_3_res, op2_4_res,
	wd_1_res, wd_2_res, wd_3_res, alu_result, r2_data, sp, alu_out, op_1_res, md_1_res,
	ma_1_res, ma_2_res;  
wire CO, zero;  

//PC indexes:
//0: ir_load; 1: pc_load; 2: pc_sel_1; 3: pc_sel_2; 4: pc_sel_3; 5: r1_sel_1; 6: wa_sel_1; 7: wa_sel_2; 8: wa_sel_3
//9: op2_sel_1; 10: op2_sel_2; 11: op2_sel_3; 12: wd_sel_1; 13: wd_sel_2; 14: wd_sel_3; 15: read; 16: write;
//17: sp_load; 18: op1_sel_1; 19: op2_sel_4; 20: md_sel_1; 21-26: alu_oprn; 27: ma_sel_1; 28: ma_sel_2;

//instruction register
REG32 instruction_register(ir_address, DATA_IN, CTRL[0], CLK, RST);

// Program Counter
defparam pc_inst.PATTERN = `INST_START_ADDR;
REG32_PP pc_inst(.Q(pc), .D(pc_3), .LOAD(CTRL[1]), .CLK(CLK), .RESET(RST));
RC_ADD_SUB_32 rc1(addpc, CO, 1, pc, 0);
RC_ADD_SUB_32 rc2(addpc2, CO, addpc, {{16{ir_address[15]}}, ir_address[15:0]}, 0);
mux32_2x1 pc_mux_1(pc_sel_1, r1_data, addpc, CTRL[2]);
mux32_2x1 pc_mux_2(pc_sel_2, pc_sel_1, addpc2, CTRL[3]);
mux32_2x1 pc_mux_3(pc_3, {6'b0, ir_address[25:0]}, pc_sel_2, CTRL[4]);


//store the code into the register
mux32_2x1 r1_sel_1(r1_result, ir_address[25:21], 0, CTRL[5]);
mux32_2x1 wa_sel_1(wa_1_result, ir_address[15:11], ir_address[20:16], CTRL[6]);
mux32_2x1 wa_sel_2(wa_2_result, 0, 31, CTRL[7]);
mux32_2x1 wa_sel_3(wa_3_result, wa_2_result, wa_1_result, CTRL[8]);

mux32_2x1 op2_sel_1(op2_1_res, 1, {27'b0, ir_address[10:6]}, CTRL[9]);
mux32_2x1 op2_sel_2(op2_2_res, {16'b0, ir_address[15:0]}, {{16{ir_address[15]}}, ir_address[15:0]}, CTRL[10]);
mux32_2x1 op2_sel_3(op2_3_res, op2_2_res, op2_1_res, CTRL[11]);

mux32_2x1 wd_sel_1(wd_1_res, alu_result, DATA_IN, CTRL[12]);
mux32_2x1 wd_sel_2(wd_2_res, wd_1_res, {ir_address[15:0], 16'b0}, CTRL[13]);
mux32_2x1 wd_sel_3(wd_3_res, addpc, wd_2_res, CTRL[14]);

REGISTER_FILE_32x32 register_file(r1_data, r2_data, r1_result, ir_address[20:16], 
                            wd_3_res, wa_3_result, CTRL[15], CTRL[16], CLK, RST);

// Stack Pointer
defparam sp_inst.PATTERN = `INIT_STACK_POINTER;
REG32_PP sp_inst(.Q(sp), .D(alu_out), .LOAD(CTRL[17]), .CLK(CLK), .RESET(RST));

//load the alu
mux32_2x1 op1_sel_1(op_1_res, r1_data, sp, CTRL[18]);
mux32_2x1 op2_sel_4(op2_4_res, op2_3_res, r2_data, CTRL[19]);
mux32_2x1 md_sel_1(DATA_OUT, r2_data, r1_data, CTRL[20]);

//ALU
ALU(alu_out, zero, op_1_res, op2_4_res, CTRL[26:21]);

mux32_2x1 ma_sel_1(ma_1_res, alu_out, sp, CTRL[27]);
mux32_2x1 ma_sel_2(ma_2_res, ma_1_res, pc, CTRL[28]);
endmodule



//PC and SP register
module REG32_PP(Q, D, LOAD, CLK, RESET);
parameter PATTERN = 32'h00000000;
output [31:0] Q;

input CLK, LOAD;
input [31:0] D;
input RESET;

wire [31:0] qbar;

genvar i;
generate
for(i=0; i<32; i=i+1)
     begin : reg32_gen_loop
    if (PATTERN[i] == 0)
        REG1 reg_inst(.Q(Q[i]), .Qbar(qbar[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(1'b1), .nR(RESET));
    else
        REG1 reg_inst(.Q(Q[i]), .Qbar(qbar[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(RESET), .nR(1'b1));
    end
endgenerate

endmodule;