/*--Conteo de las vocales de la palabra--*/
/*--parametros:
r0:contador
r1:arreglo
salidas:
r0: cantidad de palabras
-*/
.text
.align 2
.global ContarVocales
ContarVocales:
	@SSe guarda la direccion en r5
	@@Se carga la nueva dirección en r1
    @@Se hace un offset de 1 bytes a r5
	ldrb r2,[r1],#1
	@si es una vocal aumentar contador
	cmp r2,#'a'
	addeq r0,#1
	cmp r2,#'A'
	addeq r0,#1
	cmp r2,#'e'
	addeq r0,#1
	cmp r2,#'E'
	addeq r0,#1
	cmp r2,#'i'
	addeq r0,#1
	cmp r2,#'I'
	addeq r0,#1
	cmp r2,#'o'
	addeq r0,#1
	cmp r2,#'O'
	addeq r0,#1
	cmp r2,#'u'
	addeq r0,#1
	cmp r2,#'U'
	addeq r0,#1
	cmp r2,#0  @verficiar si ya ha llegado al final del array
	bne ContarVocales
    mov pc,lr