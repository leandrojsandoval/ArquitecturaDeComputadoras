* B.02 Para una unidad de procesos 68HC11, indicar los contenidos de los acumuladores A y B, y de las direcciones de memoria 00F5, 00F7 y 00F8
* después de la ejecución de las siguientes instrucciones:
* 
* Inicio
*		CLRA
*		LDAB		$F5
* Otro			
*		ADDA		$F7
*		DECB
*		BNE		Otro
*		STAA		$F8
* Fin		BRA		Fin
*
* Si los contenidos iniciales de las direcciones de memoria son respectivamente
* 00F5: 08	
* 00F7: 12
* Indicar qué hace el programa.

ROM		EQU		$C000
Reset		EQU		$FFFE

		ORG		ROM
Inicio
		CLRA				* Inicializo el registro A
		LDAB		$F5		* Cargo en el acumulador B el contenido de la direccion 00F5
Otro
		ADDA		$F7		* Realizo la suma de del que se encuentre en el registro A (inicialmente 0) + contenido de la direccion $00F7
		DECB				* Decremento B
		BNE		Otro		* Si B no esta en 0, salto a la etiqueta Otro
		STAA		$F8		* Cuando B este en 0, almaceno lo que hay quedado en A, en la direccion 00F8
Fin		BRA		Fin		* Fin de programa

		ORG		Reset
		DW		Inicio

		ORG		$F5		* Valor del contenido de la direccion 00F5
		DB		08

		ORG		$F7		* Valor del contenido de la direccion 00F7
		DB		12

* Resumen: lo que realiza el programa es dado dos valores, uno como una variable contador y el otro como una variable inicial a sumar, se realiza una
* sumatoria de ese valor, tantas veces sea el valor del contador. En otras palabras realiza una multiplicacion 12*8 = 96 (Sera el resultado final del acumulador A)