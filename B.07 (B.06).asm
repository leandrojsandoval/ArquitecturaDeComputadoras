* B.07 Repita los ejercicios A05 y A06 pero contando números positivos.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE

		ORG		ROM
Incio
		LDS		#StackPointer
		LDX		#Vector
		JSR		CANTPOSVAR
Fin		BRA		Fin

CANTPOSVAR
		PSHX
		PSHB
		PSHA
		LDY		#0
Loop
		LDD		0,X
		BEQ		FinRutina
		BMI		NoEsPositivo
		INY
NoEsPositivo
		INX
		INX		
		BRA		Loop
FinRutina
		PULA
		PULB
		PULX
		RTS

Vector		DW		-32768,1,2,3,2,10,-1500,22,50,25,-250,2,-1,1,9,15,-42,18,20,-4,1
		DW		0

		ORG		Reset
		DW		Inicio