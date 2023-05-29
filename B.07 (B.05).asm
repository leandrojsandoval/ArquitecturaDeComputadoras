* B.07 Repita los ejercicios A05 y A06 pero contando números positivos.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE
Elementos	EQU		20

* Retorno la cantidad de numeros positivos del vector en el registro Y

		ORG		ROM
Inicio
		LDX		#Vector
		LDS		#StackPointer
		JSR		CANTPOSFIJA
Fin		BRA		Fin

CANTPOSFIJA
		PSHX						* Lo guardamos ya que vamos a recorrer el vector
		PSHB						* Tanto el registro A como el B, lo vamos a necesitar para cargar los elementos
		PSHA
		LDY		#0
Loop
		LDD		0,X
		BMI		NoEsPositivo
		INY
NoEsPositivo
		INX
		INX
		CPX		#(Vector)+(Elementos*2)		* Ya que son 16 bits cada elemento
		BLO		Loop

		PULA
		PULB
		PULX
		RTS

Vector		DW		-32768,1,2,3,0,10,-1500,22,50,25,-250,0,-1,1,9,15,-42,18,20,-4

		ORG		Reset
		DW		Inicio