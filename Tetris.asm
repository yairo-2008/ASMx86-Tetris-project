IDEAL
MODEL small


STACK 0F000h
p386
 
;;showbmp 
SCREEN_WIDTH = 320

;;random
START_NUM = 20
END_NUM = 50
LEN = END_NUM - START_NUM + 1

;;;;tetris
START_X = 165
START_Y = 35
START_C_X = 250
START_C_Y = 100
	
macro PUSH_ALL
	push ax
	push bx
	push cx
	push dx
	push di
endm PUSH_ALL

macro POP_ALL
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
endm POP_ALL
	
	NoteC1 			equ 9121      ;130.81 	
	NoteC_D1 		equ 8609      ;138.59 	
	NoteD1 			equ 8126      ;146.83 	
	NoteD_D1 		equ 7670      ;155.56 	
	NoteE1 			equ 7239      ;164.81 	
	NoteF1 			equ 6833      ;174.61 	
	NoteF_D1 		equ 6449      ;185.00 	
	NoteG1 			equ 6087      ;196.00 	
	NoteG_D1 		equ 5746      ;207.65 	
	NoteA1 			equ 5423      ;220.00 	
	NoteA_D1 		equ 5119      ;233.08 	
	NoteB1 			equ 4831      ;246.94 	
	NoteC2	    	equ 4560      ;261.63 	; Mid C 
	NoteC_D2 		equ 4304      ;277.18 	
	NoteD2 			equ 4063      ;293.66 	
	NoteD_D2 		equ 3834      ;311.13 	
	NoteE2 			equ 3619      ;329.63 	
	NoteF2 			equ 3416      ;349.23 	
	NoteF_D2 		equ 3224      ;369.99 	
	NoteG2 			equ 3043      ;391.00 	
	NoteG_D2 		equ 2873      ;415.30 	
	NoteA2 			equ 2711      ;440.00 	
	NoteA_D2 		equ 2559      ;466.16 	
	NoteB2 			equ 2415      ;493.88 	
	NoteC3 			equ 2280      ;523.25 	
	NoteC_D3 		equ 2152      ;554.37 	
	NoteD3 			equ 2031      ;587.33 	
	NoteD_D3 		equ 1917      ;622.25 	
	NoteE3 			equ 1809      ;659.26 	
	NoteF3 			equ 1715      ;698.46 	
	NoteF_D3 		equ 1612      ;739.99 	
	NoteG3 			equ 1521      ;783.99 	
	NoteG_D3 		equ 1436      ;830.61 	
	NoteA3 			equ 1355      ;880.00 	
	NoteA_D3 		equ 1292      ;923.33 	
	NoteB3		 	equ 1207      ;987.77 	
	NoteC4      	equ 1140      ;1046.50 

DATASEG
    ;;;charts 11 width * 16 length (in cubes)
    ;;;Y 35-180
    ;;X 120-220
    GameBoard db 176 dup (0)
	EndGameBoard db 11 dup ('$')
    ;;;;;;;;;;;;Tetris files
    TetrisScreen db 'images\TetScr.bmp',0 
	
    TetrisChart db 'images\CharTet.bmp',0
	
	GameOverPic db 'images\Over.bmp',0
    
    IShape1 db 'images\IShape1.bmp',0 ;;;
    IShape2 db 'images\IShape2.bmp',0 ;;;
    
    TShape1 db 'images\TShape1.bmp',0 ;;;
    TShape2 db 'images\TShape2.bmp',0 ;;;
    TShape3 db 'images\TShape3.bmp',0 ;;;
    TShape4 db 'images\TShape4.bmp',0 ;;;
    
    OShape db 'images\OShape.bmp',0 ;;;
    
    LShape1 db 'images\LShape1.bmp',0 ;;;
    LShape2 db 'images\LShape2.bmp',0 ;;;
    LShape3 db 'images\LShape3.bmp',0 ;;;
    LShape4 db 'images\LShape4.bmp',0 ;;;
    
    JShape1 db 'images\JShape1.bmp',0 ;;;
    JShape2 db 'images\JShape2.bmp',0 ;;;
    JShape3 db 'images\JShape3.bmp',0 ;;;
    JShape4 db 'images\JShape4.bmp',0 ;;;
    
    ZShape1 db 'images\ZShape1.bmp',0 ;;;
    ZShape2 db 'images\ZShape2.bmp',0 ;;;
    
    SShape1 db 'images\SShape1.bmp',0 ;;;
    SShape2 db 'images\SShape2.bmp',0 ;;;
    
    OChart db 'images\OChart.bmp',0 ;;;
    
    TChart db 'images\TChart.bmp',0 ;;;
    
    LChart db 'images\LChart.bmp',0 ;;;
    
    JChart db 'images\JChart.bmp',0 ;;;
    
    ZChart db 'images\ZChart.bmp',0 ;;;
    
    IChart db 'images\IChart.bmp',0 ;;;
    
    SChart db 'images\SChart.bmp',0 ;;;
    
    
    ;;;;;;;;;;;;;;;;;;;;tetris
	CurrentShape dw 0
	CurrentShapeArr dw 0 
	
	NextShapeArr dw 0
	NextShapeO dw 0
	NextBmpLeft dw ?
    NextBmpTop dw ?
    NextBmpWidth dw ?
    NextBmpHeight dw ?
	
	UnDrawLeft dw ?
    UnDrawTop dw ?
    UnDrawWidth dw ?
    UnDrawHeight dw ?
	
	UnDrawLeftNext dw ?
    UnDrawTopNext dw ?
    UnDrawWidthNext dw ?
    UnDrawHeightNext dw ?
	
	cubeMatrix db 81 dup (0)
	
	LinesStartPlace db 0ffh ;;it will be the place of the full lines on the board
	LinesAmount db 0
	Lines db 0
	
	Level db 0
	
	Score dw 0
	
	IfAsync db ?
	
	StatisticIShape dw 0
	StatisticZShape dw 0
	StatisticTShape dw 0
	StatisticSShape dw 0
	StatisticOShape dw 0
	StatisticLShape dw 0
	StatisticJShape dw 0
	
	DelayTimeShape dw 46
	
	;;;charts 11 width * 16 length (in cubes)
    ;;;Y 35-180
    ;;X 120-220
	;;9 = one +y down    $ = end of variable(Shape)   3 = cube in the place
	
	
	IShape1Array db 3,3,3,3,'$'
	
	IShape2Array db 3,9
				 db 3,9
				 db 3,9
				 db 3,'$'
	
	TShape1Array db 0,3,0,9
				 db 3,3,3,'$'
				 
	TShape2Array db 3,0,9
				 db 3,3,9
				 db 3,0,'$'
	
	TShape3Array db 3,3,3,9
				 db 0,3,0,'$'
	
	TShape4Array db 0,3,9
				 db 3,3,9
				 db 0,3,'$'
	
	OShapeArray  db 3,3,9
				 db 3,3,'$'
	
	LShape1Array db 3,0,0,9
				 db 3,3,3,'$'
	
	LShape2Array db 3,3,9
				 db 3,0,9
				 db 3,0,'$'
				 
	LShape3Array db 3,3,3,9
				 db 0,0,3,'$'
	
	LShape4Array db 0,3,9
				 db 0,3,9
				 db 3,3,'$'
				 
	JShape1Array db 0,0,3,9
				 db 3,3,3,'$'
				 
	JShape2Array db 3,0,9
				 db 3,0,9
				 db 3,3,'$'
	
	JShape3Array db 3,3,3,9
				 db 3,0,0,'$'
	
	JShape4Array db 3,3,9
				 db 0,3,9
				 db 0,3,'$'
				 
	ZShape1Array db 3,3,0,9
				 db 0,3,3,'$'
				 
	ZShape2Array db 0,3,9
				 db 3,3,9
				 db 3,0,'$'
				 
	SShape1Array db 0,3,3,9
				 db 3,3,0,'$'
	
	SShape2Array db 3,0,9
				 db 3,3,9
				 db 0,3,'$'
				 
	;;;;;;;;;;;;;;AsyncKB
	OldKeyboardInterruptOffset  dw ?   ; Old keaboard interrupt offset
	OldKeyboardInterruptSegment dw ?   ; Old keaboard interrupt Segment 
	OldTimeInterruptOffset      dw ?   ; Old Time interrupt offset
	OldTimeInterruptSegment     dw ?   ; Old Time interrupt Segment

	CurrentOldInterruptOffset   dw ?   ; The currnet Old interrupt offset
	CurrentOldInterruptSegment  dw ?   ; The currnet Old interrupt
	
	keyboardInterruptPOS    equ 9*4    ; The position of the keaborad interrupt in the interrupt vector table
	TimeInterruptPOS        equ 28*4   ; The position of the time interrupt in the interrupt vector table
	currentInterruptPOS     db ?       ; The cuurent interrupt position in the interrupt vector table
	currentInterruptOFFSET  dw ?       ; The cuurent interrupt offset
	
	key_pressed db ?
	
	extendedKey db 0
	
    ;;;;;;;;;;;;Bmp 
    ScrLine     db SCREEN_WIDTH dup (0)  ; One Color line read buffer 
    Header      db 54 dup(0)
    Palette     db 400h dup (0)
	
    ErrorFile  db 0 
       
    BmpLeft dw ?
    BmpTop dw ?
    BmpWidth dw ?
    BmpHeight dw ?
    
	;;;;;;;;Random
	RndCurrentPos dw start
	
    ;;;;;;;;;Bye output
    Bye db "Tetris game is over..",'$'
	
	;;;sounds
	Tetris dw NoteE3, NoteE3, NoteB2, NoteC3, NoteD3, NoteD3, NoteC3, NoteB2, NoteA2, NoteA2,NoteA2, NoteC3, NoteE3, NoteE3, NoteD3, NoteC3, NoteB2, NoteB2, NoteB2, NoteC3, NoteD3, NoteD3, NoteE3, NoteE3, NoteC3, NoteC3, NoteA2, NoteA2, NoteA2, NoteA2, NoteA2, NoteA2, NoteD3, NoteD3, NoteF3, NoteF3, NoteA3, NoteA3, NoteG3, NoteF3, NoteE3, NoteE3, NoteE3, NoteC3, NoteE3, NoteE3, NoteD3, NoteC3, NoteB2, NoteB2, NoteB2, NoteC3, NoteD3, NoteD3, NoteE3, NoteE3, NoteC3, NoteC3, NoteA2, NoteA2, NoteA2, NoteA2 ;62
	
	GameStart db 0
	LoopCnt db 1
	
	RulesString db ,10,10,10,10,10,10,10,"Buttons:",10,10,13,"To Rotate press the enter Button",10,10,13,"To Move Right press ->",10,10,13,"To Move Left press <-",10,10,13, "To move shape All the way down once press",10, "|",10,"\/",10,10,13,"When all the shapes will be up and no shape can enter to the board",10,10,13,"the game will stop",10,10,13,"To Continue press now any key",'$'
	 
	FileName db "Score.txt",0
	FileHandle dw ?
	FileLength dw ?
	HighScore db 7 dup (' ')
	IntStr db 7 dup (' '), "$"
	
	
CODESEG
	
start:
    mov ax, @data
    mov ds, ax
	
	call printRules
	
    call PrintTetris
	call SetShowMouse_Start
	call TetrisTheme
	call Hide_Mouse

    call PrintChart
	
	call BestScore_start
	
	call setKeyboradInterrupt
	
Tetris_Loop:
	call NewShape ;;get a new shape randomly
	call GameOver ;;check if game over
	cmp ax,1 ;;
	JE End_Tetris_Loop ;;;;if over stop
	call ShapeDown	;;;move the shape down
	call CheckEraseLines ;;erase full lines if there are
	call CheckLevel
	inc [LoopCnt]
	jmp Tetris_Loop
End_Tetris_Loop:	
	call DrawGameOverPic
	
exit:
	call read_from_file_start
	call restoreKeyboradInterrupt
    call CleanScreen
	call SetText
	   
    mov dx, offset Bye
    mov ah,9
    int 21h
 
    mov ax, 4c00h
    int 21h 

proc DrawGameOverPic
	push dx
	mov [BmpTop],0
	mov [BmpLeft],0
	mov [BmpHeight],200
	mov [BmpWidth],320
	mov dx,offset GameOverPic
	call OpenShowBmp
	
	push 75
	call Delay
	pop dx
	ret
endp DrawGameOverPic

proc printRules
	mov ah,9
	mov dx,offset RulesString
	int 21h	
	
	mov ah,7
	int 21h
	ret
endp printRules

proc BestScore_start
	PUSH_ALL
	call open_file
	call get_file_len
	call read_from_file_start
	call file_close
	POP_ALL
	ret
endp BestScore_start
;================================================
; Description - Convert String to Integer16 Unsigned
;             - Any number from 0 - 64k -1 
; INPUT:  IntStr string number ended with 10 or 13
; OUTPUT: ax as number
; Register Usage:  
;================================================
proc str_to_int 
	push bx
	push cx
	push dx
	push si
	push di
	
	mov si, 0  ; num of digits
	mov di,10
	xor ax, ax
	
@@NextDigit:
    mov bl, [IntStr + si]   ; read next ascii byte
	cmp bl,10  ; stop condition LF
	je @@ret
	cmp bl,13  ; or 13  CR
	je @@ret
	
	mul di
	
	mov bh ,0
	
	sub bl, '0'
	add ax , bx

	inc si
	cmp si, 5     ;one more stop condition
	jb @@NextDigit
	 
@@ret:
	; ax contains the number 	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	
	ret
endp str_to_int 

;================================================
; Description - Write to IntStr the num inside ax and put 13 10 after 
;			 
; INPUT: AX
; OUTPUT: IntStr 
; Register Usage: AX  
;================================================
proc int_to_str
	   push ax
	   push bx
	   push cx
	   push dx
	   
	   mov cx,0   ; will count how many time we did push 
	   mov bx,10  ; the divider
   
@@put_mode_to_stack:
	   xor dx,dx
	   div bx
	   add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
	   push dx    
	   inc cx
	   cmp ax,9   ; check if it is the last time to div
	   jg @@put_mode_to_stack

	   cmp ax,0
	   jz @@pop_next  ; jump if ax was totally 0
	   add al,30h  
	   xor si, si
	   mov [IntStr], al
	   inc si
	   
		   
@@pop_next: 
	   pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   
	   mov [IntStr + si], al
	   inc si
	   loop @@pop_next
		
	   mov [IntStr + si], 13
	   mov [IntStr + si +1 ], 10
   
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
	endp int_to_str

;================================================
; Description - It copies the score to HighScore and IntStr            
; INPUT: The offste of "HighScore", file handle 
; OUTPUT: none
; Register Usage: None 
;================================================

proc read_from_file_start
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    call read_from_file
    mov ah, 3fh
    mov bx, [FileHandle]
    mov cx, 7
    mov dx, offset HighScore
    int 21h
    call file_close

    mov si, offset HighScore
    mov di, offset IntStr
    mov cx, 7
copy_high_loop:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop copy_high_loop

    call str_to_int
    mov dh,4
	mov dl,31
	call ShowNumOnScreen
    cmp ax, [Score]
    jae @@ret_label

    mov ax, [Score]
	call int_to_str
    mov si, 0
find_actual_len:
    mov bl, [IntStr + si]
    cmp bl, '$'
    je do_save
    cmp bl, 0
    je do_save
    inc si
    cmp si, 7
    jb find_actual_len

do_save:
    call file_open_no_create_Write
    mov ah, 40h
    mov bx, [FileHandle]
    mov cx, si
    mov dx, offset IntStr   
    int 21h
    call file_close

@@ret_label:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp read_from_file_start


;================================================
; Description - It copies the score to HighScore and IntStr            
; INPUT: The offste of "HighScore", file handle 
; OUTPUT: none
; Register Usage: None 
;================================================
 proc read_from_file
	
	push ax
	push bx
	push cx
	push di
	
	;;To read the name
	mov ah, 3fh
	mov bx,[FileHandle]
	mov cx,[FileLength]
	mov dx,offset HighScore
	int 21h
	
	mov bx,offset HighScore
	;;To put in IntStr
	mov di,offset IntStr
	mov cx,7
@@loop_put_IntStr:
	mov ax,[bx]
	mov [di],ax
	inc bx
	inc di
	loop @@loop_put_IntStr
	
	call str_to_int
	
	cmp ax,[Score]
	JB @@Switch
	jmp @@dontSwitch
@@Switch:
	mov ax,[Score]
	
@@dontSwitch:
	call int_to_str
	
	mov si,0
@@CheckBytes:
    mov bl, [IntStr + si]   ; read next ascii byte
	cmp bl,10  ; stop condition LF
	je @@ret
	cmp bl,13  ; or 13  CR
	je @@ret
	inc si
	jmp @@CheckBytes
@@ret:

	call file_close
	call file_open_no_create_Write
	
	mov ah,40h
	mov bx,[FileHandle]
	mov cx,si
	mov dx,offset IntStr	
	int 21h
	
	pop di
	pop cx
	pop bx
	pop ax
	
	ret
 endp read_from_file

;================================================
; Description -  It closes the file, if there is an error it will put -1 in ax.
;           	 
; INPUT: The handel to the file.
; OUTPUT: None . 
; Register Usage: ax could change to -1 if there is an error.
;================================================				 
proc file_close

	;here your code
	push bx

	mov bx,[FileHandle]
	mov ah,3Eh
	int 21h
	
	JC Move_Ax_Minus1
	jmp end_file_close
	
	Move_Ax_Minus1:
	mov ax,-1
	
	end_file_close:
	pop bx
	ret 
endp file_close


;================================================
; Description -  Put the handle into var FileHandle using int 21h, 3D (WRITE ONLY)
;
; INPUT:  DX = the offset of the file we want to open
; OUTPUT:  the handle in var FileHandle (size Word)
; Register Usage:
;================================================				  
proc file_open_no_create_Write

	;here your code
	 push dx
	 push ax
	 
	 mov ah,3dh
	 mov al,1 ;(only reading)
	 
	 mov dx,offset FileName
	 int 21h
	 
	 mov [FileHandle],ax
	 
	 end_file_open:
	 
	 pop ax
	 pop dx
	ret 
	
endp file_open_no_create_Write

;================================================
; Description -  It finds the file's length. 
;           	 
; INPUT:  The handel of the file.
; OUTPUT: It will put the file's length in variable "FileLength".
; Register Usage: ax could change to -1 if there is an error. 
;================================================				 
proc get_file_len
 	
	;here your code
	
	push bx
	push cx
	push dx
	
	mov ah,42h
	mov al,2
	mov bx,[FileHandle]
	mov cx,0
	mov dx,0
	int 21h
	
	JC Mov_Ax_Minus1
	jmp end_get_file_len
	
	Mov_Ax_Minus1:
	mov ax,-1
	
	end_get_file_len:
	mov [FileLength],ax
	mov si,ax
	
	mov ah,42h
	mov al,0
	mov bx,[FileHandle]
	mov cx,0
	mov dx,0
	int 21h
	
	pop dx
	pop cx
	pop bx
	ret 
endp get_file_len

;================================================
; Description - Opens file and if there is no file called "Score.txt" create one            
; INPUT: The offste of FileName 
; OUTPUT: The handel in "FileHandle"  
; Register Usage: None 
;================================================
 proc open_file
	 
	push dx
	push ax
	
	
	mov ah,3dh
	mov al,00 ;(only reading)
	
	mov dx,offset FileName
	int 21h
	 
	mov [FileHandle],ax
	 
	end_file_open2:
	
	pop ax
	pop dx
	ret 
 
 endp open_file

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;================================================
; Description -  It Adding levels to game. 
;           	 
; INPUT:  None.
; OUTPUT: None.
; Register Usage: None. 
;================================================
proc CheckLevel
	push ax
	push dx
	cmp [LoopCnt],10
	JNE End_CheckLevel
	
	mov dh,44
	mov dl,24
	xor ax,ax
	inc [level]
	mov al,[Level]
	call ShowNumOnScreen
	
	cmp [DelayTimeShape],16
	JE End_CheckLevel
	
	mov [LoopCnt],0
	sub [DelayTimeShape],2
End_CheckLevel:
	pop DX
	pop ax
	ret
endp CheckLevel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
							;;Async Mouse
proc SetShowMouse_Start
	call Show_Mouse
	call SetInterruptMouse_Start
	ret
endp SetShowMouse_Start

proc Show_Mouse
	push ax
	mov ax,1
	int 33h
	pop ax
	ret
endp Show_Mouse

proc Hide_Mouse
	push ax
	mov ax,2
	int 33h
	pop ax
	ret
endp Hide_Mouse

proc SetInterruptMouse_Start
	mov ax,seg MouseInterrupt ;;to set when to go when interrupt
	mov es,ax
	mov dx, offset MouseInterrupt  ; ES:DX ->Far routine
	mov cx,0000000000001010b 
	mov ax,0ch ;;for int 33h
	int 33h
	ret
endp SetInterruptMouse_Start

proc MouseInterrupt
	mov [GameStart],0
	call Check_if_mouse_in_X_Y_Range
	cmp ax,1
	JZ @@key_pressed_Mouse
	jmp @@No_key_pressed
@@key_pressed_Mouse:
	mov [GameStart],1
@@No_key_pressed:
	retf
endp MouseInterrupt
;;;returns 1 if in range in ax
proc Check_if_mouse_in_X_Y_Range
	mov ax,0
	
	cmp bx,2
	je @@OutOfRange
	
	shr cx,1
	cmp cx,139
	JB @@OutOfRange
	
	cmp cx,179
	JA @@OutOfRange
	
	cmp dx,140
	JB @@OutOfRange
	
	cmp dx,156
	JA @@OutOfRange
	
	mov ax,1

@@OutOfRange:
	ret
endp Check_if_mouse_in_X_Y_Range
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									;;Sound procs of shapes (omer)
proc TetrisTheme

Loop_Song:
	mov cx, 62
	lea si,[Tetris]
@@NextNote:
	cmp [GameStart],1
	JE End_Tetris_Theme
	push cx	
	
	mov     bx,[word ptr si]             
	mov     al, 10110110b    ; 10110110b  
	out     43h, al          ;  

	mov     ax, bx            
	out     42h, al           
	mov     al, ah           
	out     42h, al        
	 
	in      al, 61h           
	or      al, 00000011b   
	out     61h, al          
 
	push ax
	mov ax,20
	push ax
	call Delay
	pop ax
	
	inc si
	inc si
	
	pop cx
	loop @@NextNote
	jmp Loop_Song
End_Tetris_Theme:             
	in      al,61h           
	and     al,11111100b     
	out     61h,al           
	ret
endp TetrisTheme

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									;;Tetris procs of shapes (omer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;;for checking if game over
;================================================
; Description:checking if game over or not.
; INPUT:None.
; OUTPUT:ax = 1 if game over if not ax = 0.
; Register Usage:None.
;================================================										
proc GameOver
	push di
	push bx
	
	call FindCubeFirstPlace ;;returns in ax the first cube place
	
	mov di,[CurrentShapeArr]
	
	mov bx,offset GameBoard
	add bx,ax
	
	
	;;ax is the counter when we want to go a line down
	mov ax,0
Go_shape_array_byte:
	cmp [byte ptr di],'$'
		JE End_game_over
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	cmp [byte ptr bx],3
	JE Game_Over
	inc bx
	inc di
	inc ax
	jmp Go_shape_array_byte
@@if_0:
	inc bx
	inc di
	inc ax
	jmp Go_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp Go_shape_array_byte

End_game_over:
	mov ax,0
	jmp GameNotOver

Game_Over:
	mov ax,1
	
GameNotOver:
	pop bx
	pop di
	ret
endp GameOver
									
									
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;;for checking and erase lines
										
										
;================================================
; Description: It checks the Line and erase it if there is a full line and adds score and does it as much as full lines.
; INPUT: None.
; OUTPUT: the line that erases
; Register Usage: None
;================================================
proc CheckEraseLines
	PUSH_ALL
	
	mov [LinesAmount],0
	jmp @@FirstTime
Loop_CheckErase:
	inc [LinesAmount]
@@FirstTime:
	call CheckLines 
	cmp [LinesStartPlace],0ffh
	JNE Loop_CheckErase
	call Add_Score_Lines
	
	POP_ALL
	ret
endp CheckEraseLines

;================================================
; Description: It checks the Line and erase it if there is a full line.
; INPUT: None.
; OUTPUT: the line that erases
; Register Usage: None.
;================================================
proc CheckLines
	PUSH_ALL ;;To save Registers value
	
	mov [LinesStartPlace],0ffh
	
	mov bx,offset GameBoard ;;to get to the values in the game board
	mov cx,16 ;;its the amount of Lines in the board
	xor ax,ax ;;to make ZERO ax
Loop_Next_Line:
	push cx ;;to save the value
	add bx,ax ;;to go to the next line
	mov ax,0 ;;;it will be our counter for the next Line
	mov cx,11 ;;the amount cubes in a Line
	
Loop_Check_Current_Line:

;;to check if there a Line already so i wont do more checks
	cmp [LinesStartPlace],0ffh
	JNE there_is_a_full_line_already
	
	cmp [byte ptr bx],0
	JE End_Loop_Current_Line
	inc ax
	inc bx
	Loop Loop_Check_Current_Line
		
	push bx
	sub bx,11
	mov [LinesStartPlace],bl ;;to save the first place
	pop bx

there_is_a_full_line_already:	
	jmp go_next_line
	
End_Loop_Current_Line:
	sub ax,11 ;;to sub the amount of line and find out next line place in thr arr
	neg ax ;;to make it positive
	
go_next_line:
	pop cx
	Loop Loop_Next_Line
	
	cmp [LinesStartPlace],0ffh
	JE End_CheckLines 
	
	call EraseLinesVisual
	call EraseLinesArr
	call MoveAllCubesDown
	
End_CheckLines:
	POP_ALL ;;To save Registers value
	ret
endp CheckLines

;================================================
; Description: It erases the Line on screen by [LinesStartPlace].
; INPUT: variable [LinesStartPlace].
; OUTPUT: the line erases from screen
; Register Usage: None.
;================================================										
proc EraseLinesVisual
	PUSH_ALL
	
	mov al,[LinesStartPlace]
	mov dl,11 ;;amount of cubes in a line
	
	div dl ;;;;to find in which line
	
	mov dl,9 ;;height of a cube in pixels
	mul dl
	
	add ax,35
	
	mov [UnDrawTop],ax
	mov [UnDrawLeft],120
	mov [UnDrawWidth],99
	mov [UnDrawHeight],9
	
	call UnDraw

	POP_ALL
	ret
endp EraseLinesVisual							

;================================================
; Description: It erases the line from the arr and puts 0 instead.
; INPUT: variable [LinesStartPlace].
; OUTPUT: None.
; Register Usage: None.
;================================================
proc EraseLinesArr
	PUSH_ALL
	
	mov bx,offset GameBoard
	xor ax,ax ;;to make him zero
	mov al,[LinesStartPlace];;to get "index" of the first
	add bx,ax;;to get to the first cube in the line
	
	mov cx,11
Loop_Erase:
	mov [byte ptr bx],0
	inc bx
	loop Loop_Erase
	
	POP_ALL
	ret
endp EraseLinesArr

;================================================
; Description:It moves all the cubes down after we erased the line.
; INPUT:variable [LinesStartPlace].
; OUTPUT: the cubes that moves down on screen
; Register Usage: None.
;================================================
proc MoveAllCubesDown
	PUSH_ALL
	mov ax,0
	mov bl,[LinesStartPlace];;the full line starting place
	dec bx;;start a line up
Loop_Move_All_Cubes_Down:

	cmp bx,offset GameBoard;;to check when to stop
	JE End_Move_All_Cubes_Down
	
Not_Last_Cube:
	mov di,bx
	add di,11	
	
	cmp [byte ptr bx],0;;checking if there is a cube
	JE Go_Next_Cube
	
	mov [byte ptr di],3
	mov [Byte ptr bx],0
		
	call FindCubeFirstPlaceInDi
	call getCubeFromScreen
	mov cx,9
Loop_Move_Cube:
	add di,320
	call PutCubeMatrixOnScreen
	loop Loop_Move_Cube
	
	push 10
	call Delay
	
Go_Next_Cube:
	dec bx
	jmp Loop_Move_All_Cubes_Down
	
End_Move_All_Cubes_Down:
	POP_ALL
	ret
endp MoveAllCubesDown

;================================================
; Description: It finds the TopLeft place of the cube by GameBoard.
; INPUT: bx = cube on GameBoard.
; OUTPUT: di = bytes place on screen (1-64000)
; Register Usage: di.
;================================================
proc FindCubeFirstPlaceInDi
	push ax
	push bx
	push cx
	push dx
	
	mov ax,bx
	mov dl,11
	div dl ;;to get in al the Y
	mov cl,ah ;;to save the x
	
	xor ah,ah 
	xor ch,ch 
	
	mov dl,9
	mul dl
	add al,35
	
	mov di,320
	mov dx,0
	mul di
	
	add ax,120
	
	mov di,ax
	
	mov ax,cx
	mov dl,9
	mul dl
	
	add di,ax
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp FindCubeFirstPlaceInDi

;Description:
;will get the cubematrix in the specified location on the screen

;input:
; in cubematrix - the bytes
; in di start byte in screen (0 64000 -1) (TopLeft place of cube)

;output:
;variable who's offset is in [cubeMatrix]
proc getCubeFromScreen
	PUSH_ALL
	push es
	push si

	mov ax, 0A000h
	mov es, ax
	
	push dx
	mov ax, cx
	mul dx

	mov bp, ax
	pop dx
	mov si, offset cubeMatrix
	
	mov cx,9
	mov dx,9
	
@@NextRow:
	push cx
	
	mov cx, dx
@@GetLinesFromScreen:
	mov bl, [es:di]
	mov [ds:si], bl
	inc si
	inc di
	loop @@GetLinesFromScreen
	
	sub di,dx
	add di, 320
	pop cx
	loop @@NextRow

@@ret:
	pop si
	pop es
	POP_ALL
	ret
endp getCubeFromScreen

;================================================
; Description: It prints the cube matrix.
; INPUT: di = start byte on screen (0-64000). (size known already (81 bytes))
; OUTPUT: It prints the cube matrix 
; Register Usage: None.
;================================================
proc PutCubeMatrixOnScreen
	PUSH_ALL
	push es
	push si
	
	mov ax,0A000h
	mov es,ax
	
	mov si,offset cubeMatrix
	
	mov cx,9
Loop_print_next_line:
	push cx
	
	mov cx,9
Loop_print_Line:
	mov al,[ds:si]
	mov [es:di],al
	inc si
	inc di
	Loop Loop_print_Line
	
	add di,311
	pop cx
	loop Loop_print_next_line
	
	pop si
	pop es
	POP_ALL
	ret
endp PutCubeMatrixOnScreen

proc Add_Score_Lines	
	push ax
	push bx
	push cx
	push dx
	
	cmp [LinesAmount],0
	JE End_Add_Score_Lines
	xor dx,dx
	
	mov al,[LinesAmount]
	dec ax
	mov bl,2
	mul bl
	mov dl,al
		
	mov al,[LinesAmount]
	mov bl,4
	mul bl
	add dl,al
	
	Add [Score],dx
	
	mov dh,7
	mov dl,31
	mov ax,[Score]
	call ShowNumOnScreen
	
	mov al,[LinesAmount]
	Add [Lines],al
	mov dh,2
	mov dl,24
	xor ax,ax
	mov al,[Lines]
	call ShowNumOnScreen

End_Add_Score_Lines:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp Add_Score_Lines

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											;;for the shape Rotate
;================================================
; Description: It rotates the shape.
; INPUT: you need to enter to "CurrentShape" the offset of the file name 
; OUTPUT: The shape that moves on the screen
; Register Usage: None
;================================================
proc RotateShape
	push ax 
	push cx
	push dx
	
	mov ah,0dh ;;int 10h
	;;To get to the x of the first pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the first pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,2
	
		;;Checks if there another shape that we can't go down because of her
	cmp [CurrentShape],offset ZShape1
	JNE @@NotZShape1
	jmp @@ZShape1
@@NotZShape1:

	cmp [CurrentShape],offset ZShape2
	JNE @@NotZShape2
	jmp @@ZShape2
@@NotZShape2:

	cmp [CurrentShape],offset SShape1
	JNE @@NotSShape1
	jmp @@SShape1
@@NotSShape1:

	cmp [CurrentShape],offset SShape2
	JNE @@NotSShape2
	jmp @@SShape2
@@NotSShape2:

	cmp [CurrentShape],offset OShape
	JNE @@NotOShape
	jmp EndRotate
@@NotOShape:
	
	cmp [CurrentShape],offset LShape1
	JNE @@NotLShape1
	jmp @@LShape1
@@NotLShape1:

	cmp [CurrentShape],offset LShape2
	JNE @@NotLShape2
	jmp @@LShape2
@@NotLShape2:

	cmp [CurrentShape],offset LShape3
	JNE @@NotLShape3
	jmp @@LShape3
@@NotLShape3:

	cmp [CurrentShape],offset LShape4
	JNE @@NotLShape4
	jmp @@LShape4
@@NotLShape4:

	cmp [CurrentShape],offset JShape1
	JNE @@NotJShape1
	jmp @@JShape1
@@NotJShape1:

	cmp [CurrentShape],offset JShape2
	JNE @@NotJShape2
	jmp @@JShape2
@@NotJShape2:

	cmp [CurrentShape],offset JShape3
	JNE @@NotJShape3
	jmp @@JShape3
@@NotJShape3:

	cmp [CurrentShape],offset JShape4
	JNE @@NotJShape4
	jmp @@JShape4
@@NotJShape4:

	cmp [CurrentShape],offset IShape1
	JNE @@NotIShape1
	jmp @@IShape1
@@NotIShape1:

	cmp [CurrentShape],offset IShape2
	JNE @@NotIShape2
	jmp @@IShape2
@@NotIShape2:

	cmp [CurrentShape],offset TShape1
	JNE @@NotTShape1
	jmp @@TShape1
@@NotTShape1:

	cmp [CurrentShape],offset TShape2
	JNE @@NotTShape2
	jmp @@TShape2
@@NotTShape2:

	cmp [CurrentShape],offset TShape3
	JNE @@NotTShape3
	jmp @@TShape3
@@NotTShape3:

	jmp @@TShape4

@@ZShape1:	
	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape1FirstCube
	jmp EndRotate
RotateZShape1FirstCube:

	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape1SecondCube
	jmp EndRotate
RotateZShape1SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape1FirstCube_2
	jmp EndRotate
RotateZShape1FirstCube_2:

	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape1SecondCube_2
	jmp EndRotate
RotateZShape1SecondCube_2:
	
	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset ZShape2Array
	
	mov [CurrentShape],offset ZShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

	jmp EndRotate

@@ZShape2:

	int 10h
	cmp al,0
	JE RotateZShape2FirstCube
	jmp EndRotate
RotateZShape2FirstCube:

	add cx,18
	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape2SecondCube
	jmp EndRotate
RotateZShape2SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	int 10h
	cmp al,0
	JE RotateZShape2FirstCube_2
	jmp EndRotate
RotateZShape2FirstCube_2:

	add cx,18
	add dx,9
	int 10h
	cmp al,0
	JE RotateZShape2SecondCube_2
	jmp EndRotate
RotateZShape2SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset ZShape1Array
	
	mov [CurrentShape],offset ZShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

	jmp EndRotate

@@SShape1:
	int 10h
	cmp al,0
	JE RotateSShape1FirstCube
	jmp EndRotate
RotateSShape1FirstCube:
	
	add dx,18
	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape1SecondCube
	jmp EndRotate
RotateSShape1SecondCube:
	

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	int 10h
	cmp al,0
	JE RotateSShape1FirstCube_2
	jmp EndRotate
RotateSShape1FirstCube_2:
	
	add dx,18
	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape1SecondCube_2
	jmp EndRotate
RotateSShape1SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset SShape2Array
	
	mov [CurrentShape],offset SShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate


@@SShape2:
	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape2FirstCube
	jmp EndRotate
RotateSShape2FirstCube:
	
	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape2SecondCube
	jmp EndRotate
RotateSShape2SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape2FirstCube_2
	jmp EndRotate
RotateSShape2FirstCube_2:
	
	add cx,9
	int 10h
	cmp al,0
	JE RotateSShape2SecondCube_2
	jmp EndRotate
RotateSShape2SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset SShape1Array
	
	mov [CurrentShape],offset SShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate


@@LShape1:
	add cx,9
	int 10h
	cmp al,0
	JE RotateLShape1FirstCube
	jmp EndRotate
RotateLShape1FirstCube:

	sub cx,9
	add dx,18
	int 10h
	cmp al,0
	JE RotateLShape1SecondCube
	jmp EndRotate
RotateLShape1SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	int 10h
	cmp al,0
	JE RotateLShape1FirstCube_2
	jmp EndRotate
RotateLShape1FirstCube_2:

	sub cx,9
	add dx,18
	int 10h
	cmp al,0
	JE RotateLShape1SecondCube_2
	jmp EndRotate
RotateLShape1SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset LShape2Array
	
	mov [CurrentShape],offset LShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate

@@LShape2:
	add cx,18
	int 10h
	cmp al,0
	JE RotateLShape2FirstCube
	jmp EndRotate
RotateLShape2FirstCube:

	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape2SecondCube
	jmp EndRotate
RotateLShape2SecondCube:
;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,18
	int 10h
	cmp al,0
	JE RotateLShape2FirstCube_2
	jmp EndRotate
RotateLShape2FirstCube_2:

	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape2SecondCube_2
	jmp EndRotate
RotateLShape2SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset LShape3Array
	
	mov [CurrentShape],offset LShape3
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate

@@LShape3:
	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape3FirstCube
	jmp EndRotate
RotateLShape3FirstCube:

	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape3SecondCube
	jmp EndRotate
RotateLShape3SecondCube:

	sub cx,9
	int 10h
	cmp al,0
	JE RotateLShape3ThirdCube
	jmp EndRotate
RotateLShape3ThirdCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape3FirstCube_2
	jmp EndRotate
RotateLShape3FirstCube_2:

	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape3SecondCube_2
	jmp EndRotate
RotateLShape3SecondCube_2:

	sub cx,9
	int 10h
	cmp al,0
	JE RotateLShape3ThirdCube_2
	jmp EndRotate
RotateLShape3ThirdCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset LShape4Array
	
	mov [CurrentShape],offset LShape4	
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate

@@LShape4:
	int 10h
	cmp al,0
	JE RotateLShape4FirstCube
	jmp EndRotate
RotateLShape4FirstCube:
	
	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape4SecondCube
	jmp EndRotate
RotateLShape4SecondCube:

	add cx,18
	int 10h
	cmp al,0
	JE RotateLShape4ThirdCube
	jmp EndRotate
RotateLShape4ThirdCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8
	
	int 10h
	cmp al,0
	JE RotateLShape4FirstCube_2
	jmp EndRotate
RotateLShape4FirstCube_2:
	
	add dx,9
	int 10h
	cmp al,0
	JE RotateLShape4SecondCube_2
	jmp EndRotate
RotateLShape4SecondCube_2:

	add cx,18
	int 10h
	cmp al,0
	JE RotateLShape4ThirdCube_2
	jmp EndRotate
RotateLShape4ThirdCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset LShape1Array
	
	mov [CurrentShape],offset LShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate

@@JShape1:
	int 10h
	cmp al,0
	JE RotateJShape1FirstCube
	jmp EndRotate
RotateJShape1FirstCube:
	
	add dx,18
	int 10h
	cmp al,0
	JE RotateJShape1SecondCube
	jmp EndRotate
RotateJShape1SecondCube:

	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape1ThirdCube
	jmp EndRotate
RotateJShape1ThirdCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	int 10h
	cmp al,0
	JE RotateJShape1FirstCube_2
	jmp EndRotate
RotateJShape1FirstCube_2:
	
	add dx,18
	int 10h
	cmp al,0
	JE RotateJShape1SecondCube_2
	jmp EndRotate
RotateJShape1SecondCube_2:

	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape1ThirdCube_2
	jmp EndRotate
RotateJShape1ThirdCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset JShape2Array
	
	mov [CurrentShape],offset JShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate

@@JShape2:
	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape2FirstCube
	jmp EndRotate
RotateJShape2FirstCube:

	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape2SecondCube
	jmp EndRotate
RotateJShape2SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape2FirstCube_2
	jmp EndRotate
RotateJShape2FirstCube_2:

	add cx,9
	int 10h
	cmp al,0
	JE RotateJShape2SecondCube_2
	jmp EndRotate
RotateJShape2SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset JShape3Array
	
	mov [CurrentShape],offset JShape3
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate	

@@JShape3:
	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape3FirstCube
	jmp EndRotate
RotateJShape3FirstCube:
	
	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape3SecondCube
	jmp EndRotate
RotateJShape3SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape3FirstCube_2
	jmp EndRotate
RotateJShape3FirstCube_2:
	
	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape3SecondCube_2
	jmp EndRotate
RotateJShape3SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset JShape4Array
	
	mov [CurrentShape],offset JShape4
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate


@@JShape4:
	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape4FirstCube
	jmp EndRotate
RotateJShape4FirstCube:

	add cx,18
	int 10h
	cmp al,0
	JE RotateJShape4SecondCube
	jmp EndRotate
RotateJShape4SecondCube:

	sub dx,9
	int 10h
	cmp al,0
	JE RotateJShape4ThirdCube
	jmp EndRotate
RotateJShape4ThirdCube:
;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add dx,9
	int 10h
	cmp al,0
	JE RotateJShape4FirstCube_2
	jmp EndRotate
RotateJShape4FirstCube_2:

	add cx,18
	int 10h
	cmp al,0
	JE RotateJShape4SecondCube_2
	jmp EndRotate
RotateJShape4SecondCube_2:

	sub dx,9
	int 10h
	cmp al,0
	JE RotateJShape4ThirdCube_2
	jmp EndRotate
RotateJShape4ThirdCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset JShape1Array
	
	mov [CurrentShape],offset JShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate

@@IShape1:
	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1FirstCube
	jmp EndRotate
RotateIShape1FirstCube:

	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1SecondCube
	jmp EndRotate
RotateIShape1SecondCube:

	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1ThirdCube
	jmp EndRotate
RotateIShape1ThirdCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1FirstCube_2
	jmp EndRotate
RotateIShape1FirstCube_2:

	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1SecondCube_2
	jmp EndRotate
RotateIShape1SecondCube_2:

	add dx,9
	int 10h
	cmp al,0
	JE RotateIShape1ThirdCube_2
	jmp EndRotate
RotateIShape1ThirdCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset IShape2Array
	
	mov [CurrentShape],offset IShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],9
	mov [BmpHeight],36

jmp EndRotate

@@IShape2:
	add dx,27
	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2FirstCube
	jmp EndRotate
RotateIShape2FirstCube:	

	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2SecondCube
	jmp EndRotate
RotateIShape2SecondCube:	

	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2ThirdCube
	jmp EndRotate
RotateIShape2ThirdCube:	

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add dx,27
	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2FirstCube_2
	jmp EndRotate
RotateIShape2FirstCube_2:	

	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2SecondCube_2
	jmp EndRotate
RotateIShape2SecondCube_2:	

	add cx,9
	int 10h
	cmp al,0
	JE RotateIShape2ThirdCube_2
	jmp EndRotate
RotateIShape2ThirdCube_2:	

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset IShape1Array
	
	mov [CurrentShape],offset IShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],36
	mov [BmpHeight],9

jmp EndRotate

@@TShape1:
	int 10h
	cmp al,0
	JE RotateTShape1FirstCube
	jmp EndRotate
RotateTShape1FirstCube:
	
	add dx,18
	int 10h
	cmp al,0
	JE RotateTShape1SecondCube
	jmp EndRotate
RotateTShape1SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	int 10h
	cmp al,0
	JE RotateTShape1FirstCube_2
	jmp EndRotate
RotateTShape1FirstCube_2:
	
	add dx,18
	int 10h
	cmp al,0
	JE RotateTShape1SecondCube_2
	jmp EndRotate
RotateTShape1SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset TShape2Array
	
	mov [CurrentShape],offset TShape2
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate

@@TShape2:
	add cx,9
	int 10h
	cmp al,0
	JE RotateTShape2FirstCube
	jmp EndRotate
RotateTShape2FirstCube:

	add cx,9
	int 10h
	cmp al,0
	JE RotateTShape2SecondCube
	jmp EndRotate
RotateTShape2SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add cx,9
	int 10h
	cmp al,0
	JE RotateTShape2FirstCube_2
	jmp EndRotate
RotateTShape2FirstCube_2:

	add cx,9
	int 10h
	cmp al,0
	JE RotateTShape2SecondCube_2
	jmp EndRotate
RotateTShape2SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset TShape3Array
	
	mov [CurrentShape],offset TShape3
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18

jmp EndRotate


@@TShape3:
	add dx,9
	int 10h
	cmp al,0
	JE RotateTShape3FirstCube
	jmp EndRotate
RotateTShape3FirstCube:
	
	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateTShape3SecondCube
	jmp EndRotate
RotateTShape3SecondCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8
	
	add dx,9
	int 10h
	cmp al,0
	JE RotateTShape3FirstCube_2
	jmp EndRotate
RotateTShape3FirstCube_2:
	
	add cx,9
	add dx,9
	int 10h
	cmp al,0
	JE RotateTShape3SecondCube_2
	jmp EndRotate
RotateTShape3SecondCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset TShape4Array
	
	mov [CurrentShape],offset TShape4
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],18
	mov [BmpHeight],27

jmp EndRotate


@@TShape4:
	add dx,9
	add cx,18
	int 10h
	cmp al,0
	JE RotateTShape4FirstCube
	jmp EndRotate
RotateTShape4FirstCube:

;;To get to the x of the last pixel of the left top cube in the shape
	mov cx,[BmpLeft]
	add cx,5

;;To get to the Y of the last pixel of the left top cube in the shape
	mov dx,[BmpTop]
	add dx,8

	add dx,9
	add cx,18
	int 10h
	cmp al,0
	JE RotateTShape4FirstCube_2
	jmp EndRotate
RotateTShape4FirstCube_2:

	call UnDrawBmp ;;to undraw the shape
	
	push [CurrentShapeArr]
	call remove_shape_from_arr ;; to change the shape in array
	
	mov [CurrentShapeArr],offset TShape1Array
	
	mov [CurrentShape],offset TShape1
	
	push [CurrentShapeArr]
	call PutShapeOnBoard

	mov [BmpWidth],27
	mov [BmpHeight],18


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EndRotate:
	mov dx,[CurrentShape]
	call OpenShowBmp
	
	pop dx
	pop cx
	pop ax
	
	ret
endp RotateShape	
																	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											;;for the shape down
;================================================
; Description:Its Moves the shape down and puts it on the board.
; INPUT:variables of tetris.
; OUTPUT:The shape that moves on the screen.
; Register Usage: None.
;================================================	
proc ShapeDown
Loop_down:
	mov cx,9
	call IfDown
	cmp ax,0
	JE End_Loop_Down
Down_9_pixels:
	mov dx,[CurrentShape]
	inc [BmpTop]
	call OpenShowBmp
	Loop Down_9_pixels
	Push [DelayTimeShape]
	call Delay
	jmp Loop_down
End_Loop_Down:	
	ret 
endp ShapeDown

;================================================
; Description:its checks if the shape can go down.
; INPUT:None.
; OUTPUT:ax = 1 if can go down. ax = 0 if cant go down.
; Register Usage: ax.
;================================================	
proc IfDown
	push cx 
	mov ax,180
	sub ax,[BmpHeight]
	dec ax					
	cmp [BmpTop],ax
	JE MaxY
	jmp @@can_go_down
MaxY:
	jmp can_not_go_down

@@can_go_down:
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
check_down_shape_array_byte:
	cmp [byte ptr di],'$'
		JE can_go_down
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	push di
	mov di,bx
	add di,11
	cmp [byte ptr di],3 ;;;;;;checks one line under if there is a cube
	JE can_not_go_down
	pop di
	inc bx
	inc di
	inc ax
	push [CurrentShapeArr]
	call PutShapeOnBoard
	jmp check_down_shape_array_byte
@@if_0:
	inc bx
	inc di
	inc ax
	jmp check_down_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp check_down_shape_array_byte
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
can_go_down:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	call move_shape_down_arr;;;;;;;;
	mov ax,1
	jmp EndIfDown

can_not_go_down:
	pop di
	push [CurrentShapeArr]
	call PutShapeOnBoard 
	mov ax,0
EndIfDown:
	pop cx
	ret 
endp IfDown

;================================================
; Description:its moves the shape down in the array.
; INPUT:variables "CurrentShapeArr","GameBoard".
; OUTPUT:None.
; Register Usage: None.
;================================================

proc move_shape_down_arr
	push ax
	push bx
	push di 
	
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
down_shape_array_byte:
	cmp [byte ptr di],'$'
		JE end_move_down_shape_arr
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push di
	mov di,bx
	add di,11
	mov [byte ptr di],3
	pop di
	inc bx
	inc di
	inc ax
	jmp down_shape_array_byte
	
@@if_0:
	inc bx
	inc di
	inc ax
	jmp down_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp down_shape_array_byte

end_move_down_shape_arr:
	pop di 
	pop bx
	pop ax
	ret
endp move_shape_down_arr

;================================================
; Description: It moves the shape all the way down.
; INPUT:"CurrentShape" the offset of the file name 
; OUTPUT: The shape that moves on the screen
; Register Usage:None 
;================================================
proc AllTheWayDown
	
	mov [IfAsync],1
	
Loop_All_down:
	mov cx,9
	call IfDown
	cmp ax,0
	JE End_Loop_All_Down

@@Down_9_pixels:
	mov dx,[CurrentShape]
	inc [BmpTop]
	call OpenShowBmp
	Loop @@Down_9_pixels
	jmp Loop_All_down
End_Loop_All_Down:

	mov [IfAsync],0
	
	ret
endp AllTheWayDown


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									;;for the shape Left
;================================================
; Description:Its Moves the shape Left and puts it on the board.
; INPUT:variables of tetris.
; OUTPUT:The shape that moves on the screen.
; Register Usage: None.
;================================================	
proc ShapeLeft
	push ax
	push bx
	push cx
	push dx
	push di

	push [CurrentShapeArr]
	call PutShapeOnBoard
Loop_Left:
	mov cx,9
	call IfLeft
	cmp ax,0
	JE End_Loop_Left
Left_9_pixels:
	mov dx,[CurrentShape]
	dec [BmpLeft]
	call OpenShowBmp
	Loop Left_9_pixels
End_Loop_Left:
	
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret 
endp ShapeLeft

;================================================
; Description:its checks if the shape can go Left.
; INPUT:None.
; OUTPUT:ax = 1 if can go Left. ax = 0 if cant go Left.
; Register Usage: ax.
;================================================	
proc IfLeft
	push cx 
	cmp [BmpLeft],120				
	JE MinX
	jmp @@can_go_Left
MinX:
	jmp can_not_go_Left_Min_X

@@can_go_Left:
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
check_Left_shape_array_byte:
	cmp [byte ptr di],'$'
		JE can_go_Left
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	push di
	mov di,bx
	dec di
	cmp [byte ptr di],3 ;;;;;;it checks if there is a cube one for the left
	JE can_not_go_Left
	pop di
	inc bx
	inc di
	inc ax
	push [CurrentShapeArr]
	call PutShapeOnBoard
	jmp check_Left_shape_array_byte
@@if_0:
	inc bx
	inc di
	inc ax
	jmp check_Left_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp check_Left_shape_array_byte
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
can_go_Left:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	call move_shape_Left_arr
	mov ax,1
	jmp EndIfLeft

can_not_go_Left:
	pop di
	push [CurrentShapeArr]
	call PutShapeOnBoard 
	mov ax,0
	jmp EndIfLeft

can_not_go_Left_Min_X:
	push [CurrentShapeArr]
	call PutShapeOnBoard
	mov ax,0
EndIfLeft:
	pop cx
	ret 
endp IfLeft

;================================================
; Description:its moves the shape Left in the array.
; INPUT:variables "CurrentShapeArr","GameBoard".
; OUTPUT:None.
; Register Usage: None.
;================================================
proc move_shape_Left_arr
	push ax
	push bx
	push di 
	
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
Left_shape_array_byte:
	cmp [byte ptr di],'$'
		JE end_move_Left_shape_arr
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push di
	mov di,bx
	dec di
	mov [byte ptr di],3 ;;;;;;;;;to move one x left
	pop di
	inc bx
	inc di
	inc ax
	jmp Left_shape_array_byte
	
@@if_0:
	inc bx
	inc di
	inc ax
	jmp Left_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp Left_shape_array_byte

end_move_Left_shape_arr:
	pop di 
	pop bx
	pop ax
	ret
endp move_shape_Left_arr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;;;;For the shape Right
;================================================
; Description:Its Moves the shape Right and puts it on the board.
; INPUT:variables of tetris.
; OUTPUT:The shape that moves on the screen.
; Register Usage: None.
;================================================	
proc ShapeRight
	push ax
	push bx
	push cx
	push dx
	push di
	
	push [CurrentShapeArr]
	call PutShapeOnBoard
Loop_Right:
	mov cx,9
	call IfRight
	cmp ax,0
	JE End_Loop_Right
Right_9_pixels:
	mov dx,[CurrentShape]
	inc [BmpLeft]
	call OpenShowBmp
	Loop Right_9_pixels
End_Loop_Right:

	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	
	ret 
endp ShapeRight

;================================================
; Description:its checks if the shape can go Right.
; INPUT:None.
; OUTPUT:ax = 1 if can go Left. ax = 0 if cant go Left.
; Register Usage: ax.
;================================================	
proc IfRight
	push cx 
	
	mov ax, [BmpLeft]
	add ax,[BmpWidth]
	cmp ax,219 ;;;to check if it reached the limit
	JE Max_X
	
	jmp @@can_go_Right
Max_X:
	jmp can_not_go_Right_Max_X

@@can_go_Right:
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
check_Right_shape_array_byte:
	cmp [byte ptr di],'$'
		JE can_go_Right
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	
	push di
	mov di,bx
	inc di
	cmp [byte ptr di],3 ;;;;;;it checks if there is a cube one for the left
	JE can_not_go_Right
	pop di
	
	inc bx
	inc di
	inc ax
	push [CurrentShapeArr]
	call PutShapeOnBoard
	jmp check_Right_shape_array_byte
@@if_0:
	inc bx
	inc di
	inc ax
	jmp check_Right_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp check_Right_shape_array_byte
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
can_go_Right:
	push [CurrentShapeArr]
	call remove_shape_from_arr
	call move_shape_Right_arr
	mov ax,1
	jmp EndIfRight

can_not_go_Right:
	pop di
	push [CurrentShapeArr]
	call PutShapeOnBoard 
	mov ax,0
	jmp EndIfRight
can_not_go_Right_Max_X:
	mov ax,0
	push [CurrentShapeArr]
	call PutShapeOnBoard 
EndIfRight:
	pop cx
	ret 
endp IfRight

;================================================
; Description:its moves the shape Right in the array.
; INPUT:variables "CurrentShapeArr","GameBoard".
; OUTPUT:None.
; Register Usage: None.
;================================================

proc move_shape_Right_arr
	push ax
	push bx
	push di 
	
	call FindCubeFirstPlace
	mov bx,offset GameBoard
	add bx,ax
	
	mov di,[CurrentShapeArr]
	
	mov ax,0
Right_shape_array_byte:
	cmp [byte ptr di],'$'
		JE end_move_Right_shape_arr
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	push di
	mov di,bx
	inc di
	mov [byte ptr di],3 ;;;;;;;;;to move one x Right
	pop di
	inc bx
	inc di
	inc ax
	jmp Right_shape_array_byte
	
@@if_0:
	inc bx
	inc di
	inc ax
	jmp Right_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp Right_shape_array_byte

end_move_Right_shape_arr:
	pop di 
	pop bx
	pop ax
	ret
endp move_shape_Right_arr																			
										
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;================================================
; Description:its puts the shape on the array of the game board.
; INPUT:offset of the shape array by pushing it.
; OUTPUT:None.
; Register Usage: None.
;================================================	
offset_arr equ [bp+4]
proc PutShapeOnBoard
	push bp
	mov bp,sp
	
	push ax
	push di
	push bx
	
	call FindCubeFirstPlace
	
	mov di,offset_arr
	
	mov bx,offset GameBoard
	add bx,ax
	
	
	;;ax is the counter when we want to go a line down
	mov ax,0
move_shape_array_byte:
	cmp [byte ptr di],'$'
		JE EndPutOnBoard
		
	cmp [byte ptr di],3
		JE if_3
	
	cmp [byte ptr di],0
		JE if_0
		
	cmp [byte ptr di],9
		JE if_9
		
if_3:
	mov [byte ptr bx],3d
	inc bx
	inc di
	inc ax
	jmp move_shape_array_byte
if_0:
	inc bx
	inc di
	inc ax
	jmp move_shape_array_byte

if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp move_shape_array_byte
	
EndPutOnBoard:
	pop bx
	pop di
	pop ax
	
	pop bp
	ret 2
endp PutShapeOnBoard

;================================================
; Description:Its removing the shape from array.
; INPUT:None.
; OUTPUT:None.
; Register Usage: 
;================================================	
offset_arr equ [bp+4]
proc remove_shape_from_arr
	push bp
	mov bp,sp
	
	push ax
	push di
	push bx
	
	call FindCubeFirstPlace
	
	mov di,offset_arr
	
	mov bx,offset GameBoard
	add bx,ax
	
	
	;;ax is the counter when we want to go a line down
	mov ax,0
remove_shape_array_byte:
	cmp [byte ptr di],'$'
		JE EndRemoveFromBoard
		
	cmp [byte ptr di],3
		JE @@if_3
	
	cmp [byte ptr di],0
		JE @@if_0
		
	cmp [byte ptr di],9
		JE @@if_9
		
@@if_3:
	mov [byte ptr bx],0
	inc bx
	inc di
	inc ax
	jmp remove_shape_array_byte
@@if_0:
	inc bx
	inc di
	inc ax
	jmp remove_shape_array_byte

@@if_9:
	add bx,11
	sub bx,ax
	mov ax,0
	inc di
	jmp remove_shape_array_byte
	
EndRemoveFromBoard:
	pop bx
	pop di
	pop ax
	
	pop bp
	ret 2
endp remove_shape_from_arr

;================================================
; Description:its finds in what place in the pame board array you need to put shapeArrays.
; INPUT:variables "BmpTop","BmpLeft".
; OUTPUT:The cube in the game board array from the screen.
; Register Usage: ax with the answer.
;================================================
proc FindCubeFirstPlace
	push dx
	push cx
	
	mov dl,9
	
	mov ax,[BmpTop]
	sub al,35
	;;;/9 because every cube is 9*9
	div dl
	add al,ah
	
	;;; to get it in cubes
	mov dl,11
	mul dl
	
	mov cl,al
	
	mov dl,9
	mov ax,[BmpLeft]
	sub ax,120
	div dl
	
	add al,cl
	
	xor ah,ah
	
	pop cx
	pop dx
	ret 
endp FindCubeFirstPlace

;================================================
; Description:Its chooses a shape randomly to game.
; INPUT:None.
; OUTPUT:None.
; Register Usage: 
;================================================									
proc NewShape
	mov[IfAsync],1
	
	cmp [CurrentShape],0
	JE FirstTime
	call MoveNextToCurrent
	call RandomNextShape
	jmp EndNewShape

FirstTime:
	call RandomCurrentShape
	call RandomNextShape

EndNewShape:
	call AddStatistics
	mov [IfAsync],0
	ret
endp NewShape

;================================================
; Description:Its chooses a shape randomly.
; INPUT:None.
; OUTPUT:None.
; Register Usage: ax,bx,dx
;================================================											
proc RandomCurrentShape
	mov bl,1
	mov bh,7 ;;the amount of shapes is 7 shapes
	call RandomByCs
	mov ah,0
	
	cmp ax,1
	JNE @@Not1
	jmp shape1
@@Not1:

	cmp ax,2
	JNE @@Not2
	jmp shape2
@@Not2:

	cmp ax,3
	JNE @@Not3
	jmp shape3
@@Not3:

	cmp ax,4
	JNE @@Not4
	jmp shape4
@@Not4:

	cmp ax,5
	JNE @@Not5
	jmp shape5
@@Not5:

	cmp ax,6
	JNE @@Not6
	jmp shape6
@@Not6:

	Jmp shape7

shape1:
	mov [CurrentShape],offset ZShape1
	mov [CurrentShapeArr],offset ZShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],27
	mov [BmpHeight],18
	jmp EndRandomShape 

shape2:
	mov [CurrentShape],offset SShape1
	mov [CurrentShapeArr],offset SShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],27
	mov [BmpHeight],18
	jmp EndRandomShape 

shape3:
	mov [CurrentShape],offset OShape
	mov [CurrentShapeArr],offset OShapeArray
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],18
	mov [BmpHeight],18
	jmp EndRandomShape 

shape4:
	mov [CurrentShape],offset LShape1
	mov [CurrentShapeArr],offset LShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],27
	mov [BmpHeight],18
	jmp EndRandomShape 

shape5:
	mov [CurrentShape],offset IShape1
	mov [CurrentShapeArr],offset IShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],36
	mov [BmpHeight],9
	jmp EndRandomShape 

shape6:
	mov [CurrentShape],offset JShape1
	mov [CurrentShapeArr],offset JShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],27
	mov [BmpHeight],18
	jmp EndRandomShape 

shape7:
	mov [CurrentShape],offset TShape1
	mov [CurrentShapeArr],offset TShape1Array
	mov [BmpTop],START_Y
	mov [BmpLeft],START_X
	mov [BmpWidth],27
	mov [BmpHeight],18
EndRandomShape:
	
	ret 
endp RandomCurrentShape

;================================================
; Description:Its chooses the next shape randomly.
; INPUT:None.
; OUTPUT:None.
; Register Usage: ax,bx,dx
;================================================		
proc RandomNextShape
	mov bl,1
	mov bh,7 ;;the amount of shapes is 7 shapes
	call RandomByCs
	mov ah,0
	
	cmp ax,1
	JNE Not1
	jmp @@Shape1
Not1:

	cmp ax,2
	JNE Not2
	jmp @@Shape2
Not2:

	cmp ax,3
	JNE Not3
	jmp @@Shape3
Not3:

	cmp ax,4
	JNE Not4
	jmp @@Shape4
Not4:

	cmp ax,5
	JNE @@Not5
	jmp @@shape5
@@Not5:

	cmp ax,6
	JNE @@Not6
	jmp @@shape6
@@Not6:

	Jmp @@shape7

@@shape1:
	;;To clear the area
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],15
	mov [UnDrawHeightNext],8

	call MoveCurrentToNext
	mov dx,offset ZChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],15
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset ZShape1
	mov [NextShapeArr],offset ZShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],27
	mov [NextBmpHeight],18
	jmp EndRandomNextShape

@@shape2:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],15
	mov [UnDrawHeightNext],8

	call MoveCurrentToNext
	mov dx,offset SChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],15
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset SShape1
	mov [NextShapeArr],offset SShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],27
	mov [NextBmpHeight],18
	jmp EndRandomNextShape

@@shape3:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],10
	mov [UnDrawHeightNext],8

	call MoveCurrentToNext
	mov dx,offset OChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],10
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset OShape
	mov [NextShapeArr],offset OShapeArray
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],18
	mov [NextBmpHeight],18
	jmp EndRandomNextShape

@@shape4:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],15
	mov [UnDrawHeightNext],8

	call MoveCurrentToNext
	mov dx,offset LChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],15
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset LShape1
	mov [NextShapeArr],offset LShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],27
	mov [NextBmpHeight],18
	jmp EndRandomNextShape

@@shape5:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],20
	mov [UnDrawHeightNext],4

	call MoveCurrentToNext
	mov dx,offset IChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],20
	mov [BmpHeight],4
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset IShape1
	mov [NextShapeArr],offset IShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],36
	mov [NextBmpHeight],9
	jmp EndRandomNextShape

@@shape6:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],15
	mov [UnDrawHeightNext],8
	call MoveCurrentToNext
	mov dx,offset JChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],15
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset JShape1
	mov [NextShapeArr],offset JShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],27
	mov [NextBmpHeight],18
	jmp EndRandomNextShape 

@@shape7:
	call UnDrawNext
	mov [UnDrawTopNext],START_C_Y
	mov [UnDrawLeftNext],START_C_X
	mov [UnDrawWidthNext],15
	mov [UnDrawHeightNext],8

call MoveCurrentToNext
	mov dx,offset TChart
	mov [BmpTop],START_C_Y
	mov [BmpLeft],START_C_X
	mov [BmpWidth],15
	mov [BmpHeight],8
	call OpenShowBmp
	call MoveNextToCurrent

	mov [NextShapeO],offset TShape1
	mov [NextShapeArr],offset TShape1Array
	mov [NextBmpTop],START_Y
	mov [NextBmpLeft],START_X
	mov [NextBmpWidth],27
	mov [NextBmpHeight],18
EndRandomNextShape:

	ret
endp RandomNextShape

;;To exchange between the variables of Current to next 
proc MoveCurrentToNext
	push ax
	push bx
	push cx
	push dx
	
	mov ax, [CurrentShape]
	mov [NextShapeO],ax
	
	mov bx,[BmpTop]
	mov [NextBmpTop],bx
	
	mov cx,[BmpLeft]
	mov [NextBmpLeft],cx
	
	mov dx,[BmpHeight]
	mov [NextBmpHeight],dx
	
	mov ax, [BmpWidth]
	mov [NextBmpWidth],ax
	
	mov ax,[CurrentShapeArr]
	mov [NextShapeArr],ax
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret 
endp MoveCurrentToNext

;;To exchange between the variables of next to current
proc MoveNextToCurrent
	push ax
	push bx
	push cx
	push dx
	
	mov ax, [NextShapeO]
	mov [CurrentShape],ax
	
	mov [BmpTop],START_Y
	
	mov [BmpLeft],START_X
	
	mov dx,[NextBmpHeight]
	mov [BmpHeight],dx
	
	mov ax, [NextBmpWidth]
	mov [BmpWidth],ax
	
	mov ax,[NextShapeArr]
	mov [CurrentShapeArr],ax
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret 
endp MoveNextToCurrent

;================================================
; Description:its adding one and prints the statistics of the shape that moves now in new Shape.
; INPUT:None.
; OUTPUT:the statistic of the shape that moves now.
; Register Usage:None.
;================================================
proc AddStatistics
	push ax
	push bx
	push dx
	
	mov ax,[CurrentShape]
	
	cmp ax,offset SShape1
	JNE @@Not1
	jmp @@Shape1
@@Not1:

	cmp ax,offset ZShape1
	JNE @@Not2
	jmp @@Shape2
@@Not2:

	cmp ax,offset LShape1
	JNE @@Not3
	jmp @@Shape3
@@Not3:

	cmp ax,offset JShape1
	JNE @@Not4
	jmp @@Shape4
@@Not4:

	cmp ax,offset OShape
	JNE @@Not5
	jmp @@shape5
@@Not5:

	cmp ax,offset TShape1
	JNE @@Not6
	jmp @@shape6
@@Not6:

	Jmp @@shape7 ;;IShape

@@shape1:
	inc [StatisticSShape]
	mov dh,15
	mov dl,6
	mov ax,[StatisticSShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape2:
	inc [StatisticZShape]
	mov dh,11
	mov dl,6
	mov ax,[StatisticZShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape3:
	inc [StatisticLShape]
	mov dh,19
	mov dl,6
	mov ax,[StatisticLShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape4:
	inc [StatisticJShape]
	mov dh,21
	mov dl,6
	mov ax,[StatisticJShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape5:
	inc [StatisticOShape]
	mov dh,17
	mov dl,6
	mov ax,[StatisticOShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape6:
	inc [StatisticTShape]
	mov dh,13
	mov dl,6
	mov ax,[StatisticTShape]
	call ShowNumOnScreen
	jmp End_Add_Statistics

@@shape7:
	inc [StatisticIShape]
	mov dh,9
	mov dl,6
	mov ax,[StatisticIShape]
	call ShowNumOnScreen	
	
End_Add_Statistics:
	mov dh,7
	mov dl,31
	inc [Score]
	mov ax,[Score]
	call ShowNumOnScreen

	pop dx
	pop bx
	pop ax
	ret
endp AddStatistics

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									;;screens procs (omer)
;================================================
; Description:its writing the num in ax at the place you have asked.
; INPUT:ax = num DL=X, DH=Y.
; OUTPUT:clearing the area.
; Register Usage:None
;================================================
proc ShowNumOnScreen
	PUSH_ALL
	call set_cursor
	xor cx,cx
	mov bx,10
	mov dx,0

	mov cx,0   ; will count how many time we did push 
	mov bx,10  ; the divider

@@put_mode_to_stack:
	xor dx,dx
	div bx
	add dl,30h
	; dl is the current LSB digit 
	; we cant push only dl so we push all dx
	push dx    
	inc cx
	cmp ax,9   ; check if it is the last time to div
	jg @@put_mode_to_stack

	cmp ax,0
	jz @@pop_next  ; jump if ax was totally 0
	add al,30h  
	mov dl, al    
	mov ah, 2h
	int 21h        ; show first digit MSB
	   
@@pop_next: 
	pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	mov dl, al
	mov ah, 2h
	int 21h        ; show all rest digits
	loop @@pop_next

	POP_ALL
	ret
endp ShowNumOnScreen									
																			
;================================================
; Description:its writing black pixels in the screen the way you have asked.
; INPUT:The variables UnDrawHeight,UnDrawLeft,UnDrawTop and UnDrawWidth.
; OUTPUT:clearing the area.
; Register Usage:None
;================================================	
proc UnDrawNext
	push ax
	push bx
	push cx
	push dx
	push di
	
	mov al,0 ;;The color black
	mov di,[UnDrawHeightNext] ;;The height of the Undraw
	mov ah,0ch
	mov dx, [UnDrawTopNext] ;;The Y start
DrawBlackHeightNext:
	cmp di,0
	JE EndHeightNext
	mov bx,[UnDrawWidthNext]
	mov cx,[UnDrawLeftNext]		;; The X start
DrawBlackWidthNext:
	cmp bx,0
	JE EndWidthNext
	int 10h
	inc cx
	dec bx
	jmp DrawBlackWidthNext
EndWidthNext:
	dec di
	inc dx
	jmp DrawBlackHeightNext
EndHeightNext:


	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp UnDrawNext

;================================================
; Description:its writing black pixels in the screen the way you have asked.
; INPUT:The variables UnDrawHeightLine,UnDrawLeftLine,UnDrawTopLine and UnDrawWidthLine.
; OUTPUT:clearing the area.
; Register Usage:None
;================================================	
proc UnDraw
	push ax
	push bx
	push cx
	push dx
	push di
	
	mov al,0 ;;The color black
	mov di,[UnDrawHeight] ;;The height of the Undraw
	mov ah,0ch
	mov dx, [UnDrawTop] ;;The Y start
DrawBlackHeight:
	cmp di,0
	JE EndHeight
	mov bx,[UnDrawWidth]
	mov cx,[UnDrawLeft]		;; The X start
DrawBlackWidth:
	cmp bx,0
	JE EndWidth
	int 10h
	inc cx
	dec bx
	jmp DrawBlackWidth
EndWidth:
	dec di
	inc dx
	jmp DrawBlackHeight
EndHeight:


	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp UnDraw


;================================================
; Description:its writing black pixels in the screen instead of the bmp pic.
; INPUT:The variables of OpenShowBmp.
; OUTPUT:clearing the area of the bmp file.
; Register Usage:None.
;================================================
proc UnDrawBmp
	mov [IfAsync],0
	;;;cli
	mov [ErrorFile],0
	
	mov dx,[CurrentShape]
	
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call UnShowBMP
	
	 
	call CloseBmpFile

@@ExitProc:
	mov [IfAsync],1
	;;sti
	ret
endp UnDrawBmp


proc UnShowBMP
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpHeight lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
 
	mov ax,[BmpWidth] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	mov bp, 0
	and ax, 3
	jz @@row_ok
	mov bp,4
	sub bp,ax

@@row_ok:	
	mov cx,[BmpHeight]
    dec cx
	add cx,[BmpTop] ; add the Y on entire screen
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	mov di,cx
	shl cx,6
	shl di,8
	add di,cx
	add di,[BmpLeft]
	cld ; Clear direction flag, for movsb forward
	
	mov cx, [BmpHeight]
@@NextLine:
	push cx
 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpWidth]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory es:di
	mov cx,[BmpWidth]  
	mov si,offset ScrLine
	
	
;rep movsb ; Copy line to the screen
 @@DRAWLINE:
    
    cmp [byte ptr si], 0B7h ;;its the color we don't want to copy to screen
    jnz @@NOTCHARACTER
	    
    inc si
    inc di
    jmp @@SkipPixel
    
@@NOTCHARACTER:
	
    mov [byte ptr es:di],0 ; Copy line to the screen
    inc Si
	inc di
	
@@SkipPixel:
    loop @@DRAWLINE	

	sub di,[BmpWidth]    ; return to left bmp
	sub di,SCREEN_WIDTH  ; jump one screen line up
	
	pop cx
	loop @@NextLine
	
	pop cx
	ret
endp UnShowBMP

;;To print the first image in the game of Tetris
proc PrintTetris
    push dx
	call SetGraphic
    mov dx, offset TetrisScreen
    mov [BmpLeft],0
    mov [BmpTop],0
    mov [BmpWidth], 320
    mov [BmpHeight] ,200
    call OpenShowBmp    
    
    pop dx
    ret
endp PrintTetris
    
;;To print the tetris chart in game
proc PrintChart
    push dx
	push ax
	
    mov dx, offset TetrisChart
    mov [BmpLeft],0
    mov [BmpTop],0
    mov [BmpWidth], 320
    mov [BmpHeight] ,200
    call OpenShowBmp
    
    mov dx, offset IChart
    mov [BmpLeft],22
    mov [BmpTop],72
    mov [BmpWidth], 20
    mov [BmpHeight] ,4
    call OpenShowBmp
	
	mov dh,9
	mov dl,6
	mov ax,[StatisticIShape]
	call ShowNumOnScreen
    
    mov dx, offset ZChart
    mov [BmpLeft],22
    mov [BmpTop],87
    mov [BmpWidth], 15
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,11
	mov dl,6
	mov ax,[StatisticZShape]
	call ShowNumOnScreen
    
    mov dx, offset TChart
    mov [BmpLeft],22
    mov [BmpTop],102
    mov [BmpWidth], 15
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,13
	mov dl,6
	mov ax,[StatisticTShape]
	call ShowNumOnScreen
    
    
    mov dx, offset SChart
    mov [BmpLeft],22
    mov [BmpTop],120
    mov [BmpWidth], 15
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,15
	mov dl,6
	mov ax,[StatisticSShape]
	call ShowNumOnScreen
    
    mov dx, offset OChart
    mov [BmpLeft],22
    mov [BmpTop],135
    mov [BmpWidth], 10
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,17
	mov dl,6
	mov ax,[StatisticOShape]
	call ShowNumOnScreen
    
    mov dx, offset LChart
    mov [BmpLeft],22
    mov [BmpTop],153
    mov [BmpWidth], 15
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,19
	mov dl,6
	mov ax,[StatisticLShape]
	call ShowNumOnScreen
    
    mov dx, offset JChart
    mov [BmpLeft],22
    mov [BmpTop],170
    mov [BmpWidth], 15
    mov [BmpHeight] ,8
    call OpenShowBmp
	
	mov dh,21
	mov dl,6
	mov ax,[StatisticJShape]
	call ShowNumOnScreen
    
	mov dh,7
	mov dl,31
	mov ax,[Score]
	call ShowNumOnScreen
	
	mov dh,2
	mov dl,24
	xor ax,ax
	mov al,[Lines]
	call ShowNumOnScreen
	
	mov dh,44
	mov dl,24
	xor ax,ax
	mov al,[Level]
	call ShowNumOnScreen
	
	pop ax
    pop dx
    ret
endp PrintChart
    
;;;To set back to text mode from graphic
proc SetText
    push ax
    
    mov ax,2  ;;For text mode 
    int 10h
    
    pop ax
    ret
endp SetText

;;;To "clean" the screen and make all black
proc CleanScreen
    push cx
    push ax
    push es
    push di
    
    mov cx,32000 ;;The amount of pixels (its in words and not bytes)
    mov ax, 0a000h
    mov es,ax
    mov di,0
@@NextWord:
    mov [word es:di],0
    add di,2
    loop @@NextWord
    
    pop di
    pop es
    pop ax
    pop cx
    ret
endp CleanScreen

;;it sets the cursor position
;INPUT : DL=X, DH=Y.
proc set_cursor
	PUSH_ALL
     mov  ah, 2                  
     mov  bh, 0                 
     int  10h  
	POP_ALL
      ret
endp set_cursor 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                ;ShowBmp

proc OpenShowBmp near
	mov [IfAsync],0
	;;;cli
	mov [ErrorFile],0
	
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call ShowBMP
	
	 
	call CloseBmpFile

@@ExitProc:
	mov [IfAsync],1
	;;sti
	ret
endp OpenShowBmp

 
 
	
; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile
 

proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile


; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near					
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette
 
   
proc  SetGraphic
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic

 

 
 
proc ShowBMP
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpHeight lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
 
	mov ax,[BmpWidth] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	mov bp, 0
	and ax, 3
	jz @@row_ok
	mov bp,4
	sub bp,ax

@@row_ok:	
	mov cx,[BmpHeight]
    dec cx
	add cx,[BmpTop] ; add the Y on entire screen
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	mov di,cx
	shl cx,6
	shl di,8
	add di,cx
	add di,[BmpLeft]
	cld ; Clear direction flag, for movsb forward
	
	mov cx, [BmpHeight]
@@NextLine:
	push cx
 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpWidth]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory es:di
	mov cx,[BmpWidth]  
	mov si,offset ScrLine
	
	
;rep movsb ; Copy line to the screen
 @@DRAWLINE:
    
    cmp [byte ptr si], 0B7h ;;its the color we don't want to copy to screen
    jnz @@NOTCHARACTER
    
    inc si
    inc di
    jmp @@DontDraw
    
@@NOTCHARACTER:
    
    movsb ; Copy line to the screen
    
@@DontDraw:
    loop @@DRAWLINE	
	
	
	sub di,[BmpWidth]    ; return to left bmp
	sub di,SCREEN_WIDTH  ; jump one screen line up
	
	pop cx
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
									;;delay procs
;================================================
; Description:its waiting delay as you have pushed.
; INPUT:by pushing the amount of Delay miliseconds you want.
; OUTPUT:None.
; Register Usage:None.
;================================================
	MicroSec equ [bp+4]			
proc Delay
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	
	mov cx,MicroSec ;;the amount of micro seconds
Loop_MiliSecond:
	push cx
	mov cx, 15000           ; Adjust this value based on your environment
delay_loop:
    nop                   ; No operation (single clock cycle)
    loop delay_loop
	pop cx
	Loop Loop_MiliSecond
	
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp 
	ret 2
endp Delay



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											;;Random

; Description  : get RND between any bl and bh includs (max 0 -255)
; Input        : 1. Bl = min (from 0) , BH , Max (till 255)
; 			     2. RndCurrentPos a  word variable,   help to get good rnd number
; 				 	Declre it at DATASEG :  RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        Al - rnd num from bl to bh  (example 50 - 150)
; More Info:
; 	Bl must be less than Bh 
; 	in order to get good random value again and agin the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second  - 
; 	Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCs
    push es
	push si
	push di
	push cx
	 
	
	
	mov ax, 40h
	mov	es, ax
	
	sub bh,bl  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp bh,0
	jz @@ExitP
 
	mov di, [word RndCurrentPos]
	call MakeMask ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
RandLoop: ;  generate random number 
	mov ax, [es:06ch] ; read timer counter
	mov ah, [byte cs:di] ; read one byte from memory (from semi random byte at cs)
	
	xor al, ah ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(EndOfCsLbl - start - 1)
	jb @@Continue
	mov di, offset start
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	cmp al,bh    ;do again if  above the delta
	ja RandLoop
	
	add al,bl  ; add the lower limit to the rnd num
		 
@@ExitP:
	pop cx
	pop di
	pop si
	pop es
	ret
endp RandomByCs

; make mask acording to bh size 
; output Si = mask put 1 in all bh range
; example  if bh 4 or 5 or 6 or 7 si will be 7
; 		   if Bh 64 till 127 si will be 127
Proc MakeMask    
    push bx
	mov si,1
@@again:
	shr bh,1
	cmp bh,0
	jz @@EndProc
	shl si,1 ; add 1 to si at right
	inc si
	jmp @@again
@@EndProc:
    pop bx
	ret
endp  MakeMask

EndOfCsLbl:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
										;;;;;AsyncKB
proc setKeyboradInterrupt
	mov ax,keyboardInterruptPOS
	mov bx,offset currentInterruptPOS
	mov [word ptr bx],ax
	mov bx,offset currentInterruptOFFSET
	mov ax,offset KeyboardInterrupt
	mov [word ptr bx],ax
	
	call SetInterrupt          
	
	mov bx,offset CurrentOldInterruptOffset
	mov ax,[word ptr bx]
	mov bx,offset OldKeyboardInterruptOffset
	mov [word ptr bx],ax
	mov bx,offset CurrentOldInterruptSegment
	mov ax,[word ptr bx]
	mov bx,offset OldKeyboardInterruptSegment
	mov [word ptr bx],ax 
	ret 
endp 	setKeyboradInterrupt



proc restoreKeyboradInterrupt
	mov bx,offset OldKeyboardInterruptOffset
	mov ax,[word ptr bx]
	mov bx,offset CurrentOldInterruptOffset
	mov [word ptr bx],ax
	mov bx,offset OldKeyboardInterruptSegment
	mov ax,[word ptr bx]
	mov bx,offset CurrentOldInterruptSegment
	mov [word ptr bx],ax 
	mov ax,keyboardInterruptPOS
	mov bx,offset currentInterruptPOS
	mov [word ptr bx],ax
	call RestoreOldInterrupt	
	ret
endp restoreKeyboradInterrupt
	
	
proc SetInterrupt
	pusha
	push es
	push si
	mov ax,0
	mov es,ax
	
	xor ax,ax
	mov bx,offset currentInterruptPOS 
	mov al,[byte ptr bx]
	mov si,ax
	mov dx,[word ptr es:si]
	mov cx,[word ptr es:si+2]
	
	mov bx,offset CurrentOldInterruptOffset
	mov [word ptr bx],dx       
	mov bx,offset CurrentOldInterruptSegment  
	mov [word ptr bx],cx       
	cli       
	mov bx,offset currentInterruptOFFSET	       
	mov ax,[word ptr bx]
	mov cx,0
	mov es,cx	
	mov [word ptr es:si],ax
	mov ax,cs
	mov [word ptr es:si+2],ax
	pop si
	pop es
	sti                ; set interrupt flag        
	popa
ret
endp SetInterrupt

proc RestoreOldInterrupt
	pusha
	push es
	mov ax,0
	mov es,ax
	
	cli     ; clear interupt flag
	mov bx,offset CurrentOldInterruptOffset    
	mov ax,[word ptr bx]
	mov bx,offset currentInterruptPOS 	
	xor cx,cx
	mov cl,[byte ptr bx]
	mov si,cx
	mov [word ptr es: si],ax
	mov bx,offset CurrentOldInterruptSegment     
	mov ax,[word ptr bx]
	mov [word ptr es: si+2],ax
	sti     ; set interrupt flag
	pop es
	popa
    ret
endp RestoreOldInterrupt
 
  
proc KeyboardInterrupt  far
	pusha
	push ds

	in al,60h
	
	
	cmp al, 0E0h
	jnz @@cont
	mov [byte extendedKey],1
@@cont:
	cmp al,1
	je c1
	inc al
c1:	
	mov [key_pressed],al
	
	
	call show_key   ; do somthing with the key
	
	cmp [byte key_pressed], 0E0h
	jz @@cont2
	mov [byte extendedKey],0

@@cont2:	
	jmp exitKeyboardInt
	  
	  
	  
exitKeyboardInt:
	push ax        
	mov al,20h  ; EOI end  of interupt
	out 20h,AL                
	pop ax
	sti	
	pop ds
	popa
	iret
endp KeyboardInterrupt
 

 
proc show_key
	
	push dx

@@cont2:
	
	mov al,[key_pressed]
	
check_exit:
	mov ah,0   ; any other key
	cmp [IfAsync],0
	JE After
	
	cmp al,76
	JNE dont_call_Left
	call ShapeLeft
	jmp After
dont_call_Left:

	cmp al,78
	JNE dont_call_Right
	call ShapeRight
	jmp After
dont_call_Right:

	cmp al,58
	JNE dont_call_rotate
	call RotateShape
	jmp After
dont_call_rotate:

	cmp al,81
	JNE dont_call_AllTheWayDown
	call AllTheWayDown
dont_call_AllTheWayDown:	
		
After:
	pop dx
	 

	ret
endp show_key
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

END start