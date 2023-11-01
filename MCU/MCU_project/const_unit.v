module constant_unit(
input [5:0] immediate_value,
input cs,
output reg [7:0] constant_unit_out
);
//reg[7:0] constantunit;
//reg[5:0] imm_val
//assign imm_val = immediate_value;
always@(*) begin
if(cs == 1) begin
constant_unit_out = { {2{immediate_value[5]}}, immediate_value};
end else begin
constant_unit_out = { {2{1'b0}}, immediate_value};
end
end
//assign constant_unit_out = constantunit;
endmodule