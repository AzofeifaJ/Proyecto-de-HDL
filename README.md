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



### Subsistema de despliegue de código ingresado traducido a formato binario
en luces LED
Este subsistema toma los datos ya pasados a código binario y los despliega en cuatro luces LED. Este
sistema deberá refrescar las luces al menos cada 500 ms.
### Subsistema de despliegue de código decodificado en display de 7 segmentos.
Este subsistema toma los datos en código binario y los despliega los dispositivos 7 segmentos disponibles
en la placa, de forma decimal. El sistema deberá tener la tasa de refresco adecuada para una visualización
cómoda por parte del usuario.

## Diagramas de bloques de cada subsistema


## Diagramas de estado de las FSM diseñadas


## Simulación funcional del sistema completo


## Análisis de consumo de recursos en la FPGA


## Reporte de velocidades máximas de reloj posibles en el diseño



## Problemas hallados durante el trabajo

