* Ordenamiento por insercion: Inicialmente se tiene un solo elemento, que obviamente es un conjunto ordenado. Después, cuando hay k elementos ordenados de menor 
* a mayor, k+1 y se compara con todos los elementos ya ordenados, deteniéndose cuando se encuentra un elemento menor (todos los elementos mayores han sido 
* desplazados una posición a la derecha) o cuando ya no se encuentran elementos (todos los elementos fueron desplazados y este es el más pequeño). 
* En este punto se inserta el elemento k+1 debiendo desplazarse los demás elementos.

RWM		EQU		$0000
ROM		EQU		$C000
Elementos	EQU		16

		ORG		RWM
Vector		RMB		Elementos
Minimo		RMB		1
DirMinimo	RMB		2

		ORG		ROM
		LDS		#$FF			* Inicializo el SP
		LDX		#Vector			* Con el registro X recorro VECTOR
		JSR		OrdenaVector		* Salto a la subrutina OrdenaVector
		BRA		*			* Fin de programa

OrdenaVector
		PSHX					* Tanto A, B, X e Y van a usarse por lo tanto, necesito guardar sus valores
		PSHY
		PSHA
		PSHB		
		PSHX					* Copio X en Y
		PULY

FullCiclo
		LDAA		0,X
		STAA		Minimo			* Asumo que el primer valor es el mas chico
		STY		DirMinimo		* Ademas guardo su direccion

Ciclo
		CPX		#(Vector+Elementos)	* Verifico que haya terminado de recorrer el vector
		BEQ		FinInsercion		* Si no es el ultimo, tengo que ver si es menor que el actual
		LDAA		0,X
		SUBA		Minimo			* Si el valor de la operacion A - MIN es positivo, entonces min es un valor menor que el actual (salto a EsMayor)
		BHS		EsMayor			* Si el valor es negativo, entonces tengo un nuevo minimo (guardo su posicion y el valor)
		LDAA		0,X
		STAA		Minimo
		STX		DirMinimo

EsMayor
		INX					* Incremento X y vuelvo al ciclo
		BRA		Ciclo

FinInsercion	
		LDX		DirMinimo		* Necesito hacer el cambio de minimo con Y e incrementar Y
		LDAA		0,X			* Traigo Minimo	
		LDAB		0,Y			* Y tambien el valor a donde apunte Y 
		STAA		0,Y			* Intercambio los contenidos tanto de Y
		STAB		0,X			* Como de X
		INY					* Incremento Y
		CPY		#(Vector+Elementos)
		BEQ		Fin			* Llegue al fin del vector
		PSHY					* Copio Y en X
		PULX				
		BRA		FullCiclo		* Vuelvo a tener un nuevo minimo

Fin
		PULB					* Desapilo los registros anteriormente guardados
		PULA
		PULY
		PULX
		RTS					* Regreso de la subrutina

		ORG		Vector
		DB		$4,$AB,$1,$FE,$2,$CD,$3,$22,$A0,$B4,$99,$75,$3,$FD,$9E,$8