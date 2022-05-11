
/*--parametros:

r0: el contador
r1: nuestro array
salidas:
r0: Longitud de palabra


-*/


.text
.align 2
.global ContarLetras
ContarLetras:
    ldrb r2,[r1],#1
	cmp r2,#0 @@verficiar si ya ha llegado al final del array
	addne r0,#1
	bne ContarLetras
    mov pc,lr
