* B.18 Escriba una rutina para el HC11 (llamada CONTMAY) que reciba en IX la dirección de
* comienzo de una cadena de hasta 1000 caracteres (ASCII 8 bits) que termina con NULL (0x00).
* Retorne en un registro la cantidad de mayúsculas.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF

* En el registro D se retorna la cantidad de mayusculas

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDY		#0000
		LDX		#Cadena
		JSR		CONTMAY
Fin		BRA		Fin

CONTMAY
		PSHY
		PSHX

Loop
		LDAA		0,X
		BEQ		FinRutina
		CMPA		#'A
		BLO		NoEsMayuscula
		CMPA		#'Z
		BHI		NoEsMayuscula
		INY
NoEsMayuscula
		INX
		BRA		Loop
FinRutina
		XGDY
		PULX
		PULY
		RTS

Cadena		FCC		'bOk1t4Yn4D4Ma5'
		DB		0

		ORG		Reset
		DW		Inicio