;=====================================================================
;DESARROLLADO POR BENJAMIN SANCHEZ | 15/08/2019 
;=====================================================================

;=====================================================================
;PARA COMPILAR EL PROGRAMA
;1)	\masm32\bin\ml /c /coff "main.asm"
;2)	\masm32\bin\PoLink /SUBSYSTEM:WINDOWS "main.obj"

;====================================================================



.386
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


    .DATA
clase equ 'miVentana_1', 0    ;Constante

titulo DB clase               ;Variable a la que le asignamos el valor de la constante -clase-
mensaje DB 'Soy el mensaje', 0 ;Variabke



    .DATA?
total DB ?


    .CODE
start:
    

       
    invoke StdOut, addr titulo
    invoke ExitProcess, 0

end start