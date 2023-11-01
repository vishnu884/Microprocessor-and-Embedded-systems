`include "data_mem.v"
`include "inst_mem.v" 
`include "cpu.v"

module mcu(
    input rst,
    input clk,
    input [7:0] mcu_input,
    input [7:0] KB,
    output [7:0] Output_LSB,
    output [7:0] Output_MSB
);

wire [7:0] Address_DM_wire;
wire [7:0] Data_in_DM_wire;
wire [7:0] Data_out_DM_wire;
wire [7:0] Address_IM_wire;
wire [16:0] Inst_in_wire;
wire data_mem_clk_wire;

data_memoryfile conn(
    //.rst(rst),
    .data_mem_clk(clk),
    .data_mem_address(Address_DM_wire),
    .data_mem_data_in(Data_out_DM_wire),
    .data_mem_wr_rd(rst),
    .data_mem_data_out(Data_in_DM_wire)
);

instruction_memory conn1(
    .addr_in(Address_IM_wire),
    .data_out(Inst_in_wire)
);

cpu conn2(
    .rst(rst),
    .clk(clk),
    .cpu_input(mcu_input),
    .KB(KB),
    .Data_in_DM(Data_in_DM_wire),
    .Inst_in_IM(Inst_in_wire),
    .Output_LSB(Output_LSB),
    .Output_MSB(Output_MSB),
    .Address_DM(Address_DM_wire),
    .Data_out_DM(Data_out_DM_wire),
    .Address_IM(Address_IM_wire)
);


endmodule