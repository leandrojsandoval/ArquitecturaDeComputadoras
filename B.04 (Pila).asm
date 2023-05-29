* B.04 Escriba un programa para el 68HC11 que resuelva la ecuación. La variable A existe en RWM
* y debe tener tamaño suficiente como para almacenar el resultado. El resto (b,c,d,e y f) son de 8
* bits sin signo y pueden estar definidos como constantes o como valores almacenados en ROM.
*
* 				A = (B^2 - C^3)/((D-2)*(E+F))
*
* Recomendamos resolverlo de manera estructurada y luego como una arquitectura orientada al
* stack (en este último caso puede guardar solo los 8 bits menos significativos del resultado).

RWM		EQU		$0000
ROM		EQU		$C000
StackPointer	EQU		$00FF
B		EQU		10
C		EQU		2
D		EQU		3
E		EQU		4
F		EQU		5

		ORG		RWM
A		RMB		2
Aux		RMB		2	

		ORG		ROM
		LDS		#StackPointer
		LDY		#0
		PSHY				* La pila va a tener $00, $00

************************************************************************************************************

		LDAA		#B		* Resuelvo B^2
		LDAB		#B
		MUL
		PSHB
		PSHA				* La pila va a tener $BB, $AA (se almacena en Big Endian)

************************************************************************************************************

		LDAA		#C		* Resuelvo C^2
		LDAB		#C
		MUL				* En el registro D tengo C^2
		LDY		#C		* Lo utilizo como contador
Otro		
		ADDD		#C		* Resuelvo C^2 * C (C^3)
		DEY
		BNE		Otro	
		PSHB				* La pila va a tener $BB, $AA
		PSHA		

************************************************************************************************************

		LDAA		#D		* Realizo D-2
		SUBA		#2		
		PSHA
		CLRA				* Por lo tanto la parte alta sera $00
		PSHA				* Guardo el resultado en 2 bytes

************************************************************************************************************

		CLRA				* Realizo E+F
		LDAB		#E
		ADDB		#F
		ADCA		#0		* Sumo carry
		PSHB				* Almaceno el resultado	
		PSHA				* La pila va a tener $BB, $AA

************************************************************************************************************

		PULA				* Aca tengo E+F en el registro D
		PULB
		STD		Aux
		CLRA
		CLRB
		PULY				* Aca tengo el resultado de D-2
Otro2
		ADDD		Aux		* En el registro D voy a tener le resultado	
		DEY				* de hacer (D-2) * (E+F)
		BNE		Otro2
		XGDX				* Y lo pongo en el registro X

************************************************************************************************************

		PULA				* Saco C^3
		PULB
		STD		Aux		* Y lo guardo en memoria
		PULA				* Saco B^2
		PULB
		SUBD		Aux		* Hago B^2-C^3

************************************************************************************************************

		IDIV				* Voy a tener el resultado en X
		STX		A		* Lo guardo en A
		PULY				* Saco lo que habia inicialmente el Y (0000)
		PSHX				* Y ahora pongo el resultado en el stack

Fin		BRA		Fin