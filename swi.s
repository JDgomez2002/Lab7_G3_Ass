@Laboratorio 6
@Grupo 3
@Melanie Maldonado
@Gonzalo Santizo
@Melanie
@Jose Daniel Gomez

	.text
	.align		2
	@@ etiqueta "main" llama a la funcion global
	.global		main
	.func ContarLetras
	.type		main, %function

main:
	stmfd	sp!, {lr}


  @@ Imprimir menu

  MOV R7, #4		@4=llamado a "write" swi
  MOV R0, #1		@1=stdout (monitor)
  MOV R2, #163		@longitud de la cadena: 167 caracteres
  LDR R1, =menu	@apunta a la cadena
  SWI 0

  @@ Imprimir nombre

  MOV R7, #4		@4=llamado a "write" swi
  MOV R0, #1		@1=stdout (monitor)
  MOV R2, #16		@longitud de la cadena: 167 caracteres
  LDR R1, =ingrese_nombre	@apunta a la cadena
  SWI 0

  @@ ingresar nombre:

  MOV R7, #3 @3=llamado a "read" swi
  MOV R0, #0 @1=stdout (teclado)
  MOV R2, #19 @long cadena: 10 caracteres
  LDR R1, =nombre_valor @apunta a la etiqueta donde
  SWI 0


  @@ Imprimir apellido

  MOV R7, #4		@4=llamado a "write" swi
  MOV R0, #1		@1=stdout (monitor)
  MOV R2, #19		@longitud de la cadena: 167 caracteres
  LDR R1, =ingrese_apellido	@apunta a la cadena
  SWI 0


  @@ ingresar apellido:

  MOV R7, #3 @3=llamado a "read" swi
  MOV R0, #0 @1=stdout (teclado)
  MOV R2, #19 @long cadena de caracteres
  LDR R1, =apellido_valor @apunta a la etiqueta donde
  SWI 0


  @@ Contar letras

  @@ contar letras nombre
  mov r0,#0 @contador de letras
  ldr r1,=nombre_valor @@se cuentan  individualmente las letras en la variable nombre
  ldr r7,=longitud_nombre_valor @@se le asigna un contador
  bl ContarLetras @@ saltamos a SWI ContarLetras donde se cuentan las letras
  str r0,[r7] @Guardar conteo de letras


  @@ contar letras apellido
  mov r0,#0 @contador de letras
  ldr r1,=apellido_valor @@se cuentan  individualmente las letras en la variable nombre
  ldr r7,=longitud_apellido_valor @@se le asigna un contador
  bl ContarLetras @@ saltamos a SWI ContarLetras donde se cuentan las letras
  str r0,[r7] @Guardar conteo de letras


	@@Se contaran vocales en esta seccion


	@Contar Vocales Nombre
	ldr r1,=nombre_valor @@ se carga la variable que contiene el nombre
	ldr r7,=Vocales_Nombre @@ se crea un contador para guardar el numero de vocales
	mov r0,#0 @contador de vocales
	bl ContarVocales @@saltamos a la branch contar vocales
	str r0,[r7] @Guardar conteo de vocales
	

	@Contar Vocales Apellido
	ldr r1,=apellido_valor @@ se carga la variable que contiene el nombre
	ldr r7,=Vocales_Apellido @@ se crea un contador para guardar el numero de vocales
	mov r0,#0 @contador de vocales
	bl ContarVocales @@saltamos a la branch contar vocales
	str r0,[r7] @Guardar conteo de vocales



	@@misma letra de inicio y final

	mov r0,#0 @contador
	ldr r1,=nombre_valor
	ldr r2,=apellido_valor
	ldr r3,=longitud_nombre_valor
	ldr r3,[r3]
	push {r4}
	ldr r4,=longitud_apellido_valor
	ldr r4,[r4]
	bl CompararLetras
	pop {r4}
	ldr r9,=Total_Puntos
	str r0,[r9] 
	cmp r0,#1
	ldr r9,=Total_Puntos
	ldr r9,[r9]
	ldr r7,=Total_Puntos
	ldr r7,[r7]


	@@misma longitud

	ldr r3,= longitud_nombre_valor
	ldr r3,[r3]
	ldr r4,= longitud_apellido_valor
	ldr r4,[r4]
	cmp r4,r3
	addeq r9,#1



	@@mismas vocales

	ldr r3,= Vocales_Nombre
	ldr r3,[r3]
	ldr r4,= Vocales_Apellido
	ldr r4,[r4]
	cmp r4,r3
	addeq r9,#1

	@guardar Total Points
	add r3,r9,#48
	ldr r8,=Total_Puntos
	str r3,[r8]	
	b salida

salida:

	ldr r0,=result
	ldr r1,=Total_Puntos
	ldr r1,[r1]
	bl printf

/*--salida del sistema--*/
	mov	r3, #0
	mov	r0, r3
	@ colocar registro de enlace para desactivar la pila y retorna al SO
	ldmfd	sp!, {lr}
	bx	lr


.data
.align 2
menu: 
    .asciz "\nMi Primer Bebe!\nBienvenido!\nEn este programa podras comprobar la compatibilidad del nombre y apellido de tu futuro bebe...\nDeberas ingresar su nombre y apellido!"

ingrese_nombre: 
    .asciz "\nIngrese nombre: "

nombre: 
    .asciz "%19s"

nombre_valor:
    .asciz "                   "

ingrese_apellido: 
    .asciz "\nIngrese apellido: "

apellido_valor:
    .asciz "                   "

apellido:
    .asciz "%19s"

ingrese_lenght_nom:
    .asciz "\nIngrese longitud del nombre: "

longitud_nombre:
    .asciz "%d"

longitud_nombre_valor: 
    .word 0

ingrese_lenght_apell:
    .asciz "\nIngrese longitud del apellido: "

longitud_apellido:
    .asciz "%d"

longitud_apellido_valor:
    .word 0


@@vocales en el nombre, y su tamaño

Vocales_Nombre: 
    .word 0
Vocales_Apellido: 
    .word 0

Total_Puntos:
    .word 0 

samelenght: 
    .asciz "\n1. El largo del nombre y apellido es el mismo...\n"
samevowels: 
    .asciz "2. El nombre y apellido tienen el mismo numero de vocales...\n"
samestartend: 
    .asciz "3. El nombre y apellido tienen la misma letra final...\n"

result: 
    .asciz "Felicidades!!!\nEl punteo total es de: %d de 3 puntos!\n\nMuchas gracias por confiar en nosotros!!!\n\n"