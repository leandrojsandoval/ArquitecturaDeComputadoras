* B.11 Escriba una subrutina para el HC11 (llamada COMP2BEB) que reciba en IX la dirección más baja donde se encuentra almacenado un número en formato big-endian. 
* La cantidad de bytes que componen al mismo se informa en el registro B (no mayor a 64). Debe complementar a la base el número.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE
Bytes		EQU		4

		ORG		RWM
NumeroComp	RMB		Bytes

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#(Numero+Bytes-1)	* Direccion mas baja donde se encuentra almacenado un numero en big-endian
		LDAB		#Bytes			* Se informa la cantidad de bytes
		JSR		COMP2BEB
Fin		BRA		Fin

COMP2BEB
		PSHB
		PSHX	

		LDY		#(NumeroComp+Bytes-1)
CompBMenos1
		LDAA		0,X
		COMA			
		STAA		0,Y			* Complemento todos los bytes y los almaceno en RWM
		DEY
		DEX
		CPX		#Numero
		BHS		CompBMenos1

* Solo sumo en el byte menos significado Y si hubo carry, que se vaya propagando. En otras palabras, sumo 1 a TODO EL CONJUNTO del numero

		LDY		#(NumeroComp+Bytes-1)
		LDAA		0,Y
		ADDA		#1	
		STAA		0,Y
		DEY
CompB
		BCC		FinRutina		* Si no se propago el carry quiere decir que las demas bytes no hace falta sumarlos
		LDAA		0,Y
		ADCA		#0
		STAA		0,Y
		DEY
		DECB
		BNE		CompB
FinRutina
		PULX
		PULB
		RTS

Numero		DB		$B0,$00,$00,$00

		ORG		Reset
		DW		Inicio