module register(
 input [2:0] AA,
 input [2:0] BA,
 input [2:0] DA,
 input [7:0] Data_in,
 input WR,
 input clk,
 input rst,
 output reg [7:0] Data_A,
 output reg [7:0] Data_B
 );
 /*reg [7:0]ALUreg[0:15];
 integer i;
 always@(posedge clk) begin
 //if(rst) begin
 // for(i=0; i<16; i=i+1) begin
 //ALUreg[i]<=0;
 // end
 //end
 if(!rst & WR) begin
ALUreg[DA]<=Data_in;
end
else if(!rst & !WR) begin
Data_A <= ALUreg[AA];
Data_B <= ALUreg[BA];
end
//end
 end*/
 reg [7:0]R0, R1, R2, R3, R4, R5, R6, R7;
 always@(posedge clk) begin
if(!rst & !WR) begin
case(AA)
3'b000: Data_A <= 8'b0;
3'b001: Data_A <= R1;
3'b010: Data_A <= R2;
3'b011: Data_A <= R3;
3'b100: Data_A <= R4;
3'b101: Data_A <= R5;
3'b110: Data_A <= R6;
3'b111: Data_A <= R7;
default: Data_A <= 8'b00000000;
endcase
case(BA)
4'b0000: Data_B <= 8'b00000000;
4'b0001: Data_B <= R1;
4'b0010: Data_B <= R2;
4'b0011: Data_B <= R3;
4'b0100: Data_B <= R4;
4'b0101: Data_B <= R5;
4'b0110: Data_B <= R6;
4'b0111: Data_B <= R7;
default: Data_B <= 8'b00000000;
endcase
end
else if(!rst & WR) begin
case(DA)
3'b000: R0 <= 8'b00000000;
3'b001: R1 <= Data_in;
3'b010: R2 <= Data_in;
3'b011: R3 <= Data_in;
3'b100: R4 <= Data_in;
3'b101: R5 <= Data_in;
3'b110: R6 <= Data_in;
3'b111: R7 <= Data_in;
endcase
end
else if(rst) begin
R0<=8'b00000000;
R1<=8'b0;
R2<=8'b0;
R3<=8'b0;
R4<=8'b0;
R5<=8'b0;
R6<=8'b0;
R7<=8'b0;
end
end
endmodule