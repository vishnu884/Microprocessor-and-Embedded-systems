module inst_decoder(
 input [16:0]Instruction_in,
 output reg [2:0]DA, //destination address
 output reg [2:0]AA, //A-register address
 output reg [2:0]BA, //B-register address
 output reg [1:0]BS, //Branch select of Program counter
 output reg PS, //zero toggle i.e toggles between zero and N
 output reg MW, //Memory Write
 output reg RW, //Register write
 output reg MA, //MUX A selection bit
 output reg MB,
 output reg [1:0]MD,
 output reg [3:0]FS, // Function select
 output reg [2:0]SH, //shift number
 output reg CS, //constant Unit
 output reg OE //output enable
);
reg [5:0]opcode;parameter NOP = 5'd0;
parameter ADD= 5'd1;
parameter OUT = 5'd2;
parameter SLT = 5'd3;
parameter AND = 5'd4;
parameter LD = 5'd5;
parameter SBI = 5'd6;
parameter LSL = 5'd7;
parameter IN = 5'd8;
parameter XRI = 5'd9;
parameter ADI = 5'd10;
parameter BZ = 5'd11;
parameter BNZ = 5'd12;
parameter ST = 5'd13;
parameter MOVA = 5'd14;
parameter JMP = 5'd15;
parameter JML = 5'd16;
always@(*) 
begin 
opcode<=Instruction_in[16:12];
//$display(Instruction_in[16:12]);
MD=2'b00; BS=2'b00; PS=1'b0; MW=1'b0; MB=1'b0; MA=1'b0; CS=1'b0; OE=1'b0; DA=Instruction_in[11:9]; AA=Instruction_in[8:6];
case(opcode)
NOP:begin
RW = 1'b0;FS=4'd0;
end
ADD: begin
$display("addcase");
RW = 1'b1; FS=4'b0001; BA=Instruction_in[5:3];
end
OUT:begin
RW = 1'b0; FS = 4'd2; OE = 1'b1; BA=Instruction_in[5:3];
end
SLT:begin
RW=1'b1;MD=2'b10; FS=4'd3; BA=Instruction_in[5:3];
end
AND: begin
RW = 1'b1; FS = 4'd4; OE = 1'b0; BA=Instruction_in[5:3];
end
LD: begin
RW = 1'b1; FS = 4'd5; MD = 2'b01;
end
SBI: begin
RW = 1'b1; FS = 4'd6; BA=Instruction_in[5:3];// immediate
end
LSL: begin
RW = 1'b1; FS = 4'd7; BA=Instruction_in[5:3]; SH=Instruction_in[2:0];
end
IN: begin
RW = 1'b1; FS = 4'd8;
end
XRI: begin
RW = 1'b1; FS = 4'd9; MB = 1'b1; BA=Instruction_in[5:3];
end
ADI: begin
RW = 1'b1; FS = 4'd10; // immediate
end
BZ:begin
RW = 1'b0; FS = 4'd11; BS = 2'b01; MB = 1'b1; CS = 1'b1; DA = 3'b000;
end
BNZ: begin
RW = 1'b0; FS = 4'd12; BS = 2'b01; PS = 1'b1; MB = 1'b1; CS = 1'b1; DA = 3'b000;
end
ST: begin
RW = 1'b0; FS = 4'd0; MW = 1'b1; BA = Instruction_in[5:3];
end
MOVA: begin
RW = 1'b0; FS = 4'd13;//
end
JMP: begin
RW = 1'b0; FS=4'd0; BS = 2'b11; MB = 1'b1; CS = 1'b1; DA = 3'b000; AA = 3'b000; BA = 3'b000;
end
endcase
end
endmodule