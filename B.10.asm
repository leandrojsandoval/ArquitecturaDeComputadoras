* B.10 Escriba una subrutina para el HC11 (llamada POSMIN) que reciba en IX la dirección de comienzo de un vector. 
* El mismo tiene longitud variable y el fin del mismo se indica guardando un 0. 
* Los elementos que componen el vector son números signados en CB (-32768 hasta 32767). 
* La subrutina debe retornar la dirección del menor elemento encontrado en el vector en un registro.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE

* La direccion del menor elemento encontrado retorna en el registro IY

		ORG		ROM
Inicio
		LDS		#StackPointer	* Cargamos el Stack Pointer
		LDX		#Vector		* La direccion del vector en X
		JSR		POSMIN
Fin		BRA		Fin

POSMIN
		PSHX				* Guardamos la direccion del vector
		PSHB				* Importa el orden para recuperarlos
		PSHA
		LDY		0,X		* El primero sera el minimo
		PSHX				* Y guardo su direccion en el SP
Loop
		INX
		INX
		LDD		0,X		* Voy cargando los elementos, unicamento esto lo uso para saber si encontre un valor 0
		BEQ		FinRutina		
		CPY		0,X		* Comparo los valores con el minimo hasta el momento
		BLE		NoEsMenor	* Si salto, significa que el numero no es menor
		XGDY				* Nuevo minimo en el registro IY
		INS				* Incremento el Stack
		INS
		PSHX				* Para almacenar el valor, que es la direccion del nuevo minimo		
NoEsMenor
		BRA		Loop
FinRutina
		PULY				* Traemos al registro Y la direccion del minimo				
		PULA				* Devolvemos los valores que estaban antes de iniciar la subrutina
		PULB
		PULX
		RTS

Vector		DW		10,-20,30,-30000,5000,31000,-32000,2,0

		ORG		Reset
		DW		Inicio