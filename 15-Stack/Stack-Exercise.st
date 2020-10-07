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
	instanceVariableNames: 'emptyStack finderWithEmptyStack stringHola stackWithWinPrefixes stackWithWinter stringWinter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:26:44'!
setUp
	| winningString |
	
	emptyStack := OOStack new.
	finderWithEmptyStack := SentenceFinderByPrefix with: emptyStack.
	stringHola := 'Hola'.
	
	
	stringWinter := 'Winter is coming'.
	winningString := 'Winning Eleven'.
	stackWithWinPrefixes := OOStack new.
	stackWithWinPrefixes push: stringWinter.
	stackWithWinPrefixes push: winningString.
	stackWithWinter := OOStack new.
	stackWithWinter push: stringWinter.
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:06:27'!
test01EmptyPrefixGetsError

	self
		should: [ finderWithEmptyStack find: ''.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderEmptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:06:31'!
test02WithSpacesPrefixGetsError
	
	self
		should: [ finderWithEmptyStack find: 'Hola Como estas.'.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderWithSpacesPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:12:03'!
test03SearchInEmptyStackReturnsAnEmptyFilteredStack

	self assert: (finderWithEmptyStack find: stringHola) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:27:00'!
test04SearchInStackWithPrefixReturnsAFilteredStack
	
	| finder aSearchPrefix |
	
	finder := SentenceFinderByPrefix with: stackWithWinPrefixes.
	aSearchPrefix := 'Wint'.
	
	self assert: (finder find: aSearchPrefix) size equals: 1.
	self assert: (finder find: aSearchPrefix) top equals: stringWinter.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'HG 10/7/2020 00:27:50'!
test05SearchInStackWithPrefixNotFoundReturnsAnEmptyStack
	
	| finder |
	finder := SentenceFinderByPrefix with: stackWithWinPrefixes .
	self assert: (finder find: stringHola) isEmpty.! !


!classDefinition: #ElementoDeStack category: #'Stack-Exercise'!
Object subclass: #ElementoDeStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDeStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:21:44'!
elementUnderneath
	self subclassResponsibility ! !

!ElementoDeStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:01:07'!
esBase
	self subclassResponsibility ! !

!ElementoDeStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:33:27'!
height
	self subclassResponsibility ! !

!ElementoDeStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:33:23'!
value
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoDeStack class' category: #'Stack-Exercise'!
ElementoDeStack class
	instanceVariableNames: ''!

!ElementoDeStack class methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:18:37'!
newElement
	^BaseStack new! !


!classDefinition: #BaseStack category: #'Stack-Exercise'!
ElementoDeStack subclass: #BaseStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:37:08'!
elementUnderneath
	^self error: OOStack  stackEmptyErrorDescription! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:03:04'!
esBase
	^true! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:32:56'!
height
	^0! !

!BaseStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:37:00'!
value
	^self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #StackedElement category: #'Stack-Exercise'!
ElementoDeStack subclass: #StackedElement
	instanceVariableNames: 'nextElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:26:45'!
elementUnderneath
	 
	^nextElement ! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:01:18'!
esBase
	^false! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:32:51'!
height
	^1 + nextElement height! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:21:09'!
initializeWith: anElementValue onTopOf: anElementUnderneath
	value := anElementValue.
	nextElement := anElementUnderneath! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:29:06'!
value
	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackedElement class' category: #'Stack-Exercise'!
StackedElement class
	instanceVariableNames: ''!

!StackedElement class methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:14:53'!
with: anElement onTopOf: anElementUnderneath
	^self new initializeWith: anElement onTopOf: anElementUnderneath! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:10:09'!
initialize
	top := ElementoDeStack newElement ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:02:25'!
isEmpty
	^top esBase ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:28:39'!
pop
	|previousTop|
	
	previousTop := top value.
	top:= top elementUnderneath.
	^previousTop
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:44:02'!
push: anElementValue
	top := StackedElement with: anElementValue onTopOf: top! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:33:51'!
size
	^top height! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/5/2020 20:29:20'!
top
	^top value! !

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

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'HG 10/3/2020 18:24:22'!
initialize: aStack
	searchStack := aStack.! !


!SentenceFinderByPrefix methodsFor: 'finder management' stamp: 'HG 10/6/2020 23:59:34'!
filterSentencesWithPrefix: aPrefixToSearch
	
	| filteredStack copyOfOriginalStack beginsWithPrefixVerificationBlock |
	
	filteredStack := OOStack new.
	copyOfOriginalStack := searchStack copy.
	
	beginsWithPrefixVerificationBlock := [:aSentenceToCheckPrefix | aSentenceToCheckPrefix beginsWith: aPrefixToSearch].
	
	[ copyOfOriginalStack isEmpty ]
		whileFalse: [ 
						| topOfOriginalStack |
						topOfOriginalStack := copyOfOriginalStack top.
						(beginsWithPrefixVerificationBlock value: topOfOriginalStack)
							ifTrue: [filteredStack push: topOfOriginalStack].  
							copyOfOriginalStack pop.
					].
	^filteredStack.! !

!SentenceFinderByPrefix methodsFor: 'finder management' stamp: 'HG 10/7/2020 00:39:17'!
find: aPrefixToSearch
	
	self assertPrefixNotEmpty: aPrefixToSearch.
	self assertPrefixWithNoBlankSpaces: aPrefixToSearch. 
	^self filterSentencesWithPrefix: aPrefixToSearch.
	! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'HG 10/7/2020 00:38:16'!
assertPrefixNotEmpty: aPrefixToCheck
	(aPrefixToCheck size == 0) ifTrue: [ ^self error: self class finderEmptyPrefixErrorDescription. ].! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'HG 10/7/2020 00:39:07'!
assertPrefixWithNoBlankSpaces: aPrefixToCheck
	(aPrefixToCheck findString: ' ') ==0 ifFalse: [ ^self error: self class finderWithSpacesPrefixErrorDescription. ].
! !

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
