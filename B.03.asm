* B.03 Escriba un programa para el 68HC11 simulado en THRSIM11 , donde utilice los switches y LEDS. En los switches se lee un valor entre 00 y FF. 
* Si el valor es 0, no se enciende ningún led. Si el valor está entre 1-32 se enciende el led más a la derecha. 
* Si el valor está entre 33-64 encienda los dos leds más hacia la derecha. Si el valor está entre 65-96 encienda los tres leds más a la derecha ... y así. 
* Esto utiliza los leds tipo vumetro basado en el valor de entrada. Existe un video de ayuda indicando cómo utilizar los LEDS y switches

LEDS		EQU		$1004
Teclas		EQU		$1003
ROM		EQU		$C000
RWM		EQU		$0000
Reset		EQU		$FFFE
Offset		EQU		32

		ORG		ROM
Inicio
		CLR		LEDS		* Se apagan los LEDS	
Loop
		LDAA		Teclas
		BNE		PrimerLED
		LDAA		#0		* Si es 0, no se enciende ningun LED
		STAA		LEDS
		BRA		Loop
PrimerLED
		CMPA		#32
		BHI		SegundoLED	
		LDAA		#%00000001	* Si esta entre 1 - 32 
		STAA		LEDS		* Enciende un LED
		BRA		Loop
SegundoLED
		CMPA		#64
		BHI		TercerLED
		LDAA		#%00000011
		STAA		LEDS
		BRA		Loop
TercerLED
		CMPA		#96
		BHI		CuartoLED
		LDAA		#%00000111
		STAA		LEDS
		BRA		Loop
CuartoLED
		CMPA		#128
		BHI		QuintoLED
		LDAA		#%00001111
		STAA		LEDS
		BRA		Loop
QuintoLED	
		CMPA		#160
		BHI		SextoLED
		LDAA		#%00011111
		STAA		LEDS
		BRA		Loop
SextoLED	
		CMPA		#192
		BHI		SeptimoLED
		LDAA		#%00111111
		STAA		LEDS
		BRA		Loop
SeptimoLED
		CMPA		#224
		BHI		OctavoLED
		LDAA		#%01111111
		STAA		LEDS
		BRA		Loop
OctavoLED
		LDAA		#%11111111
		STAA		LEDS
		BRA		Loop

		ORG		Reset
		DW		Inicio