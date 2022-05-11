/*--Comparar primera y ultima letra de la palabra--*/
/*--parametros:
r0:punteo
r1:nombre
r2:apellido
r3:longitud nombre
r4: longitud de apellido
salidas:
r0: 1 condicion cumplida , 0 no cumplida
-*/
.text
.align 2
.global CompararLetras
CompararLetras:
	@letras inicial y final 
    ldrb r6,[r1]
    ldrb r5,[r2]
	cmp r6,r5 @compara el primer valor si son iguales realizar la segunda comparacion
	beq last_letter
    mov pc,lr

last_letter: 
	@decrementar en 1 el tamaño de palabras
	sub r3,#1
	sub r4,#1
	add r1,r3
	add r2,r4
	@comparar las letras, si son iguales aumentar el conteo
	ldrb r1,[r1]
	ldrb r2,[r2]
	cmp r1,r2
	addeq r0,#1
    mov pc,lr
