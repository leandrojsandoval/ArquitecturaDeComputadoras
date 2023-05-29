* B.15 Escriba una rutina para el HC11 (llamada INVIERTE) que reciba en IX la dirección de
* comienzo de un vector. El mismo es de tamaño variable (máximo 64 elementos), siendo el último
* elemento un 0. Cada elemento es de 16 bits. La subrutina recibe en IY una dirección en RWM en
* donde deben escribirse los elementos del vector pero en orden inverso. Ej: si el vector tiene como
* elementos 1,2,3,0, debe escribir 3,2,1,0.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF
DirVecInver	EQU		$0000		* Direccion en RWM

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Vector
		LDY		#DirVecInver
		JSR		INVIERTE
Fin		BRA		Fin

INVIERTE
		PSHX
		PSHY

* Como es de tamaño variable, voy a tener que recorrer el vector hasta su ultimo elemento

Recorro
		LDD		0,X
		BEQ		FinVector
		INX
		INX		
		BRA		Recorro
FinVector
		DEX
		DEX				* Ahora, el registro IX tiene la direccion del ultimo elemento (antes del 0)
Loop
		LDD		0,X		* Agarro este ultimo elemento
		STD		0,Y		* Y lo escribo en el primer elemento del nuevo vector
		INY				* Incremento
		INY
		DEX				* Decremento
		DEX
		CPX		#Vector
		BHS		Loop

* Falta poner el cero

		LDD		#0
		STD		0,Y

		PULY
		PULX
		RTS

Vector		FDB		1,2,3	
*		FDB		$9AF1,$0288,$3521,$7777,$5,$6942,$5025
		FDB		0

		ORG		Reset
		DW		Inicio