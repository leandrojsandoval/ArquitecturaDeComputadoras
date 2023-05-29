* B.01 Indique que hace el procesador 68HC11 cuando ejecuta las siguientes instrucciones.
* Indique el modo de direccionamiento (motorola y genérico). 
* Indique si la instrucción es válida y en caso de no serlo indique el problema. 
* En el caso de ser válida codifique la misma en lenguaje de máquina e indique si afecta los bits del CCR (y en qué forma).

RWM		EQU	$0000
ROM		EQU	$C000
		
		ORG	ROM
		LDAB	#$25		* Carga en el registro acumulador B el valor $25 Modo Inmediato
		LDAB	$25		* Carga en el registro acumulador B el contenido que se encuentre en la direccion $0025 		Modo Paginado
		LDAB	25		* Carga en el registro acumulador B el contenido que se encuentre en la direccion $0019 		Modo Paginado
		LDAB	$25,X		* Trae el valor que encuentra en la direccion que contenga el registro indice X + un offset de $25 	Modo Indexado	
		ADDA	#$EA		* Realiza la suma de lo que tenga el acumulador A + $EA y lo almacena en A 				Modo Inmediato
		ADDA	$EA		* Realiza la suma de lo que tenga el acumulador A + el contenido de la direccion $EA 			Modo Paginado
		ADDA	$EA,X		* Trae el valor que encuentra en la direccion que contenga el registro indice X + un offset de $EA 	Modo Indexado
		CBA			* Realiza una resta de los contenido de los registros A y B ... A - B	Modo Inherente			Modo Inherente
		BCC	Etiqueta	* Es valida siempre y cuando Etiqueta se encuentra en un rango de Offset permitido (-128,127)		Modo Relativo
	
Etiqueta

*		LDD	$225,X		* Es invalida ya que el offset debe ser de 8 bits ($225 tiene 10 bits = 10 0010 0101)
*		LDAA	#$2525		* Es invalida ya que el registro acumulador A es de 8 bits y le estoy dando un valor de 16 bits 
*		LDAB	$2525		* Es invalida ya que no hay memoria en la direccion $2525
*		LDAB	#$2525		* Es invalida ya que el registro acumulador B es de 8 bits y le estoy dando un valor de 16 bits
*		ADDA	$46EA		* Es invalida ya que no hay memoria en la direccion $46EA
*		ADDA	$EEAA,X		* Es invalida ya que el offset debe ser de 8 bits ($EEAA tiene 16 bits = 1110 1110 1010 1010)
*		BCC	$10		* Es invalida, ya que el offset que se quiere hacer es mayor al rango permitido (permite un offset de hasta 8 bits)
*		BCC	#$10		* Es invalida ya que BCC solo admite Modo Relativo, no Modo Inmediato
*		BGE	$F7		* Es invalida, ya que el offset que se quiere hacer es mayor al rango permitido (permite un offset de hasta 8 bits)
*		BSR	$65		* Es invalida, ya que el offset que se quiere hacer es mayor al rango permitido (permite un offset de hasta 8 bits)

Fin		BRA	Fin