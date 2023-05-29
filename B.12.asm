* B.12 Escriba una subrutina para el HC11 (llamada COMP2LEB) que reciba en IX la dirección más
* baja donde se encuentra almacenado un número en formato little-endian. La cantidad de bytes
* que componen al mismo se informa en el registro B (no mayor a 64). Debe complementar a la
* base el número.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF
Bytes		EQU		4

		ORG		RWM
NumeroComp	RMB		Bytes


		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Numero			* Direccion mas baja donde se encuentra almacenado un numero en big-endian
		LDAB		#Bytes			* Se informa la cantidad de bytes
		JSR		COMP2LEB
Fin		BRA		Fin

COMP2LEB
		PSHB
		PSHX
		LDY		#NumeroComp
CompBMenos1
		LDAA		0,X
		COMA
		STAA		0,Y
		INY
		INX
		CPX		#(Numero+Bytes-1)
		BLS		CompBMenos1

* Solo sumo en el byte menos significado Y si hubo carry, que se vaya propagando
* En otras palabras, sumo 1 a TODO EL CONJUNTO del numero

		LDY		#NumeroComp
		LDAA		0,Y
		ADDA		#1	
		STAA		0,Y
		INY
CompB
		BCC		FinRutina
		LDAA		0,Y
		ADCA		#0
		STAA		0,Y
		INY
		DECB
		BNE		CompB
FinRutina
		PULX
		PULB
		RTS

Numero		DB		$EC,$F5,$CF,$2