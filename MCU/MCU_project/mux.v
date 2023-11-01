module muxA(
input MA, // mux a selector lines
input [7:0]PC_minus1,  //pc value from prevous cycle
input [7:0]register_a, //register a value output
output [7:0] mux_a_out  // mux a output value
);
reg [7:0] mux_a;  // register value a out
always@(MA,PC_minus1,register_a)begin

if (MA)
    mux_a = PC_minus1;
else
    mux_a = register_a;
end
assign mux_a_out = mux_a ;
endmodule


module muxB(
input MB, // mux a selector lines
input [7:0]constantunit_out,  //pc value from prevous cycle
input [7:0]register_b, //register a value output
output [7:0]mux_b_out  // mux a output value
);
reg [7:0]mux_b;  // register value a out
always@(MB,constantunit_out,register_b)begin

if (MB)
    mux_b = constantunit_out;
else
    mux_b = register_b;
end
assign mux_b_out = mux_b ;
endmodule


module muxC(
input [1:0] BS, // mux a selector lines
input [7:0] pc_value,  //pc value from prevous cycle
input [7:0] RAA, //register a value output
input [7:0] Braa,
output [7:0] pc_out

);
parameter pc = 2'b00;
parameter jump = 2'b10;
reg [7:0]mux_c;  // mux c  out
always@( BS , pc_value, RAA, Braa)begin

case (BS)  
    pc:
    mux_c = pc_value + 8'h1;
    
    jump:
    mux_c = RAA;
    default:
    mux_c = Braa; 
endcase
end
assign pc_out = mux_c ;
endmodule