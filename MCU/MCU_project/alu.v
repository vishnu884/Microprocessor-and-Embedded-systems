module ALU(
input [3:0]FS,
input [2:0]SH,
input [7:0]A,
input [7:0]B,
input [7:0]IN,
input [7:0]INK,output reg [7:0]F,
output reg N, //negative
output reg Zero, //zero
output reg C, //carry
output reg V, //V
output reg D);//data_branch
reg [7:0]overflowregister;
// function select
always @(*) begin
case (FS)
4'b0000: F = 8'b0; // No Operation
4'b0001: F = A + B; //ADD
4'b0010: F = B; // Output 2
4'b0011: F = (A<B)?8'b1:8'b0; // Set if Less Than
4'b0100: F = A & B; // AND
4'b0101: F = A; // Load
4'b0110: F = A - B; // Subtract Immediate Unsigned
4'b0111: F = A << SH; // Logical Shift Left;
4'b1000: F = B; // Input
4'b1001: F = A ^ B; // Exclusive-OR Immediate
4'b1010: F = A + B; // Add Immediate
// 4'b1011: F = //branch zero
// 4'b1100: F = //branch non zero
4'b1101: F = A;//store
//4'b1110: F = (FS == 4'b0001) ? A : B;//Move
// 4'b1111: F = //Jump
default: F = 8'b0;
endcase if(F == 4'b0) Zero=1'b1;
else Zero=1'b0; //set Z flagif F is 0
if(F[7] == 1'b1) N=1'b1;
else N=1'b0; //set N status terminal based on MSB
if(F[7] == 1'b1) C=1'b1;
else C=1'b0; //set C if add/sub gives carry
if (FS == 4'b0001) V = ( (A[7] == B[7]) && (A[7] != F[7]));
else if (FS == 4'b1010) V = ( (A[7] == B[7]) && (A[7] != F[7])) ? 1'b1 : 1'b0;
else if(FS == 4'b0110) begin
overflowregister = ~B+8'b1;
V = ( (A[7] == overflowregister[7]) && (A[7] != F[7])) ? 1'b1 : 1'b0;
end
else V=0;
end
endmodule