/* note: 
check with mcu IO (covered in minsys or not) -done
initialize all wires/reg in assign statements - done
check alu (data_branch) etc
look into code after ln 300 (reference code) -done
*/

`include "const_unit.v"
`include "mux.v"
`include "register.v"
`include "inst_decoder.v"
`include "data_hazard.v"
`include "adder.v"
`include "alu.v"
`include "muxD.v"
`include "brancher.v"
`include "br_detect.v"

module cpu(
    input rst,
    input clk,
    input [7:0] cpu_input,
    input [7:0] KB,
    input [7:0] Data_in_DM,
    input [16:0] Inst_in_IM,
    output [7:0] Output_LSB,
    output [7:0] Output_MSB,
    output [7:0] Address_DM,
    output [7:0] Data_out_DM,
    output [7:0] Address_IM
);

reg [16:0]instruction_reg;
reg RW_execute_reg;
reg RW_decode_reg ;
reg [2:0] DA_decode_reg;
reg [7:0] MUX_A_out_reg ;
reg [7:0] MUX_B_out_reg ;
reg MW_reg;
reg [3:0] FS_reg ;
reg [2:0] SH_reg ;
reg[7:0] pc_1_reg;
reg [1:0] BS_reg;
reg[7:0] pc_reg;
reg [2:0] MD_execute_reg; 
reg [7:0] F_out_reg ; 
reg [7:0] data_out_reg ;
reg [7:0] inout_reg;
reg  [1:0] MD_decode_reg;

//inst mem wire
wire [16:0] instruction_wire;
wire [7:0] pc_1_wire;
wire [7:0] pc_2_wire ;
wire RW_execute_wire ;

//const unit wires
wire cs_wire;
wire [7:0] constant_unit_wire;

//muxA wire
wire MA_wire;
wire [7:0] a_data_wire;
wire [7:0] MUX_A_out_wire ;

//register wires
wire [2:0] AA_wire;
wire [2:0] BA_wire;
wire [2:0] DA_wire;
wire [7:0] mux_d_out_wire;
wire [7:0] Data_A_wire;
wire [7:0] Data_B_wire;

//inst decoder wires
wire [2:0] DA_decode_wire;
wire [1:0] BS_decode_wire;
wire PS_wire;
wire MW_wire;
wire RW_decode_wire;
wire MB_wire;
wire [1:0] MD_decode_wire;
wire [3:0] FS_wire;
wire [2:0] SH_wire;
wire OE_wire;

//data Hazard wires
wire DHS_wire;
wire [2:0] MD_execute_wire;
wire [2:0] DA_execute_wire;

//data Memory wire
wire [7:0] data_out_wire ;

//adder wires
reg [7:0] pc_2_reg ;
wire [7:0]BrA_wire;

//alu wires
wire [7:0] F_out_wire;
wire carry_wire;
wire negative_flag_wire;
wire zero_flag_wire;
wire overflow_wire;

//muxC wire
wire [7:0] pc_wire;

//Branch detect wires
wire [1:0]BS_brancher_wire;
wire B_D_wire;

//mux B wires
wire [7:0] MUX_B_out_wire;
wire [7:0] b_data_wire;

assign pc_1_wire = pc_reg + 8'h1;
assign pc_2_wire = pc_1_reg;
assign RW_execute_wire = RW_decode_reg;

constant_unit conn6(
    .immediate_value(instruction_reg[5:0]),
    .cs(cs_wire),
    .constant_unit_out(constant_unit_wire)
);

muxA conn7(
    .MA(MA_wire),
    .PC_minus1(pc_1_reg),
    .register_a(a_data_wire),
    .mux_a_out(MUX_A_out_wire)
);

register conn8(
    .AA(AA_wire),
    .BA(BA_wire),
    .DA(DA_wire),
    .Data_in(mux_d_out_wire),
    .WR(RW_execute_reg),
    .clk(clk),
    .rst(rst),
    .Data_A(Data_A_wire),
    .Data_B(Data_B_wire)
);

inst_decoder conn9(
    .Instruction_in(instruction_reg),
    .DA(DA_decode_wire),
    .AA(AA_wire),
    .BA(BA_wire),
    .BS(BS_decode_wire),
    .PS(PS_wire),
    .MW(MW_wire),
    .RW(RW_decode_wire),
    .MA(MA_wire),
    .MB(MB_wire),
    .MD(MD_decode_wire),
    .FS(FS_wire),
    .SH(SH_wire),
    .CS(cs_wire),
    .OE(OE_wire)
);

data_hazard conn10(
    .AA(AA_wire),
    .BA(BA_wire),
    .DA(DA_decode_reg),
    .RW(RW_decode_reg),
    .MA(MA_wire),
    .MB(MB_wire),
    .DHS(DHS_wire)
);
assign MD_execute_wire = MD_decode_reg;
assign DA_execute_wire = DA_decode_reg;

adder conn12(
.pc(pc_2_reg),
.bus_b(MUX_B_out_reg),
.BrA(BrA_wire));

ALU conn13(
    .FS(FS_reg),
    .SH(SH_reg),
    .A(MUX_A_out_reg),
    .B(MUX_B_out_reg),
    .IN(), //?
    .INK(), //?
    .F(F_out_wire),
    .N(negative_flag_wire),
    .Zero(zero_flag_wire),
    .C(carry_wire),
    .V(overflow_wire),
    .D() //databranch wire?
);

muxD conn14(
    .A(inout_reg),
    .B(data_out_reg),
    .C(F_out_reg),
    .S(MD_execute_reg[1:0]),
    .Y(mux_d_out_wire)
);

brancher conn15(
.BS_in(BS_reg),
.ps(PS_wire),
.z(zero_flag_wire),
.BS_out(BS_brancher_wire));

muxC conn16(
.BS(BS_brancher_wire),
.pc_value(pc_reg),
.RAA(MUX_A_out_reg),
.Braa(BrA_wire)
,.pc_out(pc_wire));

br_detect conn17(
    .BS(BS_brancher_wire),
    .B_D(B_D_wire)
);

/*
muxB conn18 (
.MB(MB_wire),
.constantunit_out(constant_unit_wire),
.register_b(b_data_wire),
.mux_b_out(MUX_B_out_wire));

reg  PS_reg ;
reg [2:0] DA_execute_reg;
reg output_write_enable_reg;

wire DHS;
wire output_write_enable_wire;
wire [7:0] inout_wire;

always @(posedge clk) begin

    if (~rst) begin
        pc_1_reg <= 8'h0;
        instruction_reg <= 17'h0;

        //instruction decode constraint_mode
        pc_2_reg <= 8'h0;
        RW_decode_reg <= 1'h0;
        DA_decode_reg <= 3'h0;
        MD_decode_reg <= 2'h0;
        BS_reg <= 2'h0;
        PS_reg <= 2'h0;
        MW_reg <= 1'h0;
        FS_reg <= 4'h0;
        SH_reg <= 3'h0;
        MUX_A_out_reg <= 8'h0;
        MUX_B_out_reg <= 8'h0;
        output_write_enable_reg <= 1'h0;

        // execution stage 
        RW_execute_reg <= 1'h0;
        DA_execute_reg <= 3'h0;
        MD_execute_reg <= 2'h0;
        F_out_reg <= 8'h0;
        data_out_reg <= 8'h0;
        inout_reg <= 8'h0;

        //  writeback stage 
        //if (reset)
        //pc_reg<=0;
        //else
        pc_reg <= 8'h0;
    end

    else 
    begin
        //  instruction fetch stage 
        if (DHS)
            pc_1_reg <= pc_1_wire;
        //else
        //    pc_1_reg <= pc_1_reg;
            
        if (DHS)
            instruction_reg <= instruction_wire;
        //else
        //  instruction_reg <= instruction_reg;

        //instruction decode constraint_mode
        if (DHS)
            pc_2_reg <= pc_2_wire;
        //else
        //    pc_2_reg <= pc_2_reg;

        RW_decode_reg <= (RW_decode_wire  & B_D_wire &DHS);
        DA_decode_reg <= { DA_decode_wire[2] & DHS & B_D_wire ,  DA_decode_wire[1] & DHS & B_D_wire , DA_decode_wire[0] & DHS & B_D_wire };
        MD_decode_reg <= MD_decode_wire;
        BS_reg <= {BS_decode_wire[1] & DHS & B_D_wire ,   BS_decode_wire[0] & DHS & B_D_wire }     ;                      //&{2 {DHS}} &  {2{ B_D_wire}});   
        PS_reg <= PS_wire;
        MW_reg <= (MW_wire & DHS & B_D_wire);
        FS_reg <= FS_wire;
        SH_reg <= SH_wire;
        MUX_A_out_reg <= MUX_A_out_wire;
        MUX_B_out_reg <= MUX_B_out_wire;
        output_write_enable_reg <= output_write_enable_wire;

        // execution stage 
        RW_execute_reg <= RW_execute_wire;
        DA_execute_reg <= DA_execute_wire ;
        MD_execute_reg <= MD_execute_wire;
        F_out_reg <= F_out_wire;
        data_out_reg <= data_out_wire;
        inout_reg <= inout_wire;

        //  writeback stage 
        //if (reset)
        //pc_reg<=0;
        //else
        if (DHS)
            pc_reg <= pc_wire;
        //else
        //   pc_reg <= pc_reg;
    end
end
*/

endmodule