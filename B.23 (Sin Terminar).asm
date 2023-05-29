* B.23 Escriba una rutina para el procesador HC11 (llamada SUMAFLOAT) que reciba dos n�meros
* codificados en IEEE754 simple precisi�n (las direcciones del bit m�s significativo de ambos
* apuntados por IX e IY respectivamente). Debe realizar la suma de ambos n�meros y devolver el
* resultado mediante el stack (De forma que quien llame a la rutina obtenga en 4 lecturas del stack
* el valor). Puede ignorar los casos especiales de exponente igual a 00000000 y 11111111.

* Ten�s que comparar los signos as� sabes si sumas o restas. Luego comparas  exponentes. 
* Si son iguales sumas la mantisa y acomodas el exponente del resultado en caso que tengas carry.
* Si los exponentes son distintos ten�s que shiftear la mantisa hasta llegar al mismo exponente, y luego sumar.
* Planteate solo el caso m�s f�cil primero donde se suma (ambos positivos) y ambos con el mismo exponente. 

RWM			EQU			$0000
ROM			EQU			$C000
Reset			EQU			$FFFE
StackPointer		EQU			$00FF
OffsetIEEE754		EQU			127

			ORG			ROM
Inicio
			LDS			#StackPointer
			LDX			#NumeroI
			LDY			#NumeroII
			JSR			SUMAFLOAT
Fin			BRA			Fin

SUMAFLOAT
			RTS

NumeroI			DB			0,%10000001,%11100000,%00000000,%00000000
						* Signo, Exponente, Mantisa(+1)

NumeroII		DB			0,%10000001,%11100000,%00000000,%00000000
						* Signo, Exponente, Mantisa(+1)

			ORG			Reset
			DW			Inicio