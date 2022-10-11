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
Este proyecto consiste en el desarrollo de un circuito decodificador de Gray mediante utilización de Verilog y el suit de herramintas de Vivado, así como la implementación de diseño digital en una FPGA en este caso una NEXYS 4 ddr para demostrar su funcionamiento, este proyecto consta de un subsistema de lectura y decodificación de código Gray además de un subsistema de despliegue de código ingresado traducido a formato binario en luces LED y así como un subsistema de despliegue de código ingresado y decodificado en display de 7 segmentos.

## Descripción de cada subsistema
### Subsistema de lectura y decodificación de código Gray
En este primer subsistema el programa traduce la entrada de cuatro conmutadores en código binario a formato del código de gray. La entrada del código es capturada y sincronizada con el sistema principal, para que posterior se realice un muestreo de estos con una duración de al menos cada 500 ms. Como se muestra en la imagen a continuación la implementación y la correcta trasformación del Código de Gray de 4 bits a partir de un Código Binario necesario para llevar a cabo este circuito. 

#### Imagen correspondiente al Código Gray de 4 bits que se implementó

![image](https://user-images.githubusercontent.com/111375712/194989182-d70d0202-ddf0-42c4-a5aa-75aeaf40c07f.png)


#### Código binario a de gray 
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
En este segundo subsistema se toma los datos ya pasados a código binario y los despliega en cuatro luces LED, además en esta sección se presenta el refrescamiento de las luces al menos cada 500 ms por parte sistema, en esta sección es importante mencionar que en cuanto al funcionamiento del LED la corriente siempre fluye de ánodo a cátodo, en el cual el ánodo se conecta al voltaje positivo de la fuente y el cátodo se conecta a tierra o al voltaje negativo de la fuente, representado en la siguiente imagen.

#### Imagen correspondiente al encendido de LEDs en NEXYS 4 ddr

![image](https://user-images.githubusercontent.com/111375712/194989319-14fcad98-e482-48d3-ba70-ff9cf3102c89.png)


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

  
module oneHz_generator(
    input clk_100MHz,
    output clk_1Hz
    );
    
    reg [25:0] counter_reg;
    reg cl_reg = 0;
    
    always @(posedge clk_100MHz) begin
        if(counter_reg==49_999_999) begin
            counter_reg <= 0;
            clk_out_reg <= ~clk_out_reg;
        end
        else
            counter_reg <= counter_reg +1;
    end
    
    assign clk_1Hz = clk_out_reg;
    
endmodule 

```

### Subsistema de despliegue de código decodificado en display de 7 segmentos.
En este tercer subsistema tiene la tasa de refresco para la adecuada visualización, se toma los datos en código binario anteriormente ralizado y se procede a desplegar los dispositivos 7 segmentos disponibles, para realziar esta parte es importante mencionar la conexión de los pines a la FPGA de la NEXYS4 ddr la cual es necesaria para asignar el valor al encendido de los 7 segmentos numerados de A a G según corresponda para mostrar cada determinado valor, como se muestra en la imagen a continuación: 

#### Imagen de la distribución de los componentes en la NEXYS 4 ddr
![image](https://user-images.githubusercontent.com/111375712/195011801-afe0480f-6058-425c-bd41-d2c9452f1d77.png)

#### Imagen de la distribución de pines del display de 7 segmentos
![image](https://user-images.githubusercontent.com/111375712/194989472-a5276744-b65a-47e5-b6a7-da2e06bcdfcc.png)

#### Código decodificado en display de 7 segmentos. 
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
 
 
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports dp]
set_property PACKAGE_PIN J15 [get_ports {sw[0]}]
set_property PACKAGE_PIN L16 [get_ports {sw[1]}]
set_property PACKAGE_PIN M13 [get_ports {sw[2]}]
set_property PACKAGE_PIN R15 [get_ports {sw[3]}]
set_property PACKAGE_PIN H15 [get_ports dp]
set_property PACKAGE_PIN T10 [get_ports {a_to_g[0]}]
set_property PACKAGE_PIN R10 [get_ports {a_to_g[1]}]
set_property PACKAGE_PIN K16 [get_ports {a_to_g[2]}]
set_property PACKAGE_PIN K13 [get_ports {a_to_g[3]}]
set_property PACKAGE_PIN P15 [get_ports {a_to_g[4]}]
set_property PACKAGE_PIN T11 [get_ports {a_to_g[5]}]
set_property PACKAGE_PIN L18 [get_ports {a_to_g[6]}]
set_property PACKAGE_PIN J17 [get_ports {an[0]}]
set_property PACKAGE_PIN J18 [get_ports {an[1]}]
set_property PACKAGE_PIN T9 [get_ports {an[2]}]
set_property PACKAGE_PIN J14 [get_ports {an[3]}]
set_property PACKAGE_PIN P14 [get_ports {an[4]}]
set_property PACKAGE_PIN T14 [get_ports {an[5]}]
set_property PACKAGE_PIN K2 [get_ports {an[6]}]
set_property PACKAGE_PIN U13 [get_ports {an[7]}]
```

## Diagramas de bloques de cada subsistema
A continuación se muestra un diagrama de bloques sobre el funcionamiento general del circuito decodificador de Gray, así como un diagrama de bloques para cada subsistema de lectura, con su funcionalidad descrita y su esquema de interconexión, además con el registro de entradas y salidas, sus diagramas de estado y las señales de control de cada bloque en la ruta de datos.

#### Funcionamiento general

![image](https://user-images.githubusercontent.com/111375712/194991462-d48480df-e673-473d-bbab-b547341c9d87.png)


#### Subsistema de lectura y decodificación de código Gray.

![image](https://user-images.githubusercontent.com/111375712/195005241-1a05e60b-4756-47b6-954b-0d69142a000e.png)


#### Subsistema de despliegue de código ingresado traducido a formato binario en luces LED.

![image](https://user-images.githubusercontent.com/111375712/195004091-9a39c866-c90d-4a22-a132-96d8fb429332.png)


#### Subsistema de despliegue de código decodificado en display de 7 segmentos.

![image](https://user-images.githubusercontent.com/111375712/195007538-0d8286cc-44f5-4b85-9f63-f9e1a2d8750e.png)


## Simulación funcional del sistema completo

Realización de las pre-síntesis, mediante la simulaciones a nivel de RTL.
En esta sección se puede detallar las comprobaciones realizadas de los sistemas sobre la NEXYS 4 ddr, las cuales se realizaron por medio de videollamadas entre los integrantes del grupo para observar y realizar el correcto funcionamiento del circuito.

#### Sesiones realizadas entre los integrantes del grupo para visualizar el procedimiento realizado en Verilog para NEXYS 4

![image](https://user-images.githubusercontent.com/111375712/194734261-98dcac3d-816e-41a6-911a-89448dc3df1c.png)


#### Utilización de Verilog para NEXYS 4

![image](https://user-images.githubusercontent.com/111375712/194734288-56ff2af4-d5b1-48fe-a763-d41032d04a6e.png)

![image](https://user-images.githubusercontent.com/111375712/194966269-b75db593-a7e6-476a-a9e0-6353bafa2141.png)


## Problemas hallados durante el trabajo
Durante el presente trabajo se generaron una serie de problemas desde su inicio, los cuales se detallan a continuación: el primer inconveniente se generó al realizar la instalación del programa de Vivado ya que no se pudo utilizar el correo institucional, el problema se solucionó al utilizar el correo personal. Otro inconveniente encontrado fue aprender la correcta utilización de la aplicación Vivado, ya que se encontraban una limitación en cuanto a la cantidad de contenido. Por otro lado, un siguiente problema se produjo durante la codificación de dos subsistemas, lo cuales correspondieron al refrescamiento de las luces al menos cada 500 ms dentro del despliegue de código ingresado traducido a formato binario en luces LED y el subsistema de despliegue de código decodificado en display de 7 segmentos, en cuanto asignar los valores en los segmentos del NEXYS4 ddr, el inconveniente se presentó con la correcta implementación del subsistema, este requirió una mayor inversión de tiempo por parte de los estudiantes, mediante la investigación y la recolección de información para poder realizarse, además se logró solucionar con la ayuda del profesor durante la reunión realizada en la verificación del avance y el cumplimiento del plan de trabajo del proyecto.
