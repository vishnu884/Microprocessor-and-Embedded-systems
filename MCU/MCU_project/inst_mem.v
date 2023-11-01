module instruction_memory( 
input [7:0] addr_in,
output [16:0] data_out);

 //instruction
reg [16:0]inst_mem[0:255];
integer i;
always@(addr_in) begin
data_out = inst_mem[addr_in];
end
initial begin
inst_mem[0] = 17'h00000; //NOP
inst_mem[1] = 17'h02570; //and
inst_mem[3] = 17'h030A4; //mov
inst_mem[4] = 17'h04123; //add
inst_mem[5] = 17'h05732; //sub
end
endmodule