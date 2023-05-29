* B.05 Escriba una subrutina para el HC11 (llamada CANTNEGFIJA) que reciba en IX la dirección de comienzo de un vector. 
* El mismo tiene una longitud fija de 20 elementos. Los elementos que componen el vector son números signados en CB (-32768 hasta 32767). 
* La subrutina debe retornar la cantidad de números negativos del vector en algún registro.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE
Elementos	EQU		20

* Retorno la cantidad de numeros negativos del vector en el registro Y

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Vector
		JSR		CANTNEGFIJA
Fin		BRA		Fin

CANTNEGFIJA
		PSHX
		PSHB
		PSHA
		LDY		#0
Loop
		LDD		0,X
		BPL		NoEsNegativo
		INY
NoEsNegativo
		INX
		INX
		CPX		#(Vector+Elementos*2)		* Ya que son 16 bits cada elemento
		BLO		Loop
		PULA
		PULB
		PULX
		RTS

Vector		DW		-32768,1,2,3,0,10,-1500,32767,50,25,-250,0,-1,1,9,15,-42,18,20,-4

		ORG		Reset
		DW		Inicio