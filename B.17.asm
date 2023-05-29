* B.17 Escriba una rutina para el HC11 (llamada C24IMPBE) que reciba en IX la dirección de
* comienzo de un vector. El mismo es de tamaño variable siendo el último elemento un 0. Cada
* elemento es un número de 24 bits almacenado en big-endian. La subrutina debe retornar en el
* registro IY la cantidad de elementos impares que contiene el vector.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Vector
		JSR		C24IMPBE
Fin		BRA		Fin

C24IMPBE
		PSHX					* Guardo en el SP la direccion inicial del vector
		LDY		#0000			* Inicializo el contador
		LDX		#Vector	
Loop
		LDD		1,X			* Solo me traigo los 16 bits menos significativos
		BEQ		PosibleCero		* $XX, $00, $00
		ANDB		%00000001		* Si tiene un 1 en el LSB, quiere decir que el numero es impar
		BEQ		NoEsImpar
		INY
PosibleCero
		LDD		0,X			
		BEQ		FinRutina		* $00, $00, $XX
NoEsImpar
		INX
		INX
		INX
		BRA		Loop
FinRutina
		PULX
		RTS

Vector		DB		$02,$44,$FF,$5,$AB,$00,$44,$EC,$A1,$DC,$00,$00
		DB		$00,$00,$00

		ORG		Reset
		DW		Inicio