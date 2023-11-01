module brancher(
input [1:0] BS_in,
input ps,
input z,
output [1:0] BS_out);
assign BS_out = {BS_in[1],(BS_in[0]&(BS_in[1]|(ps ^ z)))};
endmodule