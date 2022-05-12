@Laboratorio 6
@Grupo 3
@Melanie Maldonado
@Gonzalo Santizo
@Jose Daniel Gomez

@-----------------------------------------------------------------------------------------------------
@------------------------------------------DATA-------------------------------------------------------
@-----------------------------------------------------------------------------------------------------

.data
.align 2

bienvenida:
   .asciz "\nBienvenido al control de Supermercado!!!\nEn este programa podras realizar compras y facturarlas!\n"

menu_principal:
   .asciz "\nMENU PRINCIPAL\n1. Agregar producto al carrito\n2.Facturar\n3.Salir"

menu_compra:
   .asciz "\nMENU DE COMPRA\n1.Leche:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q18.00\n2.P. Galletas:\n   Cantidad de Existencias: 32\n   Precio Unitario: Q25.00\n3.Mantequilla:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q10.00\n4.Queso:\n   Cantidad de Existencias: 15\n   Precio Unitario: Q35.00\n5.Uni. Pan:\n   Cantidad de Existencias: 20\n   Precio Unitario: Q4.00\n6.Jalea:\n   Cantidad de Existencias: 18\n   Precio Unitario: Q26.00\n7.Uni. Yogurt:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q8.00\n8.Lb. Manzana:\n   Cantidad de Existencias: 35\n   Precio Unitario: Q19.00\n"

ingrese_desicion:
   .asciz "\nIngrese su desicion: "

formato_asciz_char_menu:
   .asciz "%c"

formato_asciz_char_producto:
   .asciz "%c"

desicion_valor:
   .word 0

despedida:
   .asciz "\n-----------------------------\n\nMuchas gracias por comprar con nosotros!\n\nEsperamos verlo pronto!!!\n\n"

error:
   .asciz "\n\n\tIngreso incorrecto, siga instrucciones por favor..."

ingrese_nombre: 
   .asciz "\nPor favor ingresa el nombre de la factura: "

nombre: 
    .asciz "%19s"

nombre_valor:
   .asciz "                   "

cantidad_producto:
   .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   @word 0

desicion_valor_compra:
   .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   @word 0

solcitar_cantidad_productos:
   .asciz "\n\nIngrese la cantidad de producto deseado: "

formato_decimal:
   .asciz "%d"

cantidad_productos_valor:
   .word 0, 0, 0, 0, 0, 0, 0, 0

precio_unitario_productos:
   .word 18, 25, 10, 35, 4, 26, 8, 19

cantidad_disponible_productos:
   .word 20, 32, 15, 15, 20, 18, 35, 35

producto_agregado:
   .asciz "\nProducto agregado al carrito exitosamente!!!\n"

factura1:
   .asciz "\n---------- FACTURA ----------\n"

nombre_factura:
   .asciz "Nombre del cliente: "

factura_productos:
   .asciz "\nCarrito:"


@-----------------------------------------------------------------------------------------------------
@------------------------------------------MAIN-------------------------------------------------------
@-----------------------------------------------------------------------------------------------------

.text
.align 2
.global main
.func main
.type main, %function
main:
@stmfd sp!, {lr}

   @print bienvenida
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #100	 	@longitud de la cadena
   LDR R1,= bienvenida @apunta a la cadena
   SWI 0

@@Menu principal del programa
Menu:
   /*impresion de menu y pide comando*/
   
   @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #67	 	@longitud de la cadena
   LDR R1,= menu_principal @apunta a la cadena
   SWI 0

   @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #23	 	@longitud de la cadena
   LDR R1,= ingrese_desicion @apunta a la cadena
   SWI 0

   @input
   mov r7,#3		@3=llamado a "read" swi
  	mov R0, #0		@0=stdout (teclado)
  	mov R2, #1		@longitud de la cadena: 20 caracteres
  	LDR R1, = desicion_valor	@apunta a la variable donde se guarda
  	SWI 0


opcion_menu: @<-----------------------------------------------------------------------------------------------
   ldr r4, = desicion_valor
   ldr r4,[r4]
   cmp r4, #'1'
      beq seccion_agregar_producto
   cmpne r4, #'2'
   beq Facturar
   cmpne r4, #'3'
   beq Salir
   bne Error

/*
    ldrb r1,[r5],#1
    strb r1,[r5]
*/


Facturar:
   @@Bloque de leer nombre 
	@@se lee el nombre que ingresa el usuario
    /*
	ldr r0,=ingrese_nombre @@formato de ingresar nombre
	bl puts 
	ldr r0,=nombre @@ variable que almacena el nombre
	ldr r1,=nombre_valor @@guarda el string del nombre
	bl scanf
   ldr r0, = factura1
   bl puts
   ldr r0, = nombre_factura
   bl puts
   ldr r0, = nombre_valor
   bl puts
   ldr r0, = factura_productos
   bl puts
   b Salir
   */

   @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #45	 	@longitud de la cadena
   LDR R1,= ingrese_nombre @apunta a la cadena
   SWI 0

   @input -> nombre del cliente !!!
    mov r7,#3		@3=llamado a "read" swi
    mov R0, #0		@0=stdout (teclado)
    mov R2, #20		@longitud de la cadena: 20 caracteres
    LDR R1, = nombre_valor	@apunta a la variable donde se guarda
    SWI 0

    @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #33	 	@longitud de la cadena
   LDR R1,= factura1 @apunta a la cadena
   SWI 0

    @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #20	 	@longitud de la cadena
   LDR R1,= nombre_factura @apunta a la cadena
   SWI 0

    @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #19	 	@longitud de la cadena
   LDR R1,= nombre_valor @apunta a la cadena
   SWI 0

    @print
   MOV R7, #4		 @4=llamado a "write" swi
   MOV R0, #1		 @1=stdout (monitor)
   MOV R2, #10	 	@longitud de la cadena
   LDR R1,= factura_productos @apunta a la cadena
   SWI 0

    b Salir

Salir:
   ldr r0, = despedida
   bl puts
   mov r0, #0
   mov r3, #0
   ldmfd sp!, {lr}
   bx lr

Error:
   ldr r0, = error
   bl puts
   b Menu

seccion_agregar_producto:
    @ PRINT
    MOV R7, #4		 @4=llamado a "write" swi
    MOV R0, #1		 @1=stdout (monitor)
    MOV R2, #600	 	@longitud de la cadena
    LDR R1,= menu_compra @apunta a la cadena 
    SWI 0

    @ PRINT
    MOV R7, #4		 @4=llamado a "write" swi
    MOV R0, #1		 @1=stdout (monitor)
    MOV R2, #23	 	@longitud de la cadena
    LDR R1,= ingrese_desicion @apunta a la cadena
    SWI 0

    @input -> INPUT PRODUCTO ID
    mov r7,#3		@3=llamado a "read" swi
    mov R0, #0		@0=stdout (teclado)
    mov R2, #20		@longitud de la cadena: 20 caracteres
    LDR R1, = desicion_valor_compra	@apunta a la variable donde se guarda
    SWI 0

    @ PRINT
    MOV R7, #4		 @4=llamado a "write" swi
    MOV R0, #1		 @1=stdout (monitor)
    MOV R2, #43	 	@longitud de la cadena
    LDR R1,= solcitar_cantidad_productos @apunta a la cadena
    SWI 0

    @input -> INPUT CANTIDAD PRODUCTO
    mov r7,#3		@3=llamado a "read" swi
    mov R0, #0		@0=stdout (teclado)
    mov R2, #20		@longitud de la cadena: 20 caracteres
    LDR R1, = cantidad_producto	@apunta a la variable donde se guarda
    SWI 0
    b Menu
