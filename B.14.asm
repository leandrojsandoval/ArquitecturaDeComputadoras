* B.14 Escriba una rutina para el HC11 (llamada CONTNCANT) que reciba en IX la dirección de
* comienzo de un vector. El mismo es de tamaño variable, siendo el último elemento un 0. Cada
* elemento es de 16 bits. La subrutina recibe en el registro IY un valor de 16 bits. Debe retornar en
* el registro IX la cantidad de veces que NO aparece el valor informado en IY dentro del vector.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF
Valor		EQU		$1234

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Vector
		LDY		#Valor
		JSR		CONTNCANT
Fin		BRA		Fin

CONTNCANT
		PSHY				* Guardo el valor en el stack
		LDY		#0000		* Lo utilizo como contador
Loop
		LDD		0,X
		BEQ		FinRutina	* Si el elemento es 0, termino el vector
		CPD		#Valor		* Si el elemento es igual al valor
		BEQ		EsIgual	
		INY				* Incremento el contador
EsIgual	
		INX
		INX
		BRA		Loop
FinRutina
		XGDY				* Pongo las ocurrencias en el registro D 
		XGDX				* Pongo las ocurrencias en el registro X	Y --> D --> X
		PULY				* Recupero el valor del stack
		RTS

Vector		FDB		$1234,$90,$1234,$321,$1234,$1,$1234,$ABFF,$2,$5
		FDB		0
	
		ORG		Reset
		DW		Inicio