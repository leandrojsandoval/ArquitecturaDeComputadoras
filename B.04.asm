* B.04 Escriba un programa para el 68HC11 que resuelva la ecuación. La variable A existe en RWM y debe tener tamaño suficiente como para almacenar el resultado. 
* El resto (b,c,d,e y f) son de 8 bits sin signo y pueden estar definidos como constantes o como valores almacenados en ROM.
*
* 				A = (B^2 - C^3)/((D-2)*(E+F))
*
* Recomendamos resolverlo de manera estructurada y luego como una arquitectura orientada al stack (en este último caso puede guardar solo los 8 bits menos 
* significativos del resultado).

RWM		EQU		$0000
ROM		EQU		$C000
Reset		EQU		$FFFE
B		EQU		32		
C		EQU		2
D		EQU		3
E		EQU		2
F		EQU		4

		ORG		RWM
A		RMB		2
AuxDividendo	RMB		2
AuxDivisor	RMB		2

		ORG		ROM
Inicio
		LDAA		#C		* Realizo la operacion C^2
		LDAB		#C		* El resultado quedara en le registro D
		MUL
		STD		AuxDividendo	* AuxDividendo = C^2
		CLRA				* Falta multiplicar una vez mas (Utilizo el algoritmo del ejercicio B.02)
		CLRB
		LDX		#C		* Lo utilizo como contador
Otro		
		ADDD		AuxDividendo	* 0 + AuxDividendo = AuxDividendo, luego AuxDividendo + AuxDividendo = 2 * AuxDividendo y asi ...
		BEQ		EsCero		* Salta esta multiplicacion si C = 0		
		DEX				* Decremento el contador
		BNE		Otro		* Y sigo sumando hasta que el contador sea 0
EsCero		
		STD		AuxDividendo	* AuxDividendo = C^3
		LDAA		#B		* Realizo la operacion B^2	
		LDAB		#B
		MUL				* Registro D = B^2
		SUBD		AuxDividendo	* Esto haciendo D - AuxDividendo, y justamente en D tengo B^2
		STD		AuxDividendo	* AuxDividendo = B^2 - C^3

* Hasta aca terminado lo que vendria a ser el divisor, faltaria el dividendo

		CLR		AuxDivisor	* Ponemos la parte alta en 0 por si no se produjo ningun carry
		LDAA		#E
		LDAB		#F
		ABA
		BCC		NoCarryEF
		INC		AuxDivisor
NoCarryEF
		STAA		AuxDivisor+1	* E + F

		CLRA				* Limpio la parte alta ya que luego voy a tener que guardarlo en 16 bits
		LDAB		#D
		SUBB		#2		* Registro B = D - 2
		BEQ		Error		* Esto lo hago en el caso de que D - 2 = 0		
		LDX		AuxDivisor	* X = E + F
		BEQ		Error		* Esto lo hago en el caso de que E + F = 0
		STD		AuxDivisor	* AuxDivisor = D - 2

		CLRA				* Ahora vamos a hacer la operacion (D-2)*(E+F)
		CLRB
Otro1
		ADDD		AuxDivisor	* 0 + AuxDivisor = AuxDivisor, luego AuxDivisor + AuxDivisor = 2 * AuxDivisor y asi ...
		DEX				* En X ya va a estar E + F
		BNE		Otro1
		STD		AuxDivisor	* AuxDivisor = (D-2) * (E+F)
		LDD		AuxDividendo	* Realizo la operacion final
		LDX		AuxDivisor
		IDIV				* El resultado se puede ver en el registro X
		STX		A		* Guardo el resultado A = (B^2 - C^3)/((D-2)*(E+F))
Fin		BRA		Fin

Error
		LDD		#'E		* Pongo en el resultado una 'E de error
		STD		A
		BRA		Fin	

		ORG		Reset
		DW		Inicio