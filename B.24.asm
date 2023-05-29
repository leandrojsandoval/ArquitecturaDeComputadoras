* B.24 Desensamblar el siguiente código de máquina del procesador HC11 teniendo en cuenta que
* el área de memoria comienza en la dirección $8000. En los saltos relativos (si los hubiera)
* colocar la etiqueta correspondiente. El valor inicial del PC = $8000.
* 8000	7F 00 02 7F 00 03 7F 00 04 7F 00 05 96 00 D6 01 1B 24 03 7C 00 02 97 03 96 00
*	9B 01 24 03 7C 00 04 97 05 20 FE

RWM		EQU		$0000
ROM		EQU		$8000
Reset		EQU		$FFFE

		ORG		ROM
Inicio
		CLR		$0002			* Modo Extendido (Absoluto Directo)
		CLR		$0003			* Modo Extendido (Absoluto Directo)
		CLR		$0004			* Modo Extendido (Absoluto Directo)		
		CLR		$0005			* Modo Extendido (Absoluto Directo)
		LDAA		$00			* Modo Directo (Paginado - Pagina 0)
		LDAB		$01			* Modo Directo (Paginado - Pagina 0)
		ABA					* Modo Inherente (Registro Directo)
		BCC		Etiqueta		* Modo Relativo
		INC		$0002
Etiqueta				
		STAA		$03			* Modo Directo (Paginado - Pagina 0)
		LDAA		$00			* Modo Directo (Paginado - Pagina 0)
		ADDA		$01			* Modo Directo (Paginado - Pagina 0)
		BHS		Etiqueta2		* Modo Relativo
		INC		$0004			* Modo Extendido (Absoluto Directo)
Etiqueta2
		STAA		$05			* Modo Directo (Paginado - Pagina 0)
Fin		BRA		Fin			* Modo Relativo

		ORG		Reset
		DW		Inicio