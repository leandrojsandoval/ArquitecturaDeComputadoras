* B.19 Escriba una rutina para el HC11 (llamada CONTNUM) que reciba en IX la dirección de
* comienzo de una cadena de hasta 1000 caracteres (ASCII 8 bits) que termina con NULL (0x00).
* Retorne en un registro la cantidad de caracteres numéricos.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF

* La cantidad de caracteres numericos retorna en el registro IY

		ORG		ROM
Inicio
		LDS		#StackPointer
		CLRA
		CLRB
		LDX		#Cadena
		JSR		CONTNUM
Fin		BRA		Fin

CONTNUM
		PSHA
		PSHB
		PSHX
		LDY		#0000
Loop
		LDAA		0,X
		BEQ		FinRutina
		CMPA		#'0
		BLO		NoEsNumero
		CMPA		#'9
		BHI		NoEsNumero
		INY
NoEsNumero
		INX
		BRA		Loop
FinRutina
		PULX
		PULB
		PULA
		RTS

Cadena		FCC		'aA41Bc22dEzZ01'
		DB		0

		ORG		Reset
		DW		Inicio