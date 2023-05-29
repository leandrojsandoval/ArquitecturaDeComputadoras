* B.20 Escriba una rutina para el HC11 (llamada CONTALPHA) que reciba en IX la dirección de
* comienzo de una cadena de hasta 1000 caracteres (ASCII 8 bits) que termina con NULL (0x00).
* Retorne en un registro la cantidad de caracteres alfanuméricos.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF

* La cantidad de caracteres alfanumericos se retornan en el registro IY

		ORG		ROM
Inicio
		LDS		#StackPointer
		CLRA
		CLRB
		LDX		#Cadena
		JSR		CONTALPHA
Fin		BRA		Fin

CONTALPHA
		PSHA
		PSHB
		PSHX
		LDY		#0000
Loop
		LDAA		0,X
		BEQ		FinRutina
		CMPA		#'0
		BLO		NoEsNumero
		CMPA		#'1
		BHI		NoEsNumero
		INY
NoEsNumero
		CMPA		#'A
		BLO		NoEsMayuscula
		CMPA		#'Z
		BHI		NoEsMayuscula
		INY
NoEsMayuscula
		CMPA		#'a
		BLO		NoEsMinuscula
		CMPA		#'z
		BHI		NoEsMinuscula
		INY
NoEsMinuscula		
		INX
		BRA		Loop
FinRutina
		PULX
		PULB
		PULA
		RTS

Cadena		FCC		'+aAB,cd EzZ!01'
		DB		0

		ORG		Reset
		DW		Inicio