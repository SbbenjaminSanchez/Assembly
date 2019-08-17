;=====================================================================
;DESARROLLADO POR BENJAMIN SANCHEZ | 17/08/2019 
;=====================================================================

;=====================================================================
;PARA COMPILAR EL PROGRAMA
;1)	\masm32\bin\ml /c /coff "main.asm"
;2)	\masm32\bin\PoLink /SUBSYSTEM:CONSOLE "main.obj"

;====================================================================


.386
option casemap	:none	;Diferencia mayusculas de minusculas

;LIBRERIAS
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

    .DATA
mensaje db "Hola Mundo!", 0

    .CODE
start:

    mensaje db "Hola!"

    invoke StdOut, addr mensaje
    invoke ExitProcess, 0

end start