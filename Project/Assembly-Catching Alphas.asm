;M Waiz Shabbir 22L-6991
;Ateefa Hafeez 22L-6866

[org 0x0100]

jmp start

oldisr : dd 0
oldtime : dd 0
pos: dw 3586
leftlim: dw 3522
rightlim: dw 3650
arr db 'Won : '
arr1 db 'Lost : '
won : dw 0
lost : dw 0
ticks1 : dw 0
ticks2 : dw 0
ticks3 : dw 0
ticks4 : dw 0
ticks5 : dw 0
ticks6 : dw 0
col1 dw 2   ;y position pe updated variable
col2 dw 38
col3 dw 74
col4 dw 108
col5 dw 130
col6 dw 20
col7 dw 50
col1x dw 2  ; x position ka updated variable
col2x dw 38
col3x dw 74
col4x dw 108
col5x dw 130
col6x dw 20
col7x dw 50
rand: dw 0
randnum: dw 0
char1 dw 0   ; character got from randG
char2 dw 0
char3 dw 0
char4 dw 0
char5 dw 0
char6 dw 0
char7 dw 0
com1 dw 0    ;comparison for getting new char after loosing first
com2 dw 0
com3 dw 0
com4 dw 0
com5 dw 0
com6 dw 0
com7 dw 0
message: db 'GAME OVER!!!',0
iwantmore: dw 0

;*******************************************
;for effeciency
delay: 
pusha
    mov cx, 30

d1: 
    mov ax, 0
    push cx
    mov cx, 20

d2: 
    mov bx, 1
    loop d2

    pop cx
    loop d1

    popa
    ret

clear:
push bp
mov bp,sp
push ax
push es
push di
mov ax, 0xB800
mov es,ax
mov di,0

nextchar:
	call delay
    mov word [es: di],0x0720
	add di,2
	cmp di,4000
	jne nextchar
pop di
pop es
pop ax
pop bp
ret

;*************************************************
;to print gameover
printstr: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 push ds 
 pop es 
 mov di, [bp+4]
 mov cx, 0xffff 
 xor al, al 
 repne scasb 
 mov ax, 0xffff 
 sub ax, cx 
 dec ax  
 jz exiteee
 mov cx, ax 
 mov ax, 0xb800 
 mov es, ax  
 mov al, 80  
 mul byte [bp+8] 
 add ax, [bp+10]  
 shl ax, 1 
 mov di,ax  
 mov si, [bp+4] 
 mov ah, [bp+6] 
 cld  
nextchar1: 
 lodsb  
 stosw  
 loop nextchar1 
exiteee: pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 8
;***************************************************
;to print score
printnum: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 mov ax, [bp+4]
 mov bx, 10
 mov cx, 0
nextdigit: 
 mov dx, 0
 div bx  
 add dl, 0x30
 push dx 
 inc cx
 cmp ax, 0
 jnz nextdigit 
 mov di, [bp+6]
 nextpos: 
 pop dx
 mov dh, 0x07
 mov [es:di], dx 
 add di, 2 
 loop nextpos
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
 pop es 
 pop bp 
 ret 4 
;*************************************************
clrscr:
push di
push ax
push es
mov ax,0xb800
mov es,ax
mov di,0
next:
mov word [es:di],0x0720
add di,2
cmp di,4000
jne next

pop es
pop ax
pop di
ret
;*************************************************

randG:
   push bp
   mov bp, sp
   pusha
   cmp word [rand], 0
   jne next2

  MOV     AH, 00h   ; interrupt to get system timer in CX:DX 
  INT     1AH
  inc word [rand]
  mov     [randnum], dx
  jmp next1

  next2:
  mov     ax, 25173          ; LCG Multiplier
  mul     word  [randnum]     ; DX:AX = LCG multiplier * seed
  add     ax, 13849          ; Add LCG increment value
  ; Modulo 65536, AX = (multiplier*seed+increment) mod 65536
  mov     [randnum], ax          ; Update seed = return value

 next1:xor dx, dx
 mov ax, [randnum]
 mov cx, [bp+4]
 inc cx
 div cx
 
 mov [bp+6], dx
 popa
 pop bp
 ret 2
;********************************************************
timer1:
pusha
push es


mov ax,0xb800
mov es,ax
;-------------------------;

inc word[cs:ticks1]
cmp word[cs:ticks1],6
jne column1half

mov word[cs:ticks1],0

mov dx,[com1]
cmp dx,0
jne hehe1
sub sp,2
push 25
call randG
pop dx
mov dh,0x02
add dx,'A'
mov word[char1],dx
hehe1:
mov ax,[char1]
inc word[com1]

mov si,[col1]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck1

inc word[lost]

mov bx,[col1x]
add bx,120
cmp bx,130
jl addd
sub bx,128
addd:
mov word[col1],bx
mov word[com1],0

push 308
push word[lost]
call printnum
jmp column2

column1half:
jmp column2

nextcheck1:
mov bh,0xDC
cmp bl,bh
jne sheet1

inc word[won]
mov bx,[col1x]
add bx,10
cmp bx,130
jl addd1
sub bx,100
addd1:
mov word[col1],bx
mov word[com1],0
push 146
push word[won]
call printnum
jmp column2

sheet1:
add word[col1],160
mov si,[col1]
mov [es: si],ax
jmp column2
;-------------------------;
column2:

inc word[cs:ticks2]
cmp word[cs:ticks2],8
jne column2half

mov word[cs:ticks2],0

mov dx,[com2]
cmp dx,0
jne hehe2
sub sp,2
push 25
call randG
pop dx
mov dh,0x03
add dx,'A'
mov word[char2],dx
hehe2:
mov ax,[char2]
inc word[com2]

mov si,[col2]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck2

inc word[lost]
mov bx,[col2x]
add bx,10
cmp bx,130
jl addd2
sub bx,100
addd2:
mov word[col2],bx
mov word[com2],0
push 308
push word[lost]
call printnum
jmp column3

column2half:
jmp column3

nextcheck2:
mov bh,0xDC
cmp bl,bh
jne sheet2

inc word[won]
mov bx,[col2x]
add bx,10
cmp bx,130
jl addd3
sub bx,100
addd3:
mov word[col2],bx
mov word[com2],0
push 146
push word[won]
call printnum
jmp column3

sheet2:
add word[col2],160
mov si,[col2]
mov [es: si],ax
jmp column3

;---------------------------------;

column3:

inc word[cs:ticks3]
cmp word[cs:ticks3],12
jne column3half

mov word[cs:ticks3],0

mov dx,[com3]
cmp dx,0
jne hehe3
sub sp,2
push 25
call randG
pop dx
mov dh,0x04
add dx,'A'
mov word[char3],dx
hehe3:
mov ax,[char3]
inc word[com3]

mov si,[col3]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck3

inc word[lost]
mov bx,[col3x]
add bx,20
cmp bx,130
jl addd4
sub bx,100
addd4:
mov word[col3],bx
mov word[com3],0
push 308
push word[lost]
call printnum
jmp column4

column3half:
jmp column4

nextcheck3:
mov bh,0xDC
cmp bl,bh
jne sheet3

inc word[won]
mov bx,[col3x]
add bx,20
cmp bx,130
jl addd5
sub bx,100
addd5:
mov word[col3],bx
mov word[com3],0
push 146
push word[won]
call printnum
jmp column4

sheet3:
add word[col3],160
mov si,[col3]
mov [es: si],ax
jmp column4

;---------------------------------;
column4:

inc word[cs:ticks4]
cmp word[cs:ticks4],4
jne column4half

mov word[cs:ticks4],0

mov dx,[com4]
cmp dx,0
jne hehe4
sub sp,2
push 25
call randG
pop dx
mov dh,0x05
add dx,'A'
mov word[char4],dx
hehe4
mov ax,[char4]
inc word[com4]

mov si,[col4]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck4

inc word[lost]
mov bx,[col4x]
add bx,20
cmp bx,130
jl addd6
sub bx,100
addd6:
mov word[col4],bx
mov word[com4],0
push 308
push word[lost]
call printnum
jmp column5

column4half:
jmp column5

nextcheck4:
mov bh,0xDC
cmp bl,bh
jne sheet4

inc word[won]
mov bx,[col4x]
add bx,20
cmp bx,130
jl addd7
sub bx,100
addd7:
mov word[col4],bx
mov word[com4],0
push 146
push word[won]
call printnum
jmp column5

sheet4:
add word[col4],160
mov si,[col4]
mov [es: si],ax
jmp column5

;---------------------------------;

column5:

inc word[cs:ticks5]
cmp word[cs:ticks5],9
jne column5half2

mov word[cs:ticks5],0

mov dx,[com5]
cmp dx,0
jne hehe5
sub sp,2
push 25
call randG
pop dx
mov dh,0x09
add dx,'A'
mov word[char5],dx
hehe5:
mov ax,[char5]
inc word[com5]

mov si,[col5]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck5

inc word[lost]
mov bx,[col5x]
add bx,6
cmp bx,130
jl addd8
sub bx,100
addd8:
mov word[col5],bx
mov word[com5],0
push 308
push word[lost]
call printnum
jmp column6

column5half2:
jmp column6

nextcheck5:
mov bh,0xDC
cmp bl,bh
jne sheet5

inc word[won]
mov bx,[col5x]
add bx,6
cmp bx,130
jl addd11
sub bx,100
addd11:
mov word[col5],bx
mov word[com5],0
push 146
push word[won]
call printnum
jmp column6

sheet5:
add word[col5],160
mov si,[col5]
mov [es: si],ax
jmp column6

;---------------------------------;

column6:

inc word[cs:ticks6]
cmp word[cs:ticks6],18
jne column6half2

mov word[cs:ticks6],0

mov dx,[com6]
cmp dx,0
jne hehe6
sub sp,2
push 25
call randG
pop dx
mov dh,0x01
add dx,'A'
mov word[char6],dx
hehe6:
mov ax,[char6]
inc word[com6]

mov si,[col6]
mov word[es: si],0x720
mov bx,[es:si + 160]

mov bh,'|'
cmp bl,bh
jne nextcheck6

inc word[lost]
mov bx,[col6x]
add bx,6
cmp bx,130
jl addd9
sub bx,100
addd9:
mov word[col6],bx
mov word[com6],0
push 308
push word[lost]
call printnum
jmp exit

column6half2:
jmp exit

nextcheck6:
mov bh,0xDC
cmp bl,bh
jne sheet6

inc word[won]
mov bx,[col6x]
add bx,6
cmp bx,130
jl addd10
sub bx,100
addd10:
mov word[col6],bx
mov word[com6],0
push 146
push word[won]
call printnum
jmp exit

sheet6:
add word[col6],160
mov si,[col6]
mov [es: si],ax
jmp exit

;---------------------------------;


exit:
mov al,0x20
out 0x20,al

pop es
popa
iret

;*************************************************

unhooktime:
pusha 
mov ax,[oldtime]
mov bx,[oldtime + 2]
cli
mov [es: 8*4], ax
mov [es: 8*4 + 2], bx
sti
popa
ret

;**************************************************
unhookkey:
pusha
mov ax,[oldisr]
mov bx,[oldisr + 2]
cli
mov [es: 9*4], ax
mov [es: 9*4 + 2], bx
sti
popa
ret

;**************************************************
kbisr:
push es
push ax
push bx
push cx
push di

mov ax,0xb800
mov es,ax

in al,0x60
cmp al,0x4B   ;Left
jne right

mov bx,[pos]
mov dx,[leftlim]
cmp bx,dx
jle outofloop

sub word[pos],2
mov di,[pos]
mov al,0xDC
mov ah,0x07
mov word[es:di],ax
add di,2
mov word [es:di],0x0720

    right:
         cmp al,0x4D
         jne outofloop
         
         mov bx,[pos]
         mov dx,[rightlim]
         cmp bx,dx
         jge outofloop
         add word[pos],2
         mov di,[pos]
         mov al,0xDC
         mov ah,0x07
         mov word[es:di],ax
         sub di,2
         mov word [es:di],0x0720

         outofloop:
              mov al,0x20
              out 0x20,al
              pop di
              pop cx
              pop bx
              pop ax
              pop es
              iret
       
;************************************************* 
interface:

push ax
push es
push di
push cx

mov ax,0xb800
mov es,ax
mov al,'|'
mov ah,0x06

mov di,132
mov cx,3812

loop2:
mov [es:di],ax
add di,160
cmp di,cx
jl loop2

mov di,3812
mov cx,3680

loop3:
mov [es:di],ax
sub di,2
cmp di, cx
jg loop3

mov di,3680
mov cx,0

loop4:
mov [es:di],ax
sub di,160
cmp di,cx
jg loop4

call print

pop cx
pop di
pop es
pop ax

ret
print:

push es
push ax
push si
push di

mov ax,0xb800
mov es,ax
mov di,134
mov si,0
mov ah,0x07

nextc:
mov al,[arr + si]
mov [es:di],ax
add di,2
add si,1
cmp si,6
jl nextc


mov di,294
mov si,0

nextc1:
mov al,[arr1 + si]
mov [es:di],ax
add di,2
add si,1
cmp si,7
jl nextc1

pop di
pop si
pop ax
pop es


ret

start:
call clrscr
call interface

xor ax,ax
mov es,ax
mov ax,[es:9*4]
mov [oldisr],ax
mov ax,[es:9*4 + 2]
mov [oldisr + 2],ax
mov ax,[es:8*4]
mov [oldtime],ax
mov ax,[es:8*4 +2]
mov [oldtime +2],ax

cli
mov word[es: 9*4] ,kbisr
mov [es:9*4+2],cs
mov word[es: 8*4] ,timer1
mov [es:8*4+2],cs
sti



l12:
    mov bx,[lost]
    cmp bx,10
    jl l12

call unhooktime
call unhookkey

call clear

 mov ax, 30 
 push ax 
 mov ax, 10 
 push ax 
 mov ax, 4 
 push ax 
 mov ax, message 
 push ax 
 call printstr


mov ax,0x4c00
int 21h