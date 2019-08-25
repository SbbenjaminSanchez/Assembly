.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

.data
       msg1 db "What is your name? ", 0
       msg2 db "Hello ",0

.data?
       buffer db 100 dup(?)   ; reserve 100 bytes for input storage

.code
start:
       push offset msg1        ; put in to stack the effective add of msg1
       call StdOut                  ; call console display API

       push 100                    ; set the maximum input character
       push offset buffer       ; put in to stack the effective add of input storage
       call StdIn                    ; call console input API
 
       push offset msg2       ; put in to stack the effective add of msg2
       call StdOut                 ; call console display API

       push offset buffer      ; put in to stack the effective add of input storage
       call StdOut                 ; call console display API

exit:
       push 0
       call ExitProcess
end start