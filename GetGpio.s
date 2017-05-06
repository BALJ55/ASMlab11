.text
.align 2
.global GetGpio

@@autores:
@@	Yasmin Chavez 16101
@@	Byron Mota 15246


GetGpio:

@@ parametros:
@@		r0->direccion de la memoria virtual [[!---valor de la etiqueta mylock---!]]
@@		r1->puerto de entrada deseado a comparar
@@ return:
@@		r0->[1 si está activo, 0 si está inactivo]
@@-----------------------
	push{lr}
	ldr r2,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r3,#1			@comparador
	lsl r3,r1			@mueve la mascara a la posicion del puerto recibido en el parametro
	and r4,r3 			@aplica la mascara
	cmp r4,#0			@compara el resultado
	moveq r0,#0			@en caso de ser 0, retorna 0
	movne r0,#1			@en caso caso de ser 1 retorna1 	
	pop{pc}				@retorno al programa principal
	
	
 .data
 .align 2
.global myloc
myloc: .word 0

 .end