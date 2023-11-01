module data_memoryfile(
input data_mem_clk,
input [7:0] data_mem_address,
input [7:0] data_mem_data_in,
input data_mem_wr_rd,
output reg [7:0] data_mem_data_out);
 
reg [7:0]data_mem[0:255];
integer i;
initial begin
 data_mem_data_out <=0; //initialising to 0
 for(i = 0; i<=255; i= i+1) begin //iterating through data mem
 data_mem[i] <= i;
 end
end//write cycle

always @(posedge data_mem_clk) begin
//initial begin
 if(data_mem_wr_rd == 1'b1)
 data_mem[data_mem_address]<= data_mem_data_in;
end

//read cycle
always @(posedge data_mem_clk) begin
//initial begin
 if(data_mem_wr_rd == 1'b0)
 data_mem_data_out <= data_mem[data_mem_address];
end

endmodule