module muxD(
 input [7:0] A,
 input [7:0] B,
 input [7:0] C,
 input [1:0] S,
 output reg [7:0] Y
 );
always@(A or B or C or S) begin
 case(S)
 2'b00: Y <= A;
 2'b01: Y <= B;
 2'b10: Y <= C;
 2'b11: Y <= C;
 //if(S==2'b00)
 // Y=A;
 //else if(S==2'b01)
 // Y=B;
 //else Y=C;
 endcase
end
endmodule