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

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stackAlgo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:06:19'!
initialize
	stack := StackAlgo new.
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 16:38:44'!
isEmpty
	^stack isEmpty ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:33:02'!
push: anElement
	stackAlgo := stackAlgo pushStackAlgo: anElement .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackAlgo category: #'Stack-Exercise'!
Object subclass: #StackAlgo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:28:01'!
apilarUn: anElement
	^self class apilarUn: anElement en: self ! !

!StackAlgo methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:05:34'!
pushStackAlgo: anElement
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

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:17:29'!
initializeWith: anElement
	top := anElement. 
	restoStack := StackVacio new! !

!StackNoVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:05:12'!
pushStackAlgo: anElement
	restoStack := restoStack pushStackAlgo: top.
	top := anElement. 
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackNoVacio class' category: #'Stack-Exercise'!
StackNoVacio class
	instanceVariableNames: ''!

!StackNoVacio class methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:16:55'!
with: anElement
	self new initializeWith: anElement! !


!classDefinition: #StackVacio category: #'Stack-Exercise'!
StackAlgo subclass: #StackVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 16:37:39'!
isEmpty
	^true! !

!StackVacio methodsFor: 'as yet unclassified' stamp: 'FS 10/3/2020 17:12:53'!
pushStackAlgo: anElement
	^StackNoVacio with: anElement! !
