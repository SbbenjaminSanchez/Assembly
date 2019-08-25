;=====================================================================
;DESARROLLADO POR BENJAMIN SANCHEZ 
;=====================================================================

;=====================================================================
;PARA COMPILAR EL PROGRAMA
;1)	\masm32\bin\ml /c /coff "main.asm"
;2)	\masm32\bin\PoLink /SUBSYSTEM:WINDOWS "main.obj"
;2)	\masm32\bin\PoLink /SUBSYSTEM:CONSOLE "main.obj"

;====================================================================



.386
.model flat,stdcall
option casemap	:none	;Diferencia mayusculas de minusculas

;LIBRERIAS
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib


;Tipo de datos
;sorted    DB   'y'
;value     DW   25159
;Total     DD   542803535
;float1    DD   1.234

                                 ; label      memory
                                 ; name       offset  
;value    DW  0                  ; value       0
;sum      DD  0                  ; sum         2
;marks    DW  10 DUP (?)         ; marks       6
;message  DB  'The grade is:',0  ; message    26
;char1    DB  ?                  ; char1      40

;Registro -eax- de 32 bits
;xor eax,rax            = 00000000    00000000    00000000    00000000
;mov ah,1               = 00000000    00000000    11111111    00000000
;sh1 eax,8              = 00000000    11111111    00000000    00000000
;mov ah,2               = 00000000    11111111    22222222    00000000
;mov al,3               = 00000000    11111111    22222222    33333333

;Registro


    .DATA
clase equ 'miVentana_1', 0    ;Constante

titulo DB clase               ;Variable a la que le asignamos el valor de la constante -clase-
mensaje DB 'Mensaje', 0 ;Variable
numero DW 29


    .DATA?
total DB ?


    .CODE
start:
    ;EAX (AX,AH,AL) 32 bits
    ;EBX (BX,BH,BL) 32 bits
    ;ECX (CX,CH,CL) 32 bits
    ;EDX (DX,DH,DL) 32 bits
    ;EBP (BP)
    ;ESP (SP)
    ;ESI (SI)
    
    mov eax,offset mensaje      ;mov origen,destino
    
    push eax 
    pop eax 




       
    invoke StdOut, addr total
    invoke ExitProcess, 0

end start