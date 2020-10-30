!classDefinition: #TerniLapilliTest category: #TerniLapilliGame!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:04:01'!
test01AssertPlayerXStartsPlayingInNewGame
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	self assert: aTerniLapilliGame isPlayingX. 
	self deny: aTerniLapilliGame isPlayingO.
	self deny: aTerniLapilliGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:03:58'!
test02AssertPlayerOTurnIsAfterPlayerX
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	
	self assert: aTerniLapilliGame isPlayingO. 
	self deny: aTerniLapilliGame isPlayingX.
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self deny: (aTerniLapilliGame isAnOPlayerPosition: 1@1).
	self deny: aTerniLapilliGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:03:51'!
test03AssertPlayerXTurnIsAfterPlayerO
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 2@2.
	
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame isPlayingO. 
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 2@2).
	self deny: aTerniLapilliGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 20:58:14'!
test04
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 1@2.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 2@2.
	aTerniLapilliGame putXAt: 3@1.
	
	self assert: aTerniLapilliGame hasPlayerXWon.
	self deny: aTerniLapilliGame hasPlayerOWon.
	self assert: aTerniLapilliGame isOver.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 20:58:32'!
test05
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 1@2.
	aTerniLapilliGame putXAt: 3@1.
	aTerniLapilliGame putOAt: 2@2.
	aTerniLapilliGame putXAt: 3@3.
	aTerniLapilliGame putOAt: 3@2.

	self deny: aTerniLapilliGame hasPlayerXWon.
	self assert: aTerniLapilliGame hasPlayerOWon.
	self assert: aTerniLapilliGame isOver.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 20:59:54'!
test06
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 2@1.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 3@1.
	aTerniLapilliGame putXAt: 1@3.
	
	self assert: aTerniLapilliGame hasPlayerXWon.
	self deny: aTerniLapilliGame hasPlayerOWon.
	self assert: aTerniLapilliGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:00:48'!
test07
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 2@2.
	aTerniLapilliGame putOAt: 1@1.
	aTerniLapilliGame putXAt: 2@3.
	aTerniLapilliGame putOAt: 1@2.
	aTerniLapilliGame putXAt: 3@3.
	aTerniLapilliGame putOAt: 1@3.
	
	self deny: aTerniLapilliGame hasPlayerXWon.
	self assert: aTerniLapilliGame hasPlayerOWon.
	self assert: aTerniLapilliGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:17:45'!
test08
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 2@3.
	aTerniLapilliGame putOAt: 2@2.
	
	aTerniLapilliGame movePlayerOPositionFrom: 2@2 to: 2@3. 

	self deny: (aTerniLapilliGame isAnOPlayerPosition: 2@2).	
	self assert: (aTerniLapilliGame isAnOPlayerPosition: 2@3).
	self assert: aTerniLapilliGame isPlayingX.
	self deny: aTerniLapilliGame hasPlayerXWon.
	self deny: aTerniLapilliGame hasPlayerOWon.
	self deny: aTerniLapilliGame isOver.
	
	
	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'HG 10/29/2020 21:22:32'!
test09
	
	| aTerniLapilliGame |
	
	aTerniLapilliGame _ TerniLapilli new.
	aTerniLapilliGame putXAt: 1@1.
	aTerniLapilliGame putOAt: 3@3.
	aTerniLapilliGame putXAt: 2@1.
	aTerniLapilliGame putOAt: 3@2.
	aTerniLapilliGame putXAt: 1@2.
	aTerniLapilliGame putOAt: 2@2.
	
	aTerniLapilliGame movePlayerXPositionFrom: 2@1 to: 1@1. 

	self deny: (aTerniLapilliGame isAnXPlayerPosition: 2@1).	
	self assert: (aTerniLapilliGame isAnXPlayerPosition: 1@1).
	self assert: aTerniLapilliGame isPlayingO.
	self assert: aTerniLapilliGame hasPlayerXWon.
	self deny: aTerniLapilliGame hasPlayerOWon.
	self assert: aTerniLapilliGame isOver.
	
	
	
	! !


!classDefinition: #TerniLapilli category: #TerniLapilliGame!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turn xPlayerPositions oPlayerPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliGame'!

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:01:47'!
hasPlayerOWon
	^self playerOWinsByHorizontalRow
		or: self playerOWinsByDiagonal
		or: self playerOWinsByVerticalColumn.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 19:32:23'!
hasPlayerXWon
	
	^self playerXWinsByHorizontalRow
		or: self playerXWinsByDiagonal
		or: self playerXWinsByVerticalColumn.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 18:33:26'!
isAnOPlayerPosition: aBoardPosition 
	^oPlayerPositions includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 18:33:15'!
isAnXPlayerPosition: aBoardPosition 
	^xPlayerPositions includes: aBoardPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:03:22'!
isOver
	^self hasPlayerOWon or: (self hasPlayerXWon).! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 17:50:11'!
isPlayingO
	^turn = #O.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 17:50:24'!
isPlayingX
	^turn = #X.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:02:06'!
playerOWinsByDiagonal
	^((oPlayerPositions intersection: self toLeftDiagonal) size) =3
	or: ((oPlayerPositions intersection: self toRightDiagonal) size) =3.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:02:29'!
playerOWinsByHorizontalRow
	^((oPlayerPositions intersection: self firstRow) size) = 3
	or: ((oPlayerPositions intersection: self secondRow) size) = 3
	or: ((oPlayerPositions intersection: self thirdRow) size) = 3.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:02:40'!
playerOWinsByVerticalColumn
	^((oPlayerPositions intersection: self firstColumn) size) =3
	or: ((oPlayerPositions intersection: self secondColumn) size) =3
	or: ((oPlayerPositions intersection: self thirdColumn) size) =3.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 19:33:30'!
playerXWinsByDiagonal
	^((xPlayerPositions intersection: self toLeftDiagonal) size) =3
	or: ((xPlayerPositions intersection: self toRightDiagonal) size) =3.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 21:02:22'!
playerXWinsByHorizontalRow
	^((xPlayerPositions intersection: self firstRow) size) = 3
	or: ((xPlayerPositions intersection: self secondRow) size) = 3
	or: ((xPlayerPositions intersection: self thirdRow) size) = 3.! !

!TerniLapilli methodsFor: 'testing' stamp: 'HG 10/29/2020 19:34:32'!
playerXWinsByVerticalColumn
	^((xPlayerPositions intersection: self firstColumn) size) =3
	or: ((xPlayerPositions intersection: self secondColumn) size) =3
	or: ((xPlayerPositions intersection: self thirdColumn) size) =3.! !


!TerniLapilli methodsFor: 'game actions' stamp: 'HG 10/29/2020 18:52:45'!
putOAt: aBoardPosition 
	turn _ #X.
	oPlayerPositions add: aBoardPosition.
	
	! !

!TerniLapilli methodsFor: 'game actions' stamp: 'HG 10/29/2020 18:31:28'!
putXAt: aBoardPosition 
	turn _ #O.
	xPlayerPositions add: aBoardPosition.! !


!TerniLapilli methodsFor: 'initialization' stamp: 'HG 10/29/2020 18:34:14'!
initialize
	turn _ #X.
	oPlayerPositions _ OrderedCollection new.
	xPlayerPositions _ OrderedCollection new.! !


!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:35:21'!
firstColumn
	^{1@1},{1@2},{1@3}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:16:00'!
firstRow
	^{1@1},{2@1},{3@1}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:35:30'!
secondColumn
	^{2@1},{2@2},{2@3}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:16:18'!
secondRow
	^{1@2},{2@2},{3@2}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:35:39'!
thirdColumn
	^{3@1},{3@2},{3@3}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:16:27'!
thirdRow
	^{1@3},{2@3},{3@3}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:25:16'!
toLeftDiagonal
	^{1@3},{2@2},{3@1}! !

!TerniLapilli methodsFor: 'private boardgame' stamp: 'HG 10/29/2020 19:25:28'!
toRightDiagonal
	^{1@1},{2@2},{3@3}! !


!TerniLapilli methodsFor: 'moving' stamp: 'HG 10/29/2020 21:25:44'!
movePlayerOPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	oPlayerPositions add: aDestinationBoardPosition.
	oPlayerPositions remove: aSourceBoardPosition.
	self playerXTakeTurn.! !

!TerniLapilli methodsFor: 'moving' stamp: 'HG 10/29/2020 21:24:59'!
movePlayerXPositionFrom: aSourceBoardPosition to: aDestinationBoardPosition 
	xPlayerPositions remove: aSourceBoardPosition.
	xPlayerPositions add: aDestinationBoardPosition.
	self playerOTakeTurn.! !

!TerniLapilli methodsFor: 'moving' stamp: 'HG 10/29/2020 21:24:59'!
playerOTakeTurn

	^ turn _ #O! !

!TerniLapilli methodsFor: 'moving' stamp: 'HG 10/29/2020 21:25:44'!
playerXTakeTurn

	^ turn _ #X! !
