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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:44:24'!
test01EmptyPrefixGetsError

	self
		should: [ finderWithEmptyStack find: ''. self fail.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderEmptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:44:34'!
test02WithSpacesPrefixGetsError
	
	self
		should: [ finderWithEmptyStack find: 'Hola Como estas.'. self fail.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix finderWithSpacesPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:04:32'!
test03SearchInEmptyStackReturnsAnEmptyFilteredCollection

	self assert: (finderWithEmptyStack find: stringHola) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:04:13'!
test04SearchInStackWithPrefixReturnsAFilteredCollection
	
	| finder aSearchPrefix |
	
	finder := SentenceFinderByPrefix with: stackWithWinPrefixes.
	aSearchPrefix := 'Wint'.
	
	self assert: (finder find: aSearchPrefix) size equals: 1.
	self assert: (finder find: aSearchPrefix) last equals: stringWinter.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:04:01'!
test05SearchInStackWithPrefixNotFoundReturnsAnEmptyCollection
	
	| finder |
	finder := SentenceFinderByPrefix with: stackWithWinPrefixes .
	self assert: (finder find: stringHola) isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'HG 10/7/2020 21:38:26'!
test06SearchInStackWithFinderMantainsOriginalStack
	
	| finder aStackCopy |
	
	aStackCopy := stackWithWinPrefixes copy.
	finder := SentenceFinderByPrefix with: stackWithWinPrefixes.
	finder find: stringHola.
	
	self assert: aStackCopy size equals: stackWithWinPrefixes size.
	[aStackCopy isEmpty]
		whileFalse: [ self assert: aStackCopy top equals: stackWithWinPrefixes top. aStackCopy pop. stackWithWinPrefixes pop.].! !


!SentenceFinderByPrefixTest methodsFor: 'initialization' stamp: 'HG 10/7/2020 00:26:44'!
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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'HG 10/7/2020 21:10:57'!
initialize
	top := StackElement newElement ! !


!OOStack methodsFor: 'accessing' stamp: 'FS 10/5/2020 20:33:51'!
size
	^top height! !

!OOStack methodsFor: 'accessing' stamp: 'FS 10/5/2020 20:29:20'!
top
	^top value! !


!OOStack methodsFor: 'adding' stamp: 'FS 10/5/2020 20:44:02'!
push: anElementValue
	top := StackedElement with: anElementValue onTopOf: top! !


!OOStack methodsFor: 'testing' stamp: 'HG 10/7/2020 21:12:14'!
isEmpty
	^top isABaseElement ! !


!OOStack methodsFor: 'removing' stamp: 'FS 10/5/2020 20:28:39'!
pop
	|previousTop|
	
	previousTop := top value.
	top:= top elementUnderneath.
	^previousTop
	! !

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


!SentenceFinderByPrefix methodsFor: 'finder management' stamp: 'HG 10/7/2020 21:32:53'!
filterFrom: aStackToFilter withCondition: aConditionToCheckBlock
	
	| filteredCollection |
	
	filteredCollection := OrderedCollection new.
	[ aStackToFilter isEmpty ]
		whileFalse: [ 
						| topOfStack |
						topOfStack := aStackToFilter top.
						(aConditionToCheckBlock value: topOfStack)
							ifTrue: [filteredCollection add: topOfStack].  
							aStackToFilter pop.
					].
	^filteredCollection.! !

!SentenceFinderByPrefix methodsFor: 'finder management' stamp: 'HG 10/7/2020 21:32:18'!
filterSentencesWithPrefix: aPrefixToSearch
	
	| copyOfOriginalStack beginsWithPrefixVerificationBlock |
	
	copyOfOriginalStack := searchStack copy.
	
	beginsWithPrefixVerificationBlock := [:aSentenceToCheckPrefix | aSentenceToCheckPrefix beginsWith: aPrefixToSearch].
	
	^self filterFrom: copyOfOriginalStack withCondition: beginsWithPrefixVerificationBlock.
	! !

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

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'HG 10/3/2020 18:37:24'!
finderEmptyPrefixErrorDescription
	^'No puede haber un prefijo vacío'.
	! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'HG 10/5/2020 17:42:25'!
finderWithSpacesPrefixErrorDescription
	^'No puede haber un prefijo con espacios en blanco'.! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'HG 10/3/2020 18:41:14'!
with: aStack
	^self new initialize: aStack.! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'testing' stamp: 'HG 10/7/2020 21:12:14'!
isABaseElement
	self subclassResponsibility ! !


!StackElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:21:44'!
elementUnderneath
	self subclassResponsibility ! !

!StackElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:33:27'!
height
	self subclassResponsibility ! !

!StackElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:33:23'!
value
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: #'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'instance creation' stamp: 'HG 10/7/2020 21:11:18'!
newElement
	^BaseElement new! !


!classDefinition: #BaseElement category: #'Stack-Exercise'!
StackElement subclass: #BaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:37:08'!
elementUnderneath
	^self error: OOStack  stackEmptyErrorDescription! !

!BaseElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:32:56'!
height
	^0! !

!BaseElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:37:00'!
value
	^self error: OOStack stackEmptyErrorDescription! !


!BaseElement methodsFor: 'testing' stamp: 'HG 10/7/2020 21:12:19'!
isABaseElement
	^true.! !


!classDefinition: #StackedElement category: #'Stack-Exercise'!
StackElement subclass: #StackedElement
	instanceVariableNames: 'nextElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'initialization' stamp: 'HG 10/7/2020 21:13:09'!
initializeWith: anElementValue onTopOf: anElementUnderneath
	value := anElementValue.
	nextElement := anElementUnderneath.! !


!StackedElement methodsFor: 'testing' stamp: 'HG 10/7/2020 21:12:14'!
isABaseElement
	^false! !


!StackedElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:26:45'!
elementUnderneath
	 
	^nextElement ! !

!StackedElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:32:51'!
height
	^1 + nextElement height! !

!StackedElement methodsFor: 'accesing' stamp: 'FS 10/5/2020 20:29:06'!
value
	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackedElement class' category: #'Stack-Exercise'!
StackedElement class
	instanceVariableNames: ''!

!StackedElement class methodsFor: 'instance creation' stamp: 'FS 10/5/2020 20:14:53'!
with: anElement onTopOf: anElementUnderneath
	^self new initializeWith: anElement onTopOf: anElementUnderneath! !
