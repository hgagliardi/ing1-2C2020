!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'FS 10/3/2020 18:05:18'!
test02PushAddElementsToTheStack

	| stack |.
	stack := OOStack new.
	stack push: 'something'.

	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:43:00'!
test01EmptyPrefixGetsError
	
	| stack finder  |
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self
		should: [ finder find: ''.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderEmptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 17:42:09'!
test02WithSpacesPrefixGetsError
	
	| stack finder  |
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	self
		should: [ finder find: 'Hola Como estas.'.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderWithSpacesPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 17:51:52'!
test03SearchInEmptyStackReturnsAnEmptyFilteredStack
	
	| stack finder unString |
	stack := OOStack new.
	finder := SentenceFinderByPrefix with: stack.
	unString := 'Hola'.
	self assert: (finder find: unString) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 18:07:28'!
test04SearchInStackWithPrefixReturnsAFilteredStack
	
	| stack finder aSearchPrefix aFoundString aNotFoundString stackFiltered |
	stack := OOStack new.
	aFoundString := 'Winter is coming'.
	aNotFoundString := 'Winning Eleven'.
	stack push: aFoundString.
	stack push: aNotFoundString.
	
	finder := SentenceFinderByPrefix with: stack.
	aSearchPrefix := 'Wint'.
	
	stackFiltered := OOStack new.
	stackFiltered push: 'Winter is coming'.
	
	self assert: (finder find: aSearchPrefix) size equals: 1.
	self assert: (finder find: aSearchPrefix) top equals: aFoundString.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 18:13:02'!
test05SearchInStackWithPrefixNotFoundReturnsAnEmptyStack
	
	| stack finder aSearchPrefix aNotFoundString |
	stack := OOStack new.
	aNotFoundString := 'Winter is coming'.
	stack push: aNotFoundString.
	aNotFoundString := 'Winning Eleven'.
	stack push: aNotFoundString.
	
	finder := SentenceFinderByPrefix with: stack.
	aSearchPrefix := 'Hola'.
	
	self assert: (finder find: aSearchPrefix) isEmpty.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackEstatico'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:17:03'!
initialize
	stackEstatico := StackEstatico new.
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:14:15'!
isEmpty
	^stackEstatico isEmpty ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:14:15'!
pop
	| previousTop |
	
	previousTop := stackEstatico lastPushed.
	stackEstatico := stackEstatico pop.
	
	^previousTop ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:15:12'!
push: anElement
	stackEstatico := stackEstatico push: anElement .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 18:03:49'!
searchWithCondition:  aConditionBlock
	
	| filtered backupStack |
	
	filtered := self species new.
	backupStack := self copy.
	
	[ backupStack isEmpty ]
		whileFalse: [ (aConditionBlock value: (backupStack top)) 
							ifTrue: [filtered push: backupStack top].  
							backupStack pop.
					].
	^filtered.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:14:15'!
size
	^stackEstatico size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:14:15'!
top
	^stackEstatico lastPushed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'searchStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 18:29:54'!
find: aPrefix
	
	| filteredList prefixSearchBlock |
	
	filteredList := OOStack new.
	
	(aPrefix size == 0) ifTrue: [ ^self error: self class finderEmptyPrefixErrorDescription. ].
	(aPrefix findString: ' ')==0 ifFalse: [ ^self error: self class finderWithSpacesPrefixErrorDescription. ].
	
	prefixSearchBlock := [:searchElement | 
			(searchElement beginsWith: aPrefix).
		].
	
	filteredList := self searchWithCondition: prefixSearchBlock.
	
	^filteredList.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:24:22'!
initialize: aStack
	searchStack := aStack.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 18:30:07'!
searchWithCondition: aConditionBlock
	
	| filtered backupStack |
	
	filtered := OOStack new.
	backupStack := searchStack copy.
	
	[ backupStack isEmpty ]
		whileFalse: [ (aConditionBlock value: (backupStack top)) 
							ifTrue: [filtered push: backupStack top].  
							backupStack pop.
					].
	^filtered.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:37:24'!
finderEmptyPrefixErrorDescription
	^'No puede haber un prefijo vacío'.
	! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'HG 10/5/2020 17:42:25'!
finderWithSpacesPrefixErrorDescription
	^'No puede haber un prefijo con espacios en blanco'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:41:14'!
with: aStack
	^self new initialize: aStack.! !


!classDefinition: #StackEstatico category: #'Stack-Exercise'!
Object subclass: #StackEstatico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackEstatico methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:35:54'!
isEmpty
	self subclassResponsibility ! !

!StackEstatico methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:20'!
lastPushed
	self subclassResponsibility ! !

!StackEstatico methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:59:36'!
pop
	self subclassResponsibility ! !

!StackEstatico methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:15:11'!
push: anElement
	self subclassResponsibility ! !

!StackEstatico methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:12:32'!
size
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackEstatico class' category: #'Stack-Exercise'!
StackEstatico class
	instanceVariableNames: ''!

!StackEstatico class methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:16:04'!
new
	^StackVacio basicNew ! !

!StackEstatico class methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:15:37'!
with: anElement
	^StackNoVacio basicNew initializeWith: anElement
	! !


!classDefinition: #StackNoVacio category: #'Stack-Exercise'!
StackEstatico subclass: #StackNoVacio
	instanceVariableNames: 'top restoStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:17:38'!
initializeWith: anElement
	top := anElement. 
	restoStack := StackEstatico new ! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:36:06'!
isEmpty 
	^false! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:30'!
lastPushed
	^top! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:02'!
pop
	^restoStack ! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:15:12'!
push: anElement
	restoStack := restoStack push: top.
	top := anElement. 
	^self! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:04:56'!
size
	^1 + restoStack size! !


!classDefinition: #StackVacio category: #'Stack-Exercise'!
StackEstatico subclass: #StackVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 16:37:39'!
isEmpty
	^true! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:11:20'!
lastPushed
	^self error: OOStack stackEmptyErrorDescription! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:11:58'!
pop
	^self error: OOStack stackEmptyErrorDescription 	! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 14:15:11'!
push: anElement
	^StackEstatico with: anElement! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:04:31'!
size
	^0! !
