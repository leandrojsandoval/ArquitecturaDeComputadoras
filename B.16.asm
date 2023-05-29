* B.16 Escriba una rutina para el HC11 (llamada ALIGN4) que reciba en IX la dirección de comienzo
* de un vector. El mismo es de tamaño variable siendo el último elemento un 0. Cada elemento es
* una dirección de 16 bits tomada de una computadora que direcciona al byte con tamaño de
* palabra 4 bytes. Retorne en el registro IY la cantidad de direcciones que se encuentran alineadas
* para lecturas de palabras completas.

* MIEL Profe:
* El vector tiene elementos de 16 bits, o sea numeros. Esos números representan direcciones , pero esas direcciones están ahí solo para saber 
* si son accesos alineados o no en otra computadora que tiene 16 bits de bus de direcciones y accede direccionando al byte palabras de 32 bits.
* O sea, la dirección 0000, 0001, 0002 y 0003 pertenecen a la primer palabra de memoria de la computadora esa. 
* Si en el vector tenes la direccion 0000 (lo que sería un acceso alineado) ese acceso no se cuenta. Si tenes 0001 ese acceso no es alineado, entonces lo contas. 
* Si accedes a 0004 por ejemplo es alineado (no se cuenta), si accedes a 0006 es no alineado (se cuenta). 

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF

		ORG		ROM
Inicio		
		LDS		#StackPointer
		LDX		#Vector
		JSR		ALIGN4
Fin		BRA		Fin

ALIGN4
		PSHX
		LDY		#0			* Inicializo el contador
Loop
		LDD		0,X
		BEQ		FinRutina
		ANDB		#%00000011		* Multiplos de 4 (EN ESTE CASO)
		BNE		NoAlineado
		INY
NoAlineado
		INX
		INX
		BRA		Loop
FinRutina	
		PULX
		RTS

Vector		FDB		$0008,$0002,$0001,$0004,$000C
		FDB		0

		ORG		Reset
		DW		Inicio