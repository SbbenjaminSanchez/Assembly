;=====================================================================
;DESARROLLADO POR BENJAMIN SANCHEZ | 15/08/2019 
;=====================================================================

;=====================================================================
;PARA COMPILAR EL PROGRAMA
;1)	\masm32\bin\ml /c /coff "fuentes.asm"
;2)	\masm32\bin\PoLink /SUBSYSTEM:WINDOWS "fuentes.obj"

;====================================================================

;Directivas
.386
option casemap	:none	;Diferencia mayusculas de minusculas

;LIBRERIAS
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

;Prototipo funcion Main
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

;Definicion de Macro
RGB macro red,green,blue                                    ;32 bits eax ; movimiento de los valores dentro de eax
    xor eax,eax     ;Hace eax = 0                           ;00000000   00000000    00000000    00000000
    mov ah,blue     ;Mueve blue a la parte alta de eax      ;00000000   00000000    bbbbbbbb    00000000
    shl eax,8       ;lo desplaza a la izquierda 8 bits      ;00000000   bbbbbbbb    00000000    00000000
    mov ah,green    ;Colocamos green en ah                  ;00000000   bbbbbbbb    gggggggg    00000000
    mov al,red      ;Colocamos red                          ;00000000   bbbbbbbb    gggggggg    rrrrrrrr
endm


    ;DECLARACION DE VARIABLES CON VALOR ASIGNADO
    .DATA
claseNombre     db 'Ventana',0
tituloVentana   db 'Titulo de Ventana',0
mensajeG        db 'Texto Pintado en la ventana',0
fuente          db 'script',0


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
    invoke GetModuleHandle,NULL
    mov instancia, eax
    invoke GetCommandLine
    mov argumentos, eax

    ;Ejecutamos la funcion WinMain pasandole de paramentros las variables 'instancia' y 'argumentos'
    ;NULL es la instancia padre o previa, en este caso no hay
    ;SW_SHOWDEFAULT es la forma/modo de mostrar la ventana
    invoke WinMain,instancia,NULL,argumentos,SW_SHOWDEFAULT

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
        invoke ShowWindow, manejador, SW_MAXIMIZE    ;invoke ShowWindow, manejador, SW_SHOWNORMAL

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
        
        ;variables para manejo del dispositivo
        LOCAL manejadorDispositivo:HDC   ;Variable para el contexto del dispositivo
        LOCAL variablePintar:PAINTSTRUCT ;Variable para estructura de pintar
        LOCAL manejadorFuente:HFONT      ;Variable para la fuente

		;Verifica si el mensaje es destruir la ventana cuando se cierra
        ;uMSG es el mensaje de entrada a la ventana
        .IF uMsg==WM_DESTROY
            ;Ejecutar la salida
            invoke PostQuitMessage,NULL
        .ELSEIF uMsg == WM_PAINT
        
            ;Inicia el pintado
            invoke BeginPaint,hWnd, ADDR variablePintar
            mov manejadorDispositivo,eax

            ;Çreamos una Fuente
            ;HFONT CreateFont(
                ;int nHeight,              //altura logica de la fuente
                ;int nWidth,               //anchura media logica
                ;int nEscapement,          //angulo de escape
                ;int nOrientation,         //Angulo de orientacion de linea de base
                ;int fnWeight,             //peso de la fuente
                ;DWORD fdwItalic,          //banderin de atributo de curbas
                ;DWORD fdUnderline,        //Banderin de atributo de subrayado
                ;DWORD fdwStrikeOut,       //banderin de atributo de tachado
                ;DWORD fdwCharSet,         //identificador de conjunto de caracteres
                ;DWORD fdCharSer,          //Identificador de conjunto de carecteres
                ;DWORD fdwOutputPrecision, // precision de salida
                ;DWORD fdwClipPrecision,   //precision de recorte
                ;DWORD fdwQuality,         //calidad de salida
                ;DWORD fdwPitchAndFamily,  //pitch y familia
                ;LPCTSTR lpszFace         //direccion de cadena con nombre de fuente
            ;)

            ;Esta funcion tambien retorno un objeto llamado GDIOBJ
            invoke CreateFont,24,16,0,0,400,0,0,0,OEM_CHARSET,  
                OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,
                DEFAULT_QUALITY,DEFAULT_PITCH or FF_SCRIPT,
                ADDR fuente          


            ;HGDIOBJ SelectObject (HDC manejadorDispositivo, GDIOBJ hgdiobj)
                ;ManejadorDispositivo Manejador al contexto del dispositivo
                ;hgdiobj Manejador al objeto, en este caso la fuente

            ;Seleccionamos un objeto
            ;eax la pasamos como paramentro ya que es quien contiene GDIOBJ, generada por la funcion anterior
            invoke SelectObject, manejadorDispositivo, eax

            ;Colocamos el objeto seleccionado, que ya esta en eax, en variable manejadorFuente
            mov manejadorFuente,eax

            ;Llamamos a la macro para color azul, que prepara eax con la informacion RGB
            RGB 200,200,50

            ;Definicion
            ;COLORREF SetTextColor( HDC hdc,COLORREF color );
                ;hdc Manejador al dispositivo de contexto
                ;color en formato RGB
            
            ;Colocamos el color
            invoke SetTextColor,manejadorDispositivo,eax

            ;Ejecutamos la Macro de nuevo para color rojo
            RGB 0,0,255

            ;colocamos el color de fondo
            invoke SetBkColor,manejadorDispositivo,eax

            ;Desplegar texto
            invoke TextOut, manejadorDispositivo,0,0,ADDR mensajeG,SIZEOF mensajeG
            invoke SelectObject, manejadorDispositivo, manejadorFuente
            invoke EndPaint, hWnd, ADDR variablePintar
        
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