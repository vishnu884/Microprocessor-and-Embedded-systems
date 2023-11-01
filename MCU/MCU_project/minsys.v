`include "mcu.v"
`include "mcu_io.v"

module minsys(
    input clk,
    input rst,
    input EI,
    input [7:0] SW,
    output [9:0] vga_cont,
    input [3:0] Keypad_rows,
    output [3:0] Keypad_cols 
);

wire [7:0] sw_pos_wire;
wire [7:0] Decoded_keyboard_wire;
wire [7:0] Grid_Position_wire;
wire [7:0] Color_wire;

mcu conn3(
    .rst(rst),
    .clk(clk),
    .mcu_input(sw_pos_wire),
    .KB(Decoded_keyboard_wire),
    .Output_MSB(Grid_Position_wire),
    .Output_LSB(Color_wire)
);

mcu_io conn4(
    .clk(clk),
    .rst(rst),
    .Color(Color_wire),
    .Grid_Position(Grid_Position_wire),
    .sw_pos(sw_pos_wire),
    .EIs(EI),
    .SW(SW),
    .vga_cont(vga_cont),
    .Keypad_rows(Keypad_rows),
    .Keypad_cols(Keypad_cols),
    .Decoded_keyboard(Decoded_keyboard_wire)
);

endmodule