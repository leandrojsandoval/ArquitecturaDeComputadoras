* B.22 Escriba una subrutina para el procesador HC11 (llamada ATOIS16BE (ASCII to integer)) que
* reciba en IX la dirección de comienzo de una cadena de caracteres ASCII (cuyo primer caracter
* puede ser el signo ‘-’) , y que convierta a un entero con signo de 16 bits almacenado en BIG
* ENDIAN, a partir de la dirección indicada por el registro IY. Los negativos deben representarse en
* CB.

* MIEL: Las cadenas ASCII terminan con NULL, o sea un valor cero.
* El número más grande que podes representar es 32767 (5 chars) y el mas chico -32768 (6 chars). 
* Tambien podes tener menos dígitos cómo por ejemplo -3. 
* Te recomiendo que vayas leyendo el número y lo vayas metiendo en la pila hasta que llegues al NULL. 
* Conta cuántos metes en la pila. Luego vas sacando del la pila cada dígito ASCII y multiplicando 
* por 1,10,100,1000 o 10000 según corresponda y vas acumulando.

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
StackPointer	EQU		$00FF
Uno		EQU		1
Diez		EQU		10
Cien		EQU		100
OffsetASCII	EQU		'0	

		ORG		RWM
Aux		RMB		2
Basura		RMB		1
Numero		RMB		2

		ORG		ROM
Inicio
		LDS		#StackPointer
		CLRA
		CLRB
		LDY		#Numero
		LDX		#NumeroASCII		
		JSR		ATOIS16BE
Fin		BRA		Fin

ATOIS16BE
		PSHA
		PSHB
		PSHY
		PSHX
		CLR		Aux
		CLR		Aux+1
		CLR		Numero
		CLR		Numero+1
		LDY		#0000			* Contador
Loop
		LDAA		0,X
		BEQ		FinCadena
		PSHA
		INX
		INY
		BRA		Loop
FinCadena		

* El objetivo de hacer esto es poner los caracteres del numero ASCII en el stack 
* y con el registro B contar cuantos caracteres hay en la cadena.

* Unidad
		CLRA
		PULB	
		SUBB		#OffsetASCII
		ADDD		Numero
		STD		Numero

		DEY
		BEQ		FinRutina

		PULB
		CMPB		#'-
		BEQ		EsNegativo
* Decena
		SUBB		#OffsetASCII
		LDAA		#Diez
		MUL
		ADDD		Numero
		STD		Numero

		DEY
		BEQ		FinRutina

		PULB
		CMPB		#'-
		BEQ		EsNegativo
* Centena
		SUBB		#OffsetASCII
		LDAA		#Cien
		MUL
		ADDD		Numero
		STD		Numero

		DEY
		BEQ		FinRutina

		PULB
		CMPB		#'-
		BEQ		EsNegativo

* Unidades de mil (1000)

		SUBB		#OffsetASCII
		LDAA		#Diez			* 10 X 100 = 1000
		MUL
		LDAA		#Cien
		MUL
		ADDD		Numero
		STD		Numero

		DEY
		BEQ		FinRutina

		PULB
		CMPB		#'-
		BEQ		EsNegativo

* Decenas de mil (10000)

		SUBB		#OffsetASCII
		LDAA		#Diez
		MUL
		LDAA		#Cien
		MUL
		STD		Aux			* Hasta aca tengo la cifra ubicada en las decena de mil X 1000

* Ahora hace falta multiplicarla por 10 ...

		CLRA
		CLRB
		LDX		#Diez
Otro		
		ADDD		Aux
		DEX
		BNE		Otro
		ADDD		Numero
		STD		Numero

		DEY
		BEQ		FinRutina

		PULB					* Sacamos el '- de la pila

EsNegativo
		LDD		Numero
		COMA					* Complemento a la base menos uno
		COMB
		ADDD		#Uno			* Complemento a la base
		STD		Numero
FinRutina
		PULX
		PULY
		PULB
		PULA

		LDD		Numero			* No lo pide, pero para que chequee mas rapido		

		RTS

NumeroASCII	FCC		'-325'
		DB		0

		ORG		Reset
		DW		Inicio