`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2022 10:57:57
// Design Name: 
// Module Name: disenodigital
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//decodificación del código de gray, de contador binario a código de gray
module binario_a_gray(bin,gray);

input [3:0] bin;
output [3:0] gray;

assign gray[3]=bin[3];
assign gray[2]=bin[3]^bin[2];
assign gray[1]=bin[2]^bin[1];
assign gray[0]=bin[1]^bin[0];

endmodule

//decodificación del código de gray, de contador binario a codigo de gray
module binario_a_gray_tb();

reg [3:0] in;
wire [3:0] outbin, outgray;

binario_a_gray dut1 (.bin(in), .gray(outgray));
binario_a_gray dut2 (.gray(in), .bin(outbin));

initial begin
in=4'b0000;
#10

in=4'b0110;
#10

in=4'b1011;
#10

$stop;
end
endmodule

//encendido de LEDS en la NEXYS4
module disenodigital(
input wire [3:0] sw,
output wire [6:0] a_to_g,
output wire [7:0] an,
output wire dp
    );
 
assign an=8'b11111110; //habilitación de dígitos
assign dp=1; //
hex7seg D1(.x(sw), .a_to_g(a_to_g)); //hexadecimal a 7 segmentos

endmodule




 // función hexadecimal a 7 segmentos
module hex7seg(
    input wire [3:0]x,
    output reg [6:0]a_to_g //conectado de a a g
    );
    
 always@(*)
 begin
 
 //Casos en los interruptores para mostral los números
    case(x)
    0: a_to_g = 7'b0000001;
    1: a_to_g = 7'b1001111;
    2: a_to_g = 7'b0010010;
    3: a_to_g = 7'b0000110;
    4: a_to_g = 7'b1001100;
    5: a_to_g = 7'b0100100;
    6: a_to_g = 7'b0100000;
    7: a_to_g = 7'b0001111;
    8: a_to_g = 7'b0000000;
    9: a_to_g = 7'b0000100;
    'hA: a_to_g = 7'b0001000;
    'hB: a_to_g = 7'b1100000;
    'hC: a_to_g = 7'b0110001;
    'hD: a_to_g = 7'b1000010;
    'hE: a_to_g = 7'b0110000;
    'hF: a_to_g = 7'b0111000;
    default: a_to_g = 7'b0000001;
 endcase
 end endmodule    
    
  
  








