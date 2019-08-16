;=====================================================================
;DESARROLLADO POR BENJAMIN SANCHEZ | 15/08/2019 
;=====================================================================

;=====================================================================
;PARA COMPILAR EL PROGRAMA
;1)	\masm32\bin\ml /c /coff "main.asm"
;2)	\masm32\bin\PoLink /SUBSYSTEM:WINDOWS "main.obj"

;====================================================================

;Directivas
.386
option casemap	:none	;Diferencia mayusculas de minusculas

;LIBRERIAS
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

;Predeclarar una funcion
;Funcione prototipo llamada WinMain con 4 parametros
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD


    ;DECLARACION DE VARIABLES CON VALOR ASIGNADO
    .DATA
claseNombre     db 'Ventana',0
tituloVentana   db 'Titulo de Ventana',0
mensajeG        db 'Texto Pintado en la ventana',0
alerta          db 'Mensaje del sistema',0
alertaMensaje   db 'Se ha finalizado el pintado!',0


    ;DECLARACION DE VARIABLES SIN VALOR ASIGNADO AUN
    .DATA?
instancia   HINSTANCE ? ; Instancia de la ventana
argumentos  LPSTR ?     ; Argumentos de la aplicacion

    ;PUESTA EN MARCHA DEL CODIGO FUENTE
    .CODE
start:
    ;TODO AQUI!!!
    ;=====================================================

    ;Funciion para pbtener la instancia que esta ejecutandose
    ;NULL es para que regrese la instancia que justo se esta ejecutando
    ;Tambien deposita la instancia en eax
    invoke GetModuleHandle,NULL ;Deposita la instancia en eax
    mov instancia, eax  ;Muever la instacia desde eax a la variable 'instancia'; mov destino,origen
    invoke GetCommandLine;Similar a GetModuleHandle, esta funcion obtiene los argumetos de la aplicacion ;Los deposita en eax
    mov argumentos, eax;De eax movemos los argumentos a la variable 'argumentos'

    ;Ejecutamos la funcion WinMain pasandole de paramentros las variables 'instancia' y 'argumentos'
    ;NULL es la instancia padre o previa, en este caso no hay
    ;SW_SHOWDEFAULT es la forma/modo de mostrar la ventana
    invoke WinMain,instancia,NULL,argumentos,SW_SHOWDEFAULT

    ;Salismo del proceso con un valor return que es eax
    invoke ExitProcess,eax

    ;funcion WinMain de 4 paramentros que se declaro es la linea 25
    WinMain proc pInstancia:HINSTANCE, pPrevia:HINSTANCE, pArgumentos:LPSTR, pVisualizacion:DWORD
        ;variables locales
        LOCAL structure:WNDCLASSEX  ;Estructura de la ventana, caracteristicas
        LOCAL mensaje:MSG             ;Variable para procesar los mensajes que se le envian a la ventana, por ejemplo la accionde un boton
        LOCAL manejador:HWND          ;Manejador de la ventana, para identificarla

        ;Setear la estructura de la ventana
        mov structure.cbSize, SIZEOF WNDCLASSEX
        mov structure.style, CS_HREDRAW or CS_VREDRAW
        mov structure.lpfnWndProc, OFFSET WndProc
        mov structure.cbClsExtra,NULL
        mov structure.cbWndExtra,NULL
        push instancia      ;Indicar a que instancia pertenece la ventana
        pop structure.hInstance
        mov structure.hbrBackground,COLOR_WINDOW+1
        mov structure.lpszMenuName,NULL
        mov structure.lpszClassName,OFFSET claseNombre
        invoke LoadIcon,NULL,IDI_APPLICATION
        mov structure.hIcon,eax
        mov structure.hIconSm,eax
        invoke LoadCursor,NULL,IDC_ARROW
        mov structure.hCursor,eax

        ;Registrar la clase de la Ventana
        invoke RegisterClassEx, addr structure
        
        ;crear la ventana
        invoke CreateWindowEx,
            NULL,
            ADDR claseNombre,
            ADDR tituloVentana,
            WS_OVERLAPPEDWINDOW,
            CW_USEDEFAULT, ;Dimendiones de la ventana
			CW_USEDEFAULT, 
			CW_USEDEFAULT, ;Posicion de la ventana
			CW_USEDEFAULT,
            NULL,
            NULL,
            pInstancia,
            NULL

        ;La anterior funcion deposita el manejador en eax
        mov manejador,eax

        ;Mostar la ventana
        invoke ShowWindow, manejador, SW_SHOWNORMAL

        ;Actualiza la ventana al pasarle el manejador
        invoke UpdateWindow,manejador

        ;Ciclo para procesar los Mensajes
        .WHILE TRUE
            ;Ejecuta la funcion qie lee mensajes
            invoke GetMessage, ADDR mensaje,NULL,0,0
            .BREAK .IF (!eax)

            ;Procesa los mensaje
            invoke TranslateMessage, ADDR mensaje
            invoke DispatchMessage, ADDR mensaje
        .ENDW

        ;Mueve a eax el paramentro del mensaje
        mov  eax,mensaje.wParam

        ;Finaliza retornado lo de eax
        ret
    WinMain endP


    ;Funcion que procesa los Mensajes a la ventana
	WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
        LOCAL hdc:HDC        ;Variable para el contexto del dispositivo
        LOCAL ps:PAINTSTRUCT ;Variable para estructura de pintar
        LOCAL rect:RECT      ;Variable para coordenadas de un rectangulo

		;Verifica si el mensaje es destruir la ventana cuando se cierra
        ;uMSG es el mensaje de entrada a la ventana
        .IF uMsg==WM_DESTROY
            ;Ejecutar la salida
            invoke PostQuitMessage,NULL
        .ELSEIF uMsg == WM_PAINT
        
            ;Inicia el pintado
            invoke BeginPaint,hWnd, ADDR ps

            ;Obtener el Manejador del contecto del dispositivo desde eax
            mov hdc,eax

            ;Obtener las coordenadas de la ventana y almacenarla en RECT
            invoke GetClientRect,hWnd, ADDR rect

            ;Dibujar un texto; -1 indica que tiene marca de final de texto, el cero (0), importante
            invoke DrawText, hdc, ADDR mensajeG, -1, ADDR rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER

            ;Finaliza el proceso de pintado
            invoke EndPaint, hWnd, ADDR ps

            ;Mensaje de finalizacion de pintado
            invoke MessageBox, NULL, addr alertaMensaje, addr alerta, MB_OK

        .ELSE
            ;El procesamiento poo default dej mensaje
            Invoke DefWindowProc,hWnd,uMsg,wParam,lParam
            ret

        .ENDIF

        ;Deja en 0 a eax
        xor eax, eax
        ret
    WndProc endp

    ;=====================================================
;FINAL DEL CODIGO FUENTE
end start 