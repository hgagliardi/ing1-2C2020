!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 5/7/2020 17:46:14'!
test27EnteroSubstractsEnteroCorrectly

	self assert: three - one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 17:28:15'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 04:33:41'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
!Entero commentStamp: '<historical>' prior: 0!
Zero new!


!Entero methodsFor: 'arithmetic operations' stamp: 'FS 9/29/2020 12:35:27'!
* aMultiplier 
	
	^aMultiplier multiplicarPorEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FS 9/29/2020 12:23:05'!
+ anAdder 
	
	^anAdder sumarEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FS 10/1/2020 12:43:23'!
- aSubtrahend 
	
	^aSubtrahend restarComoSubstraendoDeEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FS 10/1/2020 12:42:59'!
/ aDivisor 
	
	^aDivisor dividirComoDivisorDeEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HG 10/1/2020 00:56:47'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	self canBeIndexOfFibonacciSequence.
	(self zeroOrOneReturnsBlock: [^one]) value.
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'checks' stamp: 'HG 9/30/2020 01:17:48'!
canBeDenominator
	self subclassResponsibility.! !

!Entero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:29'!
canBeDivisor
	self subclassResponsibility .! !

!Entero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:48:10'!
canBeIndexOfFibonacciSequence
	self subclassResponsibility.! !

!Entero methodsFor: 'checks' stamp: 'HG 9/30/2020 01:18:08'!
canBeNumerator
	self subclassResponsibility.! !

!Entero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:44'!
onNegativeReturnsBlock: aBlock
	self subclassResponsibility .! !

!Entero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:51:17'!
onOneReturnsBlock: aBlock
	 self subclassResponsibility .! !

!Entero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:52:00'!
onZeroReturnsBlock: aBlock
	self subclassResponsibility .! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:42:59'!
dividirComoDivisorDeEntero: unDividendoEntero
	^Fraccion with: unDividendoEntero over: self! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:12'!
dividirComoDivisorDeFraccion: unDividendoFraccionario
	^unDividendoFraccionario numerator / (unDividendoFraccionario denominator * self)! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:28:46'!
multiplicarPorEntero: unMultiplicandoEntero
	^self class with:  unMultiplicandoEntero integerValue * value ! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:36:37'!
multiplicarPorFraccion: unMultiplicandoFraccionario
	^unMultiplicandoFraccionario multiplicarPorEntero: self! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:23'!
restarComoSubstraendoDeEntero: unSubstraendoEntero
	^ self class with: unSubstraendoEntero integerValue - value.! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:39'!
restarComoSubstraendoDeFraccion: unSubstraendoFraccionario
	| newNumerator newDenominator |
			
	newNumerator :=  unSubstraendoFraccionario numerator - (unSubstraendoFraccionario denominator * self)   .
	newDenominator := unSubstraendoFraccionario denominator .
			
	^newNumerator / newDenominator ! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:09:08'!
sumarEntero: unSumandoEntero
	^self class with: unSumandoEntero integerValue + value! !

!Entero methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:11:39'!
sumarFraccion: unSumandoFraccionario
	^unSumandoFraccionario sumarEntero: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'HG 9/30/2020 01:09:27'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	(aValue==1) ifTrue: [^One new initalizeWith: aValue].
	(aValue>0) ifTrue: [^EnteroPositivo new initalizeWith: aValue].
	(aValue<0) ifTrue: [^EnteroNegativo new initalizeWith: aValue].
	^Zero new initalizeWith: 0! !


!classDefinition: #EnteroNegativo category: #'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 9/30/2020 01:00:55'!
canBeDenominator

	^nil.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:02'!
canBeDivisor
	^nil.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:53:39'!
canBeIndexOfFibonacciSequence
	^self error: self class negativeFibonacciErrorDescription.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 9/30/2020 01:02:18'!
canBeNumerator

	^nil.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:49'!
onNegativeReturnsBlock: aBlock
	^aBlock.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:51:31'!
onOneReturnsBlock: aBlock
	 ^nil.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:52:07'!
onZeroReturnsBlock: aBlock
	^nil.! !

!EnteroNegativo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:56:34'!
zeroOrOneReturnsBlock: aBlock
	^nil.! !


!classDefinition: #EnteroPositivo category: #'Numero-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 9/30/2020 01:14:42'!
canBeDenominator

	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:07'!
canBeDivisor
	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:53:56'!
canBeIndexOfFibonacciSequence
	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 9/30/2020 01:02:12'!
canBeNumerator

	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:54'!
onNegativeReturnsBlock: aBlock
	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:51:44'!
onOneReturnsBlock: aBlock
	 ^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:52:10'!
onZeroReturnsBlock: aBlock
	^nil.! !

!EnteroPositivo methodsFor: 'checks' stamp: 'HG 10/1/2020 00:56:20'!
zeroOrOneReturnsBlock: aBlock
	^nil.! !


!classDefinition: #One category: #'Numero-Exercise'!
EnteroPositivo subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!One methodsFor: 'checks' stamp: 'HG 9/30/2020 01:03:17'!
canBeDenominator
	^self error: 'una fraccion no puede tener denominador 1 porque sino es un entero'.! !

!One methodsFor: 'checks' stamp: 'HG 9/30/2020 01:18:33'!
canBeNumerator
	^nil.! !

!One methodsFor: 'checks' stamp: 'HG 10/1/2020 00:24:31'!
onOneReturnsBlock: aBlock
	 ^aBlock.! !

!One methodsFor: 'checks' stamp: 'HG 10/1/2020 00:56:08'!
zeroOrOneReturnsBlock: aBlock
	^aBlock.! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
!Zero commentStamp: '<historical>' prior: 0!
Zero initializeWith: 4!


!Zero methodsFor: 'checks' stamp: 'HG 9/30/2020 23:35:40'!
canBeDenominator
	
	^self error: 'el cero no puede ser denominador'.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:18:45'!
canBeDivisor

	^self error: self class canNotDivideByZeroErrorDescription.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:54:00'!
canBeIndexOfFibonacciSequence
	^nil.! !

!Zero methodsFor: 'checks' stamp: 'HG 9/30/2020 01:02:04'!
canBeNumerator

	^self error: 'una fraccion no puede ser cero'.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:50:59'!
onNegativeReturnsBlock: aBlock
	^nil.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:51:35'!
onOneReturnsBlock: aBlock
	 ^nil.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:13:00'!
onZeroReturnsBlock: aBlock
	^aBlock.! !

!Zero methodsFor: 'checks' stamp: 'HG 10/1/2020 00:56:12'!
zeroOrOneReturnsBlock: aBlock
	^aBlock.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FS 9/29/2020 12:35:23'!
* aMultiplier 
	^aMultiplier multiplicarPorFraccion: self
	
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FS 9/29/2020 12:23:21'!
+ anAdder 
	^anAdder sumarFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FS 10/1/2020 12:43:39'!
- aSubtrahend 
	
	^aSubtrahend restarComoSubstraendoDeFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FS 10/1/2020 12:43:12'!
/ aDivisor 
	
	^aDivisor dividirComoDivisorDeFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HG 9/30/2020 01:02:50'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator canBeNumerator.
	aDenominator canBeDenominator .
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:42:59'!
dividirComoDivisorDeEntero: unDividendoEntero
	^ ( unDividendoEntero * denominator) /  numerator ! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:12'!
dividirComoDivisorDeFraccion: unDividendoFraccionario
	^(unDividendoFraccionario numerator * self denominator) / (unDividendoFraccionario denominator * self numerator)! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:31:13'!
multiplicarPorEntero: unMultiplicando
	 ^(numerator * unMultiplicando ) / denominator ! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:33:57'!
multiplicarPorFraccion: unMultiplicandoFraccionario
	^(numerator * unMultiplicandoFraccionario numerator) / (denominator * unMultiplicandoFraccionario denominator)
	! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:23'!
restarComoSubstraendoDeEntero: unSubstraendoEntero
	| newNumerator newDenominator |
			
	newNumerator :=  (denominator * unSubstraendoEntero) - numerator  .
	newDenominator := denominator .
			
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 10/1/2020 12:43:39'!
restarComoSubstraendoDeFraccion: unSubstraendoFraccionario
	| newNumerator newDenominator |
		
	newNumerator :=  (denominator * unSubstraendoFraccionario numerator) - (numerator * unSubstraendoFraccionario denominator) .
	newDenominator := denominator * unSubstraendoFraccionario denominator.
		
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:21:07'!
sumarEntero: unSumandoEntero
	|nuevoDenominador nuevoNumerador|
	nuevoDenominador := denominator.
	nuevoNumerador := numerator + (unSumandoEntero * denominator).
	^nuevoNumerador / nuevoDenominador! !

!Fraccion methodsFor: 'operaciones aritmeticas privadas' stamp: 'FS 9/29/2020 12:13:10'!
sumarFraccion: unSumandoFraccionario

	| newNumerator newDenominator |
		
	newNumerator := (numerator * unSumandoFraccionario denominator) + (denominator * unSumandoFraccionario numerator).
	newDenominator := denominator * unSumandoFraccionario denominator.
		
	^newNumerator / newDenominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'FS 10/1/2020 12:42:20'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	
	aDivisor canBeDivisor.
	(aDividend onZeroReturnsBlock: [ ^aDividend ]) value.
	(aDivisor onNegativeReturnsBlock: [ ^aDividend negated / aDivisor negated]) value.
		
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	(denominator onOneReturnsBlock: [^numerator]) value.

	^self new initializeWith: numerator over: denominator.
	! !
