;**REGISTROS DEL PROCESADOR


;*Registros de 32 bits:=============================
;EAX
;EBX
;ECX
;EDX
;En una instruccion, se pueden usar 21,16 u 8 bits
;==================================================

;Registros de 16 bits:=============================
;AX (16 bits menos significativos de EAX)
;BX (16 bits menos significativos de EBX)
;CX (16 bits menos significativos de ECX)
;DC (16 bits menos significativos de EDX)
;==================================================

;Registros de 8 bits:==============================
;AH (8 bits mas significativos de AX)
;AL (8 bits menos significativos de AX)
;BH (8 bits mas significativos de BX)
;BL (8 bits menos significativos de BX)
;CH (8 bits mas significativos de CX)
;CL (8 bits menos significativos de CX)
;DH (8 bits mas significativos de DX)
;DL (8 bits menos significativos de DX)
;==================================================
;             EAX     AX  
;                  AH     AL
;  ______ ______ ______ ______ 
; |______|______|______|______|
; 31   24 23  16 15   8 7     0

;==================================================


;REGISTROS DE SEGMENTOS============================
;CS (de codigo) - indica el segmento donde estan las instrucciones
;DS (de datos)  - indica el segmento donde estan las variables
;SS (de stack)  - indica el segmento donde esta el stack
;ES (de string o general) - para segmentos definidos por usuario
;==================================================


;*INSTRUCCIONES DE TRANSFERENCIA DE DATOS (no afectan flags)
;move dest,src
    ;Codpia el contenido del operando fuente (src) en el destino (dest)
    ;Operacion: dest <-- src
    ;Las posibilidades son:
;mov reg,{reg|mem|inmed}
;mov mem,{red|inmed}
;mov {reg16|mem16},{CS|DS|ES|SS}
;mov {DS|ES|SS},{red16|mem16}
;==================================================

;*INSTRUCCIONES DE TRANSFERENCIA DE DATOS (no afectan flags)
;PUSH src
    ;Pone el valor en el topo del stack
    ;Operacion: SP <-- SP - 2, [SP+1:SP] <-- src
    ;donde src = {reg16|mem16|reg32|mem32|CS|DC|ES|SS}
;POP dest 
    ;Retira el valor del topo del stack poniendolo en un lugar indicado
    ;Operacion: dest <-- [SP+1:SP], SP <-- SP + 2
    ;donde dest = {reg16|mem16|reg32|mem32|DE|ES|SS}

;LAHF
    ;Copia en el registro AH la imagen de los ocho bits menos significativos del registro 
    ;de indicadores
    ;Operacion: AH <-- SF:ZF:X:AF:X:PF:X:CF
;SAHF
    ;Almacena en los ocho bits menos dignificativos del registro de indicadores el valor d
    ;el registro AH
    ;Operacion: SF:ZF:X:AF:X:PF:CF <-- AH

;PUSHF
    ;Almacena los flags en la pila
    ;Operacion: SP <-- SP - 2, [SP+1:SP] <-- Flags    
;POPF
    ;Pone en los flags el valor que hay en la pila
    ;Operacion: Flags <-- [SP+1:SP], SP <-- SP + 2
;==================================================


;*FLAGS
;CF - Carry flag
    ;Se setea si una operacion arimetica genera carry, Indica overflow para aritmetica de 
    ;enteros sig signo.

;PF - Parity flag
    ;Se setea si el byte menos significativo del resultado contieie un numero par de bits 1.

;ZF -Zero flag
    ;Se setea si el resultado es cero.

;SF - Sign flag
    ;Se setea igual al bit mas significativo del resultado, que es el bit de signo de un entero 
    ;con signo (0 indica un valor positivo y 1 indica un valor negativo).

;OF - Overflow flag
    ;Se setea si un entero es demasiado grande para el numero de positivos o demasiado pequeno 
    ;para numeros negativos (Excluyendo el bit
    ;de signo) para entrar en el operando destino.
    ;Indica una condicion de overflow para aritmetica de enteros con signo.
;==================================================

;*INSTRUCCIONES ARITMETICAS
;(Afectan los flags AF, CF, OF, PF, SF, ZF)

;ADD Dest,src
    ;Operacion: dest <-- dest + src

;ADC dest,src
    ;Operacion: dest <-- src + CF

    ;Donde dest = {reg|mem} y src = {reg|mem|inmed}
    ;no pudiendo ambos operadores estar en memoria

;CMP dest,src
    ;Operacion: dest - src (Solo afecta flags)

    ;Donde dest = {reg|mem} y src = {reg|mem|inmed}
    ;no pudiendo ambos operadores estar en memoria

;IMUL dest,src
    ;donde dest = {reg} y src = {reg|mem|inmed}

;Operadores de 8 bits - dest debe ser AL
    ;Realiza una multiplicación con operandos con signo de 8 
    ;por 8 bits.El resultado tendrá 16 bits.  
	;Operación: AX  AL * {reg8|mem8|inmed} realizando la multiplicación 
    ;con signo. CF = OF = 0 si el resultado entra en un byte, en caso contrario 
    ;valdrán 1. AF, PF, SF, ZF quedan indefinidos.

;Operadores de 16 bits - dest debe ser AX
    ;Realiza una multiplicación con operandos con signo de 16 por 16 bits.El resultado tendrá 32 bits.
	;Operación: DX:AX  AX * {reg16|mem16|inmed} realizando la multiplicación con signo. CF = OF = 0 si 
    ;el resultado entra en dos bytes, en caso contrario valdrán 1. AF, PF, SF, ZF quedan indefinidos.

;Operadores de 32 bits - dest debe ser EAX
    ;Realiza una multiplicación con operandos con signo de 32 por 32 bits.El resultado tendrá 64 bits.
	;Operación: EDX:EAX  EAX * {reg32|mem32|inmed}  realizando la multiplicación con signo. CF = OF = 0 
    ;si el resultado entra en cuatro bytes, en caso contrario valdrán 1. AF, PF, SF, ZF quedan indefinidos

;*INSTRUCCIONES ARITMETICAS

;DIV oper  
;	donde oper = {reg|mem} 

;Operando de 8 bits no signado
;	El dividendo debe estar en AX. El resultado tendrá 8 bits.  
;	Cociente en AL. Resto en AH.

;Operando de 16 bits no signado
;	El dividendo debe estar en DX:AX. El resultado tendrá 16 bits.  
;	Cociente en AX. Resto en DX.

;Operando de 32 bits no signado
;	El dividendo debe estar en EDX:EAX. El resultado tendrá 32 bits.  
;	Cociente en EAX. Resto en EDX.

;IDIV oper  
	;donde oper = {reg|mem} 
;Operando de 8 bits con signo
	;El dividendo debe estar en AX. El resultado tendrá 8 bits.  
	;Cociente en AL. Resto en AH.
;Operando de 16 bits con signo
	;El dividendo debe estar en DX:AX. El resultado tendrá 16 bits.  
	;Cociente en AX. Resto en DX.
;Operando de 32 bits con signo
	;El dividendo debe estar en EDX:EAX. El resultado tendrá 32 bits.  
	;Cociente en EAX. Resto en EDX.

;CBW
	;Extiende el signo de AL en AX. No se afectan los flags.
;CWD
	;Extiende el signo de AX en DX:AX. No se afectan flags.
;CWDE
	;Extiende el signo de AX en EAX. No se afectan flags.
;CDQ
	;Extiende el signo de EAX en EDX:EAX. No se afectan flags.


;*INSTRUCCIONES ARITMETICAS
;(Afectan los flags AF, CF, OF, PF, SF, ZF)
;AND dest,src
    ;Operación: dest  dest and src.
;TEST dest,src
    ;Operación: dest and src. Sólo afecta flags.
;OR dest,src
    ;Operación: dest  dest or src.
;XOR dest,src
    ;Operación: dest  dest xor src.
	;Las cuatro instrucciones anteriores ponen CF = OF = 0, AF queda indefinido y PF, SF y ZF dependen 
    ;del resultado.

;=====================================================================

;Instrucciones de transferencia de control (no afectan los flags

;JMP label
    ;Saltar hacia la dirección label. 

;=======================================================================


;*Saltos condicionales aritméticos (usar después de CMP) 

;Aritmética signada (con números positivos, negativos y cero)
;JL etiqueta /JNGE etiqueta
    ;Saltar a etiqueta si es menor.

;JLE etiqueta /JNG etiqueta
    ;Saltar a etiqueta si es menor o igual.

;Aritmética signada (con números positivos, negativos y cero)
;JE etiqueta
    ;Saltar a etiqueta si es igual.

;JNE etiqueta
    ;Saltar a etiqueta si es distinto

;Aritmética signada (con números positivos, negativos y cero)
;JGE etiqueta /JNL etiqueta
    ;Saltar a etiqueta si es mayor o igual.

;JG etiqueta /JNLE etiqueta
    ;Saltar a etiqueta si es mayor    

;Aritmética sin signo (con números positivos y cero)
;JB etiqueta /JNAE etiqueta
    ;Saltar a etiqueta si es menor.

;JBE etiqueta /JNA etiqueta
    ;Saltar a etiqueta si es menor o igual.

;Aritmética sin signo (con números positivos y cero)
;JE etiqueta
    ;Saltar a etiqueta si es igual.

;JNE etiqueta
    ;Saltar a etiqueta si es distinto.

;Aritmética sin signo (con números positivos y cero)
;JAE etiqueta/JNB etiqueta
    ;Saltar a etiqueta si es mayor o igual.

;JA etiqueta/JNBE etiqueta
    ;Saltar a etiqueta si es mayor.

;=======================================================================

;*Saltos condicionales según el valor de los indicadores:

;JC label
    ;Saltar si hubo arrastre/préstamo (CF = 1).

;JNC label
    ;Saltar si no hubo arrastre/préstamo (CF = 0).

;JZ label
    ;Saltar si el resultado es cero (ZF = 1).

;JNZ label
    ;Saltar si el resultado no es cero (ZF = 0).

;JS label
    ;Saltar si el signo es negativo (SF = 1).

;JNS label
    ;Saltar si el signo es positivo (SF = 0).

;Aritmética signada (con números positivos, negativos y cero)
;JO label
    ;Saltar si hubo desbordamiento (OF = 1).

;JNO label
    ;Saltar si no hubo desbordamiento (OF = 0).

;================================================================================

;*Directivas (Instrucciones para el ensamblador)

;Definición de datos

;Ubica memoria para un ítem de datos y opcionalmente asocia un nombre simbólico con esa 
;dirección de memoria y/o genera 
;el valor inicial para ese ítem.

;[nombre] DB valor_inicial [, valor_inicial...]
    ;donde valor_inicial puede ser una cadena o una expresión numérica cuyo resultado esté 
    ;entre -255 y 255.
	;Define datos de 8 bits (1 byte)

;[nombre] DW valor_inicial [, valor_inicial...]
    ;Define datos de 16 bits (2 bytes)

;[nombre] DD valor_inicial [, valor_inicial...]
    ;Define datos de 32 bits (4 bytes)

;[nombre] DQ valor_inicial [, valor_inicial...]
    ;define datos de 64 bits (8 bytes)

;[nombre] DT valor_inicial [, valor_inicial...]
    ;define datos de 80 bits (10 bytes)

;[nombre] DS nro_de_bytes
	;define datos de nro. de bytes

;Definición de datos

;Si se desea que no haya valor inicial, deberá utilizarse el símbolo ?.

;Otra forma de expresar el valor inicial es:
;cuenta DUP (valor_inicial [, valor_inicial...]) 
;donde cuenta es la cantidad de veces que debe repetirse lo que está entre paréntesis.

;============================================================================


;*Control del ensamblador 

;END [etiqueta]: Debe ser la última sentencia del código fuente. La etiqueta indica dónde 
;debe comenzar la ejecución del programa. 
;Si el programa se compone de varios módulos, sólo el módulo que contiene la dirección de 
;arranque del programa debe contener la directiva 
;END etiqueta. 

;Los demás módulos deberán terminar con la directiva END (sin etiqueta).

;===================================================================================

;*Estructura de un programa 

.MODEL small 		; Indica el tamaño de programa
.STACK 200h 		; Inicializa Stack en dir. indicada

.DATA   			; Indica zona de datos
	; Aquí se definen variables y datos

.CODE 		    	; Indica inicio zona de código
	; Aquí viene el código

START: 		        ; Label que indica inicio del “main” 	
	mov 	ax,@data	; Mueve a ds la dirección del segmento de datos
	mov 	ds,ax		; utilizando el reg. ax como intermediario
	…
	mov     ah,4ch      	; DOS: termina el programa
	mov     al,0             	; el código de retorno será 0
	int     21h              	; termina el programa
END START


;==================================================================================

;Emisión de Mensajes 

.MODEL small 		
.DATA 			
	Mensaje DB 'Esto es un mensaje$'
.CODE 			
START: 
	;…
	mov	 dx,OFFSET Mensaje
	mov	 ah,9
	int  21h
	;…
	mov   ah,4ch      	; DOS: termina el programa
	mov   al,0          ; el código de retorno será 0
	int   21h           ; termina el programa
END START

;===============================================================================

;*El coprocesador matemático 80X87
;Diseño de Compiladores I
;Cursada 2009

;Introducción 
;El coprocesador aritmético 80X87 aumenta el juego de instrucciones del 80X86 mejorando su 
;capacidad de tratamiento de números. 
;Se utiliza como procesador paralelo junto al 80X86 añadiendo 8 registros de punto flotante 
;de 80 bits así como instrucciones adicionales. 

;Registros=========
;;Los ocho registros se organizan como una pila. 

;Los nombres de los registros son ST(0), ST(1), 
;ST(2), ..., ST(7). El nombre simbólico ST (Stack Top) 
;es equivalente a ST(0). 

;Al poner un número en la pila, ST(0) contendrá el 
;número recién ingresado, ST(1) será el valor 
;anterior de ST(0), ST(2) será el valor anterior de 
;ST(1), y así sucesivamente, con lo que se perderá 
;el valor anterior de ST(7). 

;=======================

;Juego de instrucciones del 80X87

;Instrucciones de transferencia de datos

;FLD mem
	;Introduce una copia de mem en ST. La fuente debe ser un número real en punto flotante de 
    ;4, 8 ó 10 bytes. Este operando se transforma automáticamente al formato real temporal.

;FLD ST(num)
	;Introduce una copia de ST(num) en ST.

;FILD mem 
	;Introduce una copia de mem en ST. La fuente debe ser un operando de memoria de 2, 4 u 8 
    ;bytes, que se interpreta como un número entero y se convierte al formato real temporal.

;FST mem
	;Copia ST a mem sin afectar el puntero de pila. El destino puede ser un operando real de 
    ;4, 8 o 10 bytes.

;FST ST(num) 
	;Copia ST al registro especificado.

;FIST mem 
	;Copia ST a mem. El destino debe ser un operando de 2, 4 u 8 bytes y se convierte automáticamente 
    ;el número en formato temporal real a entero.

;FSTP mem
	;Extrae una copia de ST en mem. El destino puede ser un operando de memoria de 4, 8 ó 10 bytes, 
    ;donde se carga el número en punto flotante.

;FSTP ST(num)
	;Extrae ST hacia el registro especificado.

;FISTP mem
	;Extrae una copia de ST en mem. El destino debe ser un operando de memoria de 2, 4 u 8 bytes 
    ;y se convierte automáticamente el número en formato temporal real a entero.

;FXCH
	;Intercambia ST(1) y ST.

;FXCH ST(num)
	;Intercambia ST(num) y ST.


;*Instrucciones de carga de constantes

;FLDZ
	;Introduce el número cero en ST.

;FLD1
	;Introduce el número uno en ST.
;FLDPI
	;Introduce el valor de pi en ST.


;*Instrucciones aritméticas

;FADD
	;Hace ST(1) más ST, ajusta el puntero de pila y pone el resultado en ST, por lo que ambos 
    ;operandos se destruyen.

;FADD mem
	;Hace ST  ST + [mem]. En mem deberá haber un número real en punto flotante.

;FIADD mem 
	;Hace ST  ST + [mem]. En mem deberá haber un número entero en complemento a dos.

;FADD ST(num), ST
	;Realiza ST(num)  ST(num) + ST.

;FADD ST, ST(num)
	;Realiza ST  ST + ST(num).

;FADDP ST(num), ST
	;Realiza ST(num)  ST(num) + ST y retira el valor de ST de la pila, con lo que ambos 
    ;operandos se destruyen.

;FSUB
	;Hace ST(1) menos ST, ajusta el puntero de pila y pone el resultado en ST, por lo que 
    ;ambos operandos se destruyen.

;FSUB mem
	;Hace ST  ST - [mem]. En mem deberá haber un número real en punto flotante.

;FISUB mem
	;Hace ST  ST - [mem]. En mem deberá haber un número entero en complemento a dos.

;FSUB ST(num), ST
	;Realiza ST(num)  ST(num) - ST.

;FSUB ST, ST(num)
	;Realiza ST  ST - ST(num).

;FSUBP ST(num), ST
	;Realiza ST(num)  ST(num) - ST y retira el valor de ST de la pila, con lo que ambos
    ;operandos se destruyen.

;FSUBR
	;Hace ST menos ST(1), ajusta el puntero de pila y pone el resultado en ST, por lo que 
    ;ambos operandos se destruyen.

;FSUBR mem
	;Hace ST  [mem] - ST. En mem deberá haber un número real en punto flotante.

;FISUBR mem
	;Hace ST  [mem] - ST. En mem deberá haber un número entero en complemento a dos. 

;FSUBR ST(num), ST
	;Realiza ST(num)  ST - ST(num).

;FSUBR ST, ST(num)
	;Realiza ST  ST(num) - ST.

;FSUBRP ST(num), ST
	;Realiza ST(num)  ST - ST(num) y retira el valor de ST de la pila, con lo que ambos 
    ;operandos se destruyen.

;FMUL
	;Multiplicar el valor de ST(1) por ST, ajusta el puntero de pila y pone el resultado en 
    ;ST, por lo que ambos operandos se destruyen.

;FMUL mem
	;Hace ST  ST * [mem]. En mem deberá haber un número real en punto flotante.

;FIMUL mem
	;Hace ST  ST * [mem]. En mem deberá haber un número entero en complemento a dos.

;FMUL ST(num), ST
	;Realiza ST(num)  ST(num) * ST.

;FMUL ST, ST(num)
	;Realiza ST  ST * ST(num).

;FMULP ST(num), ST
	;Realiza ST(num)  ST(num) * ST y retira el valor de ST de la pila, con lo que ambos 
    ;operandos se destruyen.

;FDIV
	;Dividir el valor de ST(1) por ST, ajusta el puntero de pila y pone el resultado en ST, 
    ;por lo que ambos operandos se destruyen.

;FDIV mem
	;Hace ST  ST / [mem]. En mem deberá haber un número real en punto flotante.

;FIDIV mem
	;Hace ST  ST / [mem]. En mem deberá haber un número entero en complemento a dos.

;FDIV ST(num), ST
	;Realiza ST(num)  ST(num) / ST.

;FDIV ST, ST(num)
	;Realiza ST  ST / ST(num).

;FDIVP ST(num), ST
	;Realiza ST(num)  ST(num) / ST y retira el valor de ST de la pila, con lo que ambos 
    ;operandos se destruyen.

;FDIVR
	;Hace ST dividido ST(1), ajusta el puntero de pila y pone el resultado en ST, por lo que 
    ;ambos operandos se destruyen.

;FDIVR mem
	;Hace ST  [mem] / ST. En mem deberá haber un número real en punto flotante.

;FIDIVR mem
	;Hace ST  [mem] / ST. En mem deberá haber un número entero en complemento a dos.

;FDIVR ST(num), ST
	;Realiza ST(num)  ST / ST(num).

;FDIVR ST, ST(num)
	;Realiza ST  ST(num) / ST.

;FDIVRP ST(num), ST
	;Realiza ST(num)  ST / ST(num) y retira el valor de ST de la pila, con lo que ambos 
    ;operandos se destruyen.

;FABS
	;Pone el signo de ST a positivo (valor absoluto).

;FCHS
	;Cambia el signo de ST.

;===========================================

;*Control del flujo del programa

;FCOM
	;Compara ST y ST(1).

;FCOM ST(num)
	;Compara ST y ST(num).

;FCOM mem
	;Compara ST y mem. El operando de memoria deberá ser un número real.

;FICOM mem
	;Compara ST y mem. El operando deberá ser un número entero.

;FTST
	;Compara ST y cero.

;FCOMP
	;Compara ST y ST(1) y extrae ST fuera de la pila.

;FCOMP ST(num)
	;Compara ST y ST(num) y extrae ST fuera de la pila.

;FCOMP mem
	;Compara ST y mem y extrae ST fuera de la pila. El operando de memoria deberá ser un 
    ;número real.

;FICOMP mem
	;Compara ST y mem y extrae ST fuera de la pila. El operando deberá ser un número entero.

;FCOMPP
	;Compara ST y ST(1) y extrae dos elementos de la pila, perdiéndose ambos operandos.

;==========================================

;Instrucciones de transferencia de datos de control

;FLDCW mem2byte
	;Carga la palabra de control desde la memoria.

;FSTCW mem2byte
	;Almacena la palabra de control en la memoria.

;FSTSW mem2byte
	;Almacena la palabra de estado en la memoria.

;============================================

;*Control del Procesador

;F[N]INIT
	;Inicializa el coprocesador y restaura todas las condiciones iniciales en las palabras 
    ;de control y de estado. Es una buena idea utilizar esta instrucción al principio y al final del programa. 

;F[N]CLEX
	;Pone a cero los indicadores de excepción y el indicador de ocupado de la palabra de 
    ;estado. También limpia el indicador de pedido de interrupción del 8087.

;FREE ST(num)
	;Marca el registro especificado como vacío.

;FNOP
	;Copia ST a sí mismo tomando tiempo de procesamiento sin tener ningún efecto en registros 
    ;o memoria. 

;==================================================

;*Conversiones 
;Diseño de Compiladores I
;Cursada 2009

;*Sin signo – Sobre registros
;_______________________________________________________
;Conversion      |   Dato  |  Instrucciones   resultado
;-------------------------------------------------------
;8 a 18 bits     |   BL    |  mov BH, 0        BX
;-------------------------------------------------------
;16 a 32 bits    |   BX    |  mov ECX, 0       EBX
;                |         |  mov CX, BX
;                |         |  mov EBX, ECX
;-------------------------------------------------------
;32 a 64 bits    |   EAX   |  mov EDX, 0       EDX:EAX
;Para            |         |
;Multitplicacion |         |
;y division      |         |
;-------------------------------------------------------



;=========================================================

;*Sin signo – Sobre memoria

;_______________________
;Datos     |  tramano 
;-----------------------
;D1   DB ? | 8 bits
;D2   DW ? | 16 bits
;D4   DD ? | 32 bits
;D8   DQ ? | 64 bits
;D10  DT?  | 80 bits
;-----------------------

;_______________________________________________________
;Conversion  Dato    Instrucciones   resultado
;--------------------------------------------------------
;6 bist      D1      MOV AL, D1        D2  D2+1
;                    MOV D2, AL        -----|----
;                    MOV AL, 0       D2| D1 | 0 |
;                    MOV D2 + 1, AL    ----------
;--------------------------------------------------------
;32 bits     D2      MOV AX, D2         D4    D4+2 
;                    MOV D4, AX         --------------
;                    MOV AX, 0        D4|  D2  |  0  |    
;                    MOV D4 + 2, AX     --------------
;--------------------------------------------------------
;64 bits     D4      MOV EAX, D4        D8        D8+4
;                    MOV D4,EAX         ----------------------
;                    MOV EAX, 0       D8|    D4    |    0    |
;                    MOV D8 + 4, EAX    ----------------------
;--------------------------------------------------------


;Sin signo – Sobre registros
;(con control de overflow)
;_______________________________________________________
;Conversion     Dato    Instrucciones   Resultado
;-------------------------------------------------------
;16 a 8 bits    AX         CMP AH,0     BL
;                          JNZ ERROR
;                          MOV BL,AL
;                       ERROR:
;                          ...
;-------------------------------------------------------
;32 a 16 bits   EAX        MOV EBX, 0   CX
;                          MOV BX, AX
;                          CMP EAX, EBX
;                          JNE ERROR
;                          MOV CX, AX
;                        ERROR:
;                          …
;--------------------------------------------------------



;Sin signo – Sobre memoria
;(con control de overflow)
;_______________________________________________________
;Conversion     Dato   Instrucciones    Resultado
;--------------------------------------------------------
;16 a 8 bits    D2       MOV AL,D2+1    D1
;                        CMP AL,0
;                        JNE ERROR
;                        MOV AL,D2   
;                        MOV D1,AL
;                     ERROR:
;                        ...
;--------------------------------------------------------
;32 a 15 bits   D4       MOV AX,D4+2     D2
;                        CMP AX,0
;                        JNE ERROR
;                        MOV AX,D4
;                        MOV D2,AX
;                     ERROR:
;                        ...
;--------------------------------------------------------


;Con signo 
;(datos enteros)
;_______________________________________________________
;Conversion    Dato    Instrucciones    Resultado
;--------------------------------------------------------
;8 a 16 bits   CL      MOV AL,CL        AX 
;                      CBW
;--------------------------------------------------------
;16 a 32 bits  BX      MOV AX,BX        DX:AX 
;                      CWD 
;--------------------------------------------------------
;16 a 32 bits  DX      MOV AX,DX        EAX 
;                      CWDE 
;--------------------------------------------------------
;32 a 64 bits  EBC     MOV EAX,EBX      EDX:EAX
;                      CDQ
;--------------------------------------------------------




;_______________________________________________________
;Conversion        Dato    Instrucciones     Resultado
;--------------------------------------------------------
;32 a 64 bits      ECX        MOV EAX,ECX     EDX : EAX
;Para                         CMP EAX,0
;multiplicaciones             JL NEGATIVO
;y divisiones                 MOV EDX,0
;                          NEGATIVO:
;                             MOV EDX,-1
;                          SIGO:
;                             ...
;--------------------------------------------------------


;Con signo 
;(datos enteros con control de overflow)
;______________________________________________________________ 
;Conversion    Dato      Instrucciones                Resultado
;---------------------------------------------------------------
;16 a 8 bits   AX      CMP AX, 0       NEGATIVO:      AL
;                        JL NEGATIVO     CMP AH, -1  
;                        CMP AH, 0       JNE ERROR 
;                        JNE ERROR       CMP AL, 0
;                        CMP AL, 0       JG ERROR 
;                        JL ERROR      ERROR:  
;                        JMP SIGO        ...
;                                      SIGO:
;                                        ...
;--------------------------------------------------------


;Datos flotantes  
;(Registro a Memoria)
;_______________________________________________________
;Conversion     Dato    Instrucciones   Resultado
;--------------------------------------------------------
;80 a 32 bits   ST(0)   FST D4 O        D4 (32 bits) 
;64 a 32 bits           FSTP D4 
;--------------------------------------------------------
;80 a 64 bits   ST(0)   FST D8 O        D8 (64 bits)
;32 a 64 bits           FSTP D8 
;--------------------------------------------------------
;64 a 80 bits   ST(0)   FST D10 O       D10 (80 bits) 
;32 a 80 bits           FSTP D10 
;--------------------------------------------------------


;*Datos flotantes  
;(Memoria a Memoria)
;_______________________________________________________
;Conversion      Dato    Instrucciones   Resultado
;--------------------------------------------------------
;32 a 63 bits    D4      FLD D4          D8 (64 BITS)
;                        FST D8 
;--------------------------------------------------------
;32 a 63 bits    D8      FLD D8          D4 (32 BITS)
;                        FDT D4
;--------------------------------------------------------
;32 a 63 bits    D4      FLD D4          D10 (80 BITS)
;                        FSTP D10
;--------------------------------------------------------



;Conversiones entre datos enteros y flotantes
;_______________________________________________________
;Conversion  Dato        Instrucciones   Resultado
;--------------------------------------------------------
;Entero a    D2          FILD D2         ST(0)
;float       (entero de                  (flotante)
;            16 bits) 
;--------------------------------------------------------
;Entero a    D4          FILD D4         ST(0)
;float       (entero de                  (flotante)
;            32 bits)
;--------------------------------------------------------
;Entero a    D8          FILD D8         ST(0)
;floar       (entero de                  (flotante)
;            64 bits)
;-----------------------------------------------------------
;Float a     ST(0)       FIST D2 o       D2 
;entero      (Flotante)  FISTP D2        (entero de 16 bits)
;-----------------------------------------------------------
;Float a     ST(0)       FIST D4 o       D4 
;entero      (flotante)  FISTP D4        (entero de 32 bits)
;-----------------------------------------------------------
;Float a     ST(0)       FIST D8         D8 
;entero      (flotante)  FISTP D8        (entero de 64 bits)
;-----------------------------------------------------------


;*Conversiones entre datos con y sin signo

;Origen: con signo – Destino: sin signo
    ;Origen positivo, se puede
    ;Origen negativo, es error

;Origen: sin signo – Destino: con signo se debe testear overflow
    ;Primer bit = 0, se puede 
    ;Primer bit = 1, es overflow




