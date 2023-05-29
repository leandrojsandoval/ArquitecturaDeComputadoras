* B.06 Escriba una subrutina para el HC11 (llamada CANTNEGVAR) que reciba en IX la dirección de comienzo de un vector. 
* El mismo tiene una cantidad variable de elementos y se indica el fin del mismo con un elemento 0. 
* Los elementos que componen el vector son números signados en CB (-32768 hasta 32767). 
* La subrutina debe retornar la cantidad de números negativos del vector en algún registro.

RWM		EQU		$0000
ROM		EQU		$C000
StackPointer	EQU		$00FF
Reset		EQU		$FFFE

		ORG		ROM
Inicio
		LDX		#Vector
		LDS		#StackPointer
		JSR		CANTNEGVAR
Fin		BRA		Fin

CANTNEGVAR
		PSHX
		PSHB
		PSHA
		LDY		#0
Loop
		LDD		0,X
		BEQ		FinRutina
		BPL		NoEsNegativo
		INY
NoEsNegativo
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