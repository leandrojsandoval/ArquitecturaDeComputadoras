* B.26 Un microcontrolador 68HC11 presenta los siguientes valores en su estado funcional antes
* de comenzar a ejecutar la siguiente instrucción:
* 	PC: C000; SP=00FF; IX=2000; IY=3000; A=01; B=02
*
* El contenido de la memoria a partir de la dirección C000 es el siguiente:
*	7f 00 01 7f 00 02 96 00 80 64 25 05 7c 00 01 20
*	f7 8b 64 80 0a 25 05 7c 00 02 20 f7 8b 0a 97 03
*	20 fe
*
* Desensamble el programa (una línea por instrucción, no por byte) y complete con las etiquetas
* que considere necesarias.

ROM		EQU		$C000

		ORG		ROM
*		LDS		#$00FF
*		LDX		#$2000
*		LDY		#$3000
*		LDAA		#$01
*		LDAB		#$02

		CLR		$0001
		CLR		$0002
		LDAA		$00
Loop		SUBA		#$64		* 2 bytes
		BCS		Etiqueta	* 2 bytes
		INC		$0001		* 3 bytes
		BRA		Loop		* 2 bytes
Etiqueta
		ADDA		#$64
Loop2		
		SUBA		#$0A
		BCS		Etiqueta2
		INC		$0002		* 3 bytes
		BRA		Loop2		* 2 bytes
Etiqueta2
		ADDA		#$0A
		STAA		$03
Fin		BRA		Fin