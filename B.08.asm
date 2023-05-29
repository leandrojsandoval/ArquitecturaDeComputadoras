* B.08 Escriba una subrutina para el HC11 (llamada PROMPOS) que reciba en IX la dirección de comienzo de un vector. 
* El mismo tiene longitud variable (máximo 128 elementos, mínimo 1) y el fin del mismo se indica guardando un 0. 
* Los elementos del vector son números signados en CB (-128 a 127). 
* La subrutina debe calcular el promedio de los valores positivos y devolver el mismo mediante un acumulador.

RWM		EQU		$0000
StackPointer	EQU		$00FF
ROM		EQU		$C000
Reset		EQU		$FFFE

* En el registro D se debera mostrar el promedio, IX la direccion de comienzo de vector.

		ORG		ROM
Inicio
		LDS		#StackPointer
		LDX		#Vector
		JSR		PROMPOS
Fin		BRA		Fin

PROMPOS
		PSHY					* Guardo lo que habia antes en IY
		PSHX					* Guardo la direccion del primer elemento del vector en el Stack
		LDY		#0			* Lo utilizo como sumador
		CLRA					* Lo utilizo como contador
Loop
		LDAB		0,X			* Cargo un nuevo elemento en B
		BEQ		FinRutina
		BMI		EsNegativo
		ABY					* Hago IY + (00:B) = IY, aca voy a tener la suma de elementos positivos
		INCA					* Cantidad de elementos positivos
EsNegativo
		INX
		BRA		Loop
FinRutina
		TAB					* Paso la cantidad de elementos de A hacia B
		CLRA					* En el registro D tengo la cantidad de elementos
		XGDX					* Ahora eso se encuentra en el registro IX .. D --> IX
		XGDY					* Y pasamos el sumador al registro D ... IY --> D
		IDIV					* El promedio se encontrara en el registro IX (hace D/IX)
		XGDX					* El promedio se encontrara en el registro D
		PULX					* Traigo la direccion de Vector
		PULY					* El valor de IY que estaba antes de la subrutina
		RTS
					
Vector		DB		127,1,-1,-5,3,2,-4
		DB		0

		ORG		Reset
		DW		Inicio