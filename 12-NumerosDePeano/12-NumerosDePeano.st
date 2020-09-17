!classDefinition: #I category: #peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'error handling - private' stamp: 'FS 9/17/2020 12:17:35'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El divisor es mayor!!'! !

!I class methodsFor: 'error handling - private' stamp: 'FS 9/17/2020 12:19:59'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No soportamos numeros negativos!!'! !


!I class methodsFor: 'equality' stamp: 'FS 9/17/2020 10:49:36'!
esMayorA: numeroAComparar
	^false! !


!I class methodsFor: 'message handling - private' stamp: 'FS 9/17/2020 11:52:08'!
substraerA: unNumero
	^unNumero previous! !


!I class methodsFor: 'methods' stamp: 'FS 9/14/2020 22:30:26'!
* unNumero
	^unNumero! !

!I class methodsFor: 'methods' stamp: 'FS 9/14/2020 22:25:27'!
+ unNumero
	^unNumero next! !

!I class methodsFor: 'methods' stamp: 'FS 9/17/2020 12:20:31'!
- unRestando
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'methods' stamp: 'FS 9/17/2020 12:18:04'!
/ unDivisor
	|cociente resto|
	(unDivisor esMayorA: self) ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	(self == I) ifTrue: [^I].
	cociente := I.
	resto  := self.
	[resto := resto - unDivisor. cociente:=cociente +I.  (unDivisor esMayorA: resto) or: unDivisor == resto] whileFalse.
	^ (unDivisor==resto ifTrue: [cociente]  ifFalse: [cociente previous])! !

!I class methodsFor: 'methods' stamp: 'FS 9/14/2020 22:11:05'!
next
	^self createChildNamed:(self name, 'I')  ! !

!I class methodsFor: 'methods' stamp: 'FS 9/17/2020 11:52:08'!
previous
	^self! !


!classDefinition: #II category: #peano!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #peano!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'equality' stamp: 'FS 9/17/2020 11:53:18'!
esMayorA: numeroAComparar
	| esMayor |
	
	numeroAComparar == I ifTrue: [esMayor := true] ifFalse:[esMayor :=self previous esMayorA: numeroAComparar previous]	.
	^esMayor! !

!II class methodsFor: 'equality' stamp: 'FS 9/17/2020 10:50:08'!
esMenorA: numeroAComparar
	^ numeroAComparar esMayorA: self! !


!II class methodsFor: 'message handling - private' stamp: 'FS 9/17/2020 11:53:25'!
substraerA: unRestando
	^(self previous) substraerA: (unRestando previous)! !


!II class methodsFor: 'methods' stamp: 'FS 9/17/2020 11:52:09'!
* unMultiplicando
	^ (self previous * unMultiplicando) + unMultiplicando! !

!II class methodsFor: 'methods' stamp: 'FS 9/17/2020 11:53:29'!
+ unSumando
	^ (self previous + unSumando) next! !

!II class methodsFor: 'methods' stamp: 'FS 9/17/2020 12:21:32'!
- unRestando
	(unRestando esMayorA: self) ifTrue: [	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados].
	^unRestando substraerA: self! !

!II class methodsFor: 'methods' stamp: 'FS 9/17/2020 11:52:08'!
previous
	^self parent! !


!classDefinition: #III category: #peano!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIII category: #peano!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIII category: #peano!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIII category: #peano!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIII category: #peano!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIII category: #peano!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIII category: #peano!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIII category: #peano!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIII category: #peano!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIII category: #peano!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIII category: #peano!
IIIIIIIIIIII subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIIII category: #peano!
IIIIIIIIIIIII subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIIIII category: #peano!
IIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIIIIII category: #peano!
IIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIIIIIII category: #peano!
IIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!


!classDefinition: #IIIIIIIIIIIIIIIIII category: #peano!
IIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'peano'!
