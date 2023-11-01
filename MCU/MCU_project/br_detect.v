module br_detect(input [1:0] BS,
output B_D);

assign B_D = ~(BS[0] | BS [1]);
endmodule