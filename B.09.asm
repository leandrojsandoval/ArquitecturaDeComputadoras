* B.09 Escriba una subrutina para el HC11 (llamada BUSCAMIN) que reciba en IX la dirección de comienzo de un vector. 
* El mismo tiene longitud variable y el fin del mismo se indica guardando un 0. 
* Los elementos que componen el vector son números signados en CB (-32768 hasta 32767). 
* La subrutina debe retornar el menor elemento encontrado en el vector en un registro.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE

		ORG		ROM
Inicio
		LDS		#StackPointer		* Cargamos el Stack Pointer
		CLRA
		CLRB
		LDY		#$0000
		LDX		#Vector			* La direccion del vector en X
		JSR		BUSCAMIN
Fin		BRA		Fin

BUSCAMIN

* Vamos a modificar A y B, asi que los guardamos en la pila para luego recuperarlos

		PSHA
		PSHB					* Importa el orden para recuperarlos
		PSHY					* Usamos Y para leer el valor del vector y saber si es igual a 0, asi que guardamos el valor de Y
		LDD		0,X			* Asumimos que el primer elemento es el minimo.
Loop
		INX
		INX					* Apuntamos al que sigue (valores 16 bits)
		LDY		0,X			* Modifica flag de Z
		BEQ		FinRutina		* Si sigue, el elemento no es 0
		CPD		0,X			* Si D es menor que 0,X seguimos
		BLE		Loop
		LDD		0,X			* Si es menor, cambiamos, este sera el nuevo minimo
		BRA		Loop

FinRutina

* Ahora D tiene el minimo

		XGDX					* Ahora lo tiene X
		PULY					* Devolvemos los valores
		PULB					* que estaban antes
		PULA					* de iniciar la subrutina
		RTS

Vector		DW		10,-20,30,-30000,5000,31000,-32000,2,-32001,0

		ORG		Reset			* Vector de Reset
		DW		Inicio