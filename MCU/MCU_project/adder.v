module adder(
input [7:0]pc,
input [7:0]bus_b,
output [7:0]BrA);
assign BrA = pc + bus_b;

endmodule