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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackAlgo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:35:37'!
initialize
	stackAlgo := StackAlgo newStack.
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:36:23'!
isEmpty
	^stackAlgo isEmpty ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:59:24'!
pop
	| previousTop |
	
	previousTop := stackAlgo lastPushed.
	stackAlgo := stackAlgo pop.
	
	^previousTop ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:35:13'!
push: anElement
	stackAlgo := stackAlgo pushStackAlgo: anElement .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:05:54'!
size
	^stackAlgo size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:03:55'!
top
	^stackAlgo lastPushed ! !

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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:44:59'!
find: aPrefix
	
	(aPrefix size == 0) ifTrue: [ ^self error: self class finderEmptyPrefixErrorDescription. ]! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:24:22'!
initialize: aStack
	searchStack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:37:24'!
finderEmptyPrefixErrorDescription
	^'No puede haber un prefijo vacío'.
	! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'HG 10/3/2020 18:41:14'!
with: aStack
	^self new initialize: aStack.! !


!classDefinition: #StackAlgo category: #'Stack-Exercise'!
Object subclass: #StackAlgo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:35:54'!
isEmpty
	self subclassResponsibility ! !

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:20'!
lastPushed
	self subclassResponsibility ! !

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:59:36'!
pop
	self subclassResponsibility ! !

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:05:34'!
pushStackAlgo: anElement
	self subclassResponsibility ! !

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:12:32'!
size
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackAlgo class' category: #'Stack-Exercise'!
StackAlgo class
	instanceVariableNames: ''!

!StackAlgo class methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:30:58'!
newStack
	^StackVacio new ! !

!StackAlgo class methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:31:29'!
with: anElement
	^StackNoVacio new initializeWith: anElement
	! !


!classDefinition: #StackNoVacio category: #'Stack-Exercise'!
StackAlgo subclass: #StackNoVacio
	instanceVariableNames: 'top restoStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:49:32'!
initializeWith: anElement
	top := anElement. 
	restoStack := StackAlgo newStack ! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:36:06'!
isEmpty 
	^false! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:30'!
lastPushed
	^top! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:01:02'!
pop
	^restoStack ! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:05:12'!
pushStackAlgo: anElement
	restoStack := restoStack pushStackAlgo: top.
	top := anElement. 
	^self! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:04:56'!
size
	^1 + restoStack size! !


!classDefinition: #StackVacio category: #'Stack-Exercise'!
StackAlgo subclass: #StackVacio
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

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:49:05'!
pushStackAlgo: anElement
	^StackAlgo with: anElement! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 18:04:31'!
size
	^0! !
