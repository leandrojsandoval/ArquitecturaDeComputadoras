* B.21 Escriba una subrutina para el procesador HC11 (llamada ITOAU32BE (integer to ASCII)) que
* reciba en IX la dirección de comienzo de un número de 16 bits sin signo, almacenado en BIG
* ENDIAN y que lo convierta a una cadena de caracteres ASCII, a partir de la dirección indicada por
* el registro IY.

RWM		EQU		$0000	
ROM		EQU		$C000
StackPointer	EQU		$00FF
Reset		EQU		$FFFE
OffsetASCII	EQU		'0

* Como el máximo número posible en 16 bits sin signo es 65536, se necesitan 10 bytes.

		ORG		RWM
DecMil		RMB		1
UniMil		RMB		1
Centena		RMB		1
Decena		RMB		1
Unidad		RMB		1

		ORG		ROM
Inicio
		LDS		#StackPointer	* Inicializacion de valores antes de entrar a la subrutina
		CLRB				* Estos valores deberian aparecer al finalizar el programa
		CLRA
		LDX		#Numero
		LDY		#DecMil
		JSR		ITOAU32BE
Fin		BRA		Fin

ITOAU32BE
		PSHX				* Guardo los valores para retirarlos al final de la subrutina
		PSHY
		PSHB
		PSHA

		LDD		0,X
		LDY		#Unidad
Loop
		LDX		#10
		IDIV
		ADDB		#OffsetASCII
		STAB		0,Y
		XGDX
		DEY
		CPY		#DecMil
		BGE		Loop

		PULA
		PULB
		PULY
		PULX

		RTS

Numero		DB		$EB,$F6

		ORG		Reset
		DW		Inicio