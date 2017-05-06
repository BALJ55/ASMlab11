@ Basado en el curso de la U. de Cambridge de Alex Chadwick
@ puertosES_2.s prueba con puertos de entrada y salida
@ Funciona con cualquier puerto, utilizando biblioteca gpio0_2.s

 .text
 .align 2
 .global main
main:
	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress @solo se llama una vez
	
	@GPIO para escritura (salida) puerto 5 [para el LED 1]
	mov r0,#5
	mov r1,#1
	bl SetGpioFunction

	@GPIO para escritura (salida) puerto 6 [para el LED 2]
	mov r0,#6
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para escritura (salida) puerto 13 [para el LED 3]
	mov r0,#13
	mov r1,#1
	bl SetGpioFunction
	
	@GPIO para lectura (entrada) puerto 19  [para el boton]
	mov r0,#19
	mov r1,#0
	bl SetGpioFunction
	
	@@primer led prendido
	
	
	mov r0, #5
	mov r1,#0
	bl SetGpio
	mov r0, #6
	mov r1,#0
	bl SetGpio
	mov r0, #13
	mov r1,#0
	bl SetGpio
	mov r3,#2
	mov r7,#1
	bl wait
	bl loopmain

	
loopmain:
	ldr r6, =myloc
 	ldr r0, [r6]
	mov r1,#19
	
	dr r6, =myloc
 	ldr r0, [r6]		@ obtener direccion de la memoria virtual 
	ldr r5,[r0,#0x34]	@Direccion r0+0x34:lee en r5 estado de puertos de entrada
	mov r7,#1
	lsl r7,#19
	and r5,r7 		@se revisa el bit 14 (puerto de entrada)

	@Si el boton esta en alto (1), fue presionado y enciende GPIO 15
	cmp r5,#0
	
	@@cmp r0,#1
	bleq sender
	b loopmain
	
sender:
	cmp r7,#1
	bleq loop1
	
	cmp r7,#2
	bleq loop2
	
	bl loop3
	
loop1:
	@@prende el primero
	mov r0, #5
	mov r1,#1
	bl SetGpio
	bl wait

	@@apaga el segundo
	mov r0,#6
	mov r1,#0
	bl SetGpio
	bl wait
	@@apaga el tercero
	mov r0,#13
	mov r1,#0
	bl SetGpio
	bl wait
	
	add r7,r7,#1
	bl loopmain

	
loop2:

	@enciende el siguiente
	mov r0,#6
	mov r1,#1
	bl SetGpio
	bl wait
	
	@@apaga el segundo
	mov r0,#5
	mov r1,#0
	bl SetGpio
	bl wait
	@@apaga el tercero
	mov r0,#13
	mov r1,#0
	bl SetGpio
	bl wait
	
	add r7,r7,#1
	bl loopmain
	
loop3:
	@enciende el tercero
	mov r0,#13
	mov r1,#1
	bl SetGpio
	bl wait
	
	@@apaga el segundo
	mov r0,#5
	mov r1,#0
	bl SetGpio
	bl wait
	@@apaga el tercero
	mov r0,#6
	mov r1,#0
	bl SetGpio
	bl wait
	
	add r7,r7,#1
	bl loopmain

	

@ brief pause routine
wait:
 mov r0, #0x4000000 @ big number
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

 .data
 .align 2
.global myloc
myloc: .word 0

 .end
