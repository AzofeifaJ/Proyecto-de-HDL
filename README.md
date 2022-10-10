# Proyecto II: Introducción a diseño digital en HDL.

## Integrantes
1. Azofeifa Jiménez Alonso
2. Brenes Espinoza Laura Elena
3. Luna Herrera José David
4. Moya Vargas Austin Joan

## Objetivos
### Objetivo general
Introducir al estudiante al desarrollo de un sistema digital utilizando lenguajes de descripción de hardware.

### Objetivos específicos
1. Elaborar una implementación de un diseño digital en una FPGA.
2. Construir un testbench básico para validar las especificaciones del diseño.
3. Implementar el algoritmo de generación de los códigos de Gray.
4. Coordinación de trabajo en equipo mediante el uso de herramientas de control de versiones.
5. Practicar planificación de tareas para trabajo de grupo.

## Descripción general
Este proyecto consiste en el desarrollo de un circuito decodificador de Gray mediante utilización de Verilog y el suit de herramintas de Vivado, así como la implementación de diseño digital en una FPGA en este caso una NEXYS 4 DD para demostrar su funcionamiento, este proyecto consta de un subsistema de lectura y decodificación de código Gray además de un subsistema de despliegue de código ingresado traducido a formato binario en luces LED y así como un subsistema de despliegue de código ingresado y decodificado en display de 7 segmentos.

## Descripción de cada subsistema
### Subsistema de lectura y decodificación de código Gray
En este primer subsistema el programa traduce la entrada de cuatro conmutadores en código binario a formato del código de gray. La entrada del código es capturada y sincronizada con el sistema principal, para que se realice un muestreo de estos con una  duración de al menos cada 500 ms.

#### Código de gray a binario 
```SystemVerilog
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
```


### Subsistema de despliegue de código ingresado traducido a formato binario en luces LED
En este segundo subsistema se toma los datos ya pasados a código binario y los despliega en cuatro luces LED, además en esta sección se presenta el refrescamiento de las luces al menos cada 500 ms por parte sistema.

#### Código de encendido de leds de la NEXYS 4 y refrescamiento de las luces al menos cada 500 ms
```SystemVerilog

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
```

### Subsistema de despliegue de código decodificado en display de 7 segmentos.
En este stercer subsistema tiene la tasa de refresco para la adecuada visualización, se toma los datos en código binario anteriormente ralizado y se procede a desplegar los dispositivos 7 segmentos disponibles.

### Código decodificado en display de 7 segmentos. 
```SystemVerilog
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
```

## Diagramas de bloques de cada subsistema


## Diagramas de estado de las FSM diseñadas


## Simulación funcional del sistema completo


## Análisis de consumo de recursos en la FPGA


## Reporte de velocidades máximas de reloj posibles en el diseño



## Problemas hallados durante el trabajo

