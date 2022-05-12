
Agregar_producto:
    push{lr}

    MOV R7, #4		 @4=llamado a "write" swi
    MOV R0, #1		 @1=stdout (monitor)
    MOV R2, #100	 	@longitud de la cadena
    LDR R1,= r8 @r7? @apunta a la cadena
    SWI 0
    
    ldr r0, = menu_compra
    bl puts

    ldr r0, = ingrese_desicion
    bl puts
    ldr r0, = formato_decimal
    ldr r1, = desicion_valor_compra
    bl scanf

    /*[1,5]
    [3,2]*/

    @Clasificar productos
    ldr r5, = desicion_valor_compra
    ldrb r4,[r5]
    ldr r6, = productos
    cmp r4, #1 @ LECHE
    strb r4, [r6]
    cmpne r4, #2@ GALLETAS
    strb r4, [r6]
    cmpne r4, #3 @ MANTEQUILLA
    strb r4, [r6]
    cmpne r4, #4@ QUESO
    strb r4, [r6]
    cmpne r4, #5 @ UNIPAN
    strb r4, [r6]
    cmpne r4, #6 @ JALEA
    strb r4, [r6]
    cmpne r4, #7 @ UNIYOGURT
    strb r4, [r6]
    cmpne r4, #8 @ LB MANZANAS
    strb r4, [r6]


    @cantidad de productos
    ldr r0, = solcitar_cantidad_productos
    bl puts
    ldr r0, = formato_decimal
    ldr r1, = cantidad_producto
    bl scanf
    ldr r0, = cantidad_producto
    ldrb r0, [r0]
    ldr r1, = cantidad_productos_valor
    strb r0, [r1]

    ldr r0, = producto_agregado
    bl puts
    b Menu

    pop{lr}
    mov pc, lr
