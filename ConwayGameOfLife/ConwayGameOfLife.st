!classDefinition: #GameOfLifeTest category: #ConwayGameOfLife!
TestCase subclass: #GameOfLifeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ConwayGameOfLife'!

!GameOfLifeTest methodsFor: 'as yet unclassified' stamp: 'HG 10/23/2020 10:59:15'!
test01
	
	| aGame aliveCells |
	aliveCells _ OrderedCollection with: 1@1.
	aGame _ GameOfLife withAliveCells: aliveCells ofSize: 3@3.
	aGame next.
	self assert: (aGame hasDeadCellAt: 1@1).! !

!GameOfLifeTest methodsFor: 'as yet unclassified' stamp: 'HG 10/23/2020 10:59:56'!
test02
	
	| aGame aliveCells |
	
	aliveCells _ OrderedCollection with: 1@1 with: 2@1 with: 1@2.
	aGame _ GameOfLife withAliveCells: aliveCells ofSize: 3@3.
	aGame next.
	self deny: (aGame hasDeadCellAt: 1@1).
	self deny: (aGame hasDeadCellAt: 1@2).
	self deny: (aGame hasDeadCellAt: 2@1).
	self assert: (aGame hasAliveCellAt: 1@1).
	self assert: (aGame hasAliveCellAt: 1@2).	
	self assert: (aGame hasAliveCellAt: 2@1).! !

!GameOfLifeTest methodsFor: 'as yet unclassified' stamp: 'HG 10/23/2020 11:04:05'!
test03
	
	| aGame aliveCells |
	aliveCells _ OrderedCollection with: 1@1 with: 2@1 with: 1@2 with: 2@2 with: 3@3.
	aGame _ GameOfLife withAliveCells: aliveCells ofSize: 3@3.
	aGame next.
	self deny: (aGame hasDeadCellAt: 1@1).
	self deny: (aGame hasDeadCellAt: 1@2).
	self deny: (aGame hasDeadCellAt: 2@1).
	self assert: (aGame hasDeadCellAt: 3@3).
	self assert: (aGame hasDeadCellAt: 2@2).
	
	self deny: (aGame hasAliveCellAt: 2@2).
	self assert: (aGame hasAliveCellAt: 1@1).
	self assert: (aGame hasAliveCellAt: 1@2).	
	self assert: (aGame hasAliveCellAt: 2@1).
	self deny: (aGame hasAliveCellAt: 3@3).
	
	
	"
		x x
		x x
		      x
	"! !

!GameOfLifeTest methodsFor: 'as yet unclassified' stamp: 'FS 10/23/2020 12:39:21'!
testDeadCellWithThreeAliveNeighborsBecomesAlive
	|gameOfLife|
  gameOfLife := GameOfLife withAliveCells: {1@1. 1@2. 2@1} ofSize:  3@3.
  gameOfLife next.
  self assert: (gameOfLife hasAliveCellAt: 2@2).! !


!classDefinition: #GameOfLife category: #ConwayGameOfLife!
Object subclass: #GameOfLife
	instanceVariableNames: 'size aliveCells livingCellsArray'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ConwayGameOfLife'!

!GameOfLife methodsFor: 'initialization' stamp: 'HG 10/23/2020 10:21:20'!
initializeWithAliveCells: aLivingCellsArray ofSize: aSize 
	aliveCells := aLivingCellsArray.
	size := aSize.! !


!GameOfLife methodsFor: 'game actions' stamp: 'HG 10/23/2020 11:15:35'!
aliveNeightborsSumOf: anAliveCell 
	^ ((anAliveCell eightNeighbors) intersection: aliveCells) size! !

!GameOfLife methodsFor: 'game actions' stamp: 'FS 10/23/2020 12:23:12'!
hasNotConditionsToKeepAlive: anAliveCell

	^ ((self aliveNeightborsSumOf: anAliveCell) between: 2 and: 3) not! !

!GameOfLife methodsFor: 'game actions' stamp: 'HG 10/23/2020 11:17:28'!
next
	
	aliveCells removeAllSuchThat: [:anAliveCell | 
		self hasNotConditionsToKeepAlive: anAliveCell
	].
	! !


!GameOfLife methodsFor: 'accesing' stamp: 'HG 10/23/2020 10:31:02'!
hasAliveCellAt: aPoint 
	^aliveCells includes: aPoint .! !

!GameOfLife methodsFor: 'accesing' stamp: 'HG 10/23/2020 10:22:48'!
hasDeadCellAt: aPoint 
	^(aliveCells  includes: aPoint) not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #ConwayGameOfLife!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'instance creation' stamp: 'HG 10/23/2020 10:20:13'!
withAliveCells: aLivingCellsArray ofSize: aSize 
	^self new initializeWithAliveCells: aLivingCellsArray ofSize: aSize ! !
