* B.25 Considere el siguiente fragmento de memoria de un microcontrolador Motorola 68HC11, del
* que además se indica el estado inicial de los registros: IX = 2500; PC = 4000; D = 0519
*
*		Dirección	Contenido		Determine los valores finales de cada registro (IX, PC, A, B) luego 
*		2500 		4C			de ejecutarse la porción de código indicada:
*		2501 		08				IX ________________
*		2502 		5C				PC ________________
*		2503 		18				A _________________
*		2504 		08				B _________________
*		...		...
*		3FFF		08
*		4000 		A6
*		4001 		01
*		4002 		08
*		4003 		28
*		4004 		02
*		4005 		C6
*		4006 		08
*		4007 		4C

ROM		EQU		$C000
RWM		EQU		$0000
Reset		EQU		$FFFE

		ORG		ROM
Inicio
		LDX		#$2500			* Inicializamos los valores tanto del Registro IX
		LDD		#$0519			* como del Registro D

*		ORG		$3FFF			
*		INX					* No es importante, ya que el PC comienza en $4000

		ORG		$4000			* Va a cargar en el registro A el valor que se encuentra en $2500 + 1 = $2501, el contenido es $08 
		LDAA		1,X			* LDAA pone el flag V en 0
		INX					* El registro X paso a estar en $2501
		BVC		Etiqueta		* Por lo tanto, realiza el salto
		LDAB		#$08			* Esto no se ejecuta
Etiqueta
		INCA					* Incrementamos el registro A ($09)
* Fin		BRA		Fin

		ORG		$2500			* Como si fuera un vector
		DB		$4C,$08,$5C,$18,$08

		ORG		Reset
		DW		Inicio

* Como resultado:
* IX = $2501
* PC = $4008 (Ya esta apuntando a la siguiente instruccion)
* A = $09
* B = $19
* B = $19