!classDefinition: #MarsRoverTest category: 'EjercicioMarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'south north west east'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:27:16'!
test04rotatingLeftDirectionFromSouthPointsEast
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self assert: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:27:04'!
test05rotatingRightDirectionFromSouthPointsWest
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self assert: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:30:39'!
test08rotatingRightDirectionFromNorthPointsEast
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self assert: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:30:59'!
test09rotatingLeftDirectionFromNorthPointsWest
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self assert: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:32:06'!
test12rotatingRightDirectionFromWestPointsNorth
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self assert: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:32:45'!
test13rotatingLeftDirectionFromWestPointsSouth
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self assert: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:33:44'!
test16rotatingRightDirectionFromEastPointsSouth
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self assert: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'rotating tests' stamp: 'HG 10/25/2020 14:34:00'!
test17rotatingLeftDirectionFromEastPointsNorth
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self assert: Rover pointsNorth.! !


!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:29:21'!
test02movingForwardWithSouthDirectionGoesDownInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:25:57'!
test03movingBackwardWithSouthDirectionGoesUpInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:29:53'!
test06movingForwardWithNorthDirectionGoesUpInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:30:12'!
test07movingBackwardWithNorthDirectionGoesDownInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:31:26'!
test10movingForwardWithWestDirectionGoesLeftInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@2! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:31:45'!
test11movingBackwardWithWestDirectionGoesRightInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 3@2! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:33:05'!
test14movingForwardWithEastDirectionGoesRightInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 3@2.! !

!MarsRoverTest methodsFor: 'movement tests' stamp: 'HG 10/25/2020 14:33:24'!
test15movingBackwardWithEastDirectionGoesLeftInGrid
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@2.! !


!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:35:13'!
test18movingForwardWithWestDirectionInWestBorderGoesToEastBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:35:57'!
test19movingForwardWithNorthDirectionInNorthBorderGoesToSouthBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@3.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:36:17'!
test20movingForwardWithSouthDirectionInSouthBorderGoesToNorthBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@3 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:36:37'!
test21movingForwardWithEastDirectionInEastBorderGoesToWestBorder
	| Rover|
	Rover _ MarsRover startingAt: 3@1 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:37:53'!
test22movingBackwardWithWestDirectionInEastBorderGoesToWestBorder
	| Rover|
	Rover _ MarsRover startingAt: 3@1 pointingTo: west withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:38:28'!
test23movingBackwardWithNorthDirectionInSouthBorderGoesToNorthBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@3 pointingTo: north withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:38:59'!
test24movingBackwardWithEastDirectionInWestBorderGoesToEastBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: east withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'movement grid border tests' stamp: 'HG 10/25/2020 14:39:18'!
test25movingBackwardWithSouthDirectionInNorthBorderGoesToSouthBorder
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@3.! !


!MarsRoverTest methodsFor: 'multiple orders tests' stamp: 'HG 10/25/2020 14:41:06'!
test26assertValidOrderSequenceGoingForwardAndRotate
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'ffr'.
	
	self assert: Rover currentPosition equals: 1@3.
	self assert: Rover pointsWest.! !


!MarsRoverTest methodsFor: 'invalid order test' stamp: 'HG 10/25/2020 14:42:24'!
test27assertStopExecutionAtInvalidOrder
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo: south withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'frNKf'.
	
	self assert: Rover currentPosition equals: 1@2.
	self assert: Rover pointsWest .
	 ! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'HG 10/25/2020 12:38:23'!
setUp
	south _ South new.
	north _ North new.
	west _ West new.
	east _ East new.! !


!classDefinition: #GridCardinalPoints category: 'EjercicioMarsRover'!
Object subclass: #GridCardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!GridCardinalPoints methodsFor: 'movement directions' stamp: 'HG 10/25/2020 13:08:15'!
movementValue
	self subclassResponsibility.! !


!GridCardinalPoints methodsFor: 'rotating directions' stamp: 'HG 10/25/2020 13:08:36'!
rotateLeft
	self subclassResponsibility.! !

!GridCardinalPoints methodsFor: 'rotating directions' stamp: 'HG 10/25/2020 13:08:39'!
rotateRight
	self subclassResponsibility.! !


!GridCardinalPoints methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:29'!
isEast
	self subclassResponsibility.! !

!GridCardinalPoints methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:22'!
isNorth
	self subclassResponsibility.! !

!GridCardinalPoints methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:24'!
isSouth
	self subclassResponsibility.! !

!GridCardinalPoints methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:27'!
isWest
	self subclassResponsibility.! !


!classDefinition: #East category: 'EjercicioMarsRover'!
GridCardinalPoints subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!East methodsFor: 'rotating' stamp: 'HG 10/25/2020 13:20:26'!
rotateLeft
	^North new.! !

!East methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:54:27'!
rotateRight
	^South new.! !


!East methodsFor: 'movement' stamp: 'HG 10/25/2020 12:31:21'!
movementValue
	^-1@0.! !


!East methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:57'!
isEast
	^true.! !

!East methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:05'!
isNorth
	^false.! !

!East methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:08'!
isSouth
	^false.! !

!East methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:11'!
isWest
	^false.! !


!classDefinition: #North category: 'EjercicioMarsRover'!
GridCardinalPoints subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!North methodsFor: 'movement' stamp: 'HG 10/25/2020 12:28:50'!
movementValue
	^0@1.! !


!North methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:52:06'!
rotateLeft
	^West new.! !

!North methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:51:56'!
rotateRight
	^East new.! !


!North methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:25'!
isEast
	^false.! !

!North methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:35'!
isNorth
	^true.! !

!North methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:28'!
isSouth
	^false.! !

!North methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:22'!
isWest
	^false.! !


!classDefinition: #South category: 'EjercicioMarsRover'!
GridCardinalPoints subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!South methodsFor: 'movement' stamp: 'HG 10/25/2020 12:27:02'!
movementValue
	^0@-1.! !


!South methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:50:55'!
rotateLeft
	^East new.! !

!South methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:51:32'!
rotateRight
	^West new.! !


!South methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:00'!
isEast	
	^false.! !

!South methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:56'!
isNorth
	^false.! !

!South methodsFor: 'testing' stamp: 'HG 10/25/2020 13:14:46'!
isSouth
	^true.! !

!South methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:03'!
isWest	
	^false.! !


!classDefinition: #West category: 'EjercicioMarsRover'!
GridCardinalPoints subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!West methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:53:52'!
rotateLeft
	^South new.! !

!West methodsFor: 'rotating' stamp: 'HG 10/25/2020 12:54:00'!
rotateRight
	^North new.! !


!West methodsFor: 'movement' stamp: 'HG 10/25/2020 12:31:10'!
movementValue
	^1@0.! !


!West methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:37'!
isEast	
	^false.! !

!West methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:55'!
isNorth
	^false.! !

!West methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:49'!
isSouth
	^false.! !

!West methodsFor: 'testing' stamp: 'HG 10/25/2020 13:15:32'!
isWest	
	^true.! !


!classDefinition: #MarsRover category: 'EjercicioMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction mapHeight mapWidth validOrders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'HG 10/25/2020 14:21:03'!
initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth 
	position := aStartingPoint.
	direction := aCardinalPoint.
	mapHeight := aMapHeight.
	mapWidth := aMapWidth.
	
	validOrders _ {
		$f -> [position _ position - (direction movementValue).].
		$b -> [position _ position + (direction movementValue).].
		$r -> [direction _ direction rotateRight.].
		$l -> [direction _ direction rotateLeft.].
	} asDictionary.! !


!MarsRover methodsFor: '- private' stamp: 'HG 10/25/2020 14:22:52'!
fixPositionWithinBorder

	position y <1 ifTrue:[position _ (position x)@(mapHeight)].
	position y > mapHeight ifTrue:[position _ (position x)@1].
	position x <1 ifTrue: [position _ mapWidth@(position y)].
	position x > mapWidth ifTrue: [position _ 1@(position y)].! !


!MarsRover methodsFor: 'actions' stamp: 'HG 10/25/2020 14:22:52'!
executeValidOrder: aValidOrderToExecute
	(validOrders at: aValidOrderToExecute) value.
	self fixPositionWithinBorder.! !

!MarsRover methodsFor: 'actions' stamp: 'HG 10/25/2020 14:13:59'!
receiveOrder: aSequenceOfOrders 
						
	aSequenceOfOrders do: [:anOrder | (self shouldBeExecuted: anOrder) 
									ifTrue: [ self executeValidOrder: anOrder ] 
									ifFalse: [ ^nil. ]].! !

!MarsRover methodsFor: 'actions' stamp: 'HG 10/25/2020 14:19:27'!
shouldBeExecuted: anOrderToExecute

	(validOrders at: anOrderToExecute ifAbsent: [^false]).
	^true.! !


!MarsRover methodsFor: 'accessing' stamp: 'FS 10/24/2020 20:06:55'!
currentPosition
	^position ! !


!MarsRover methodsFor: 'testing' stamp: 'HG 10/25/2020 13:12:43'!
pointsEast
	^direction isEast.! !

!MarsRover methodsFor: 'testing' stamp: 'HG 10/25/2020 13:12:51'!
pointsNorth
	^direction isNorth.! !

!MarsRover methodsFor: 'testing' stamp: 'HG 10/25/2020 13:12:58'!
pointsSouth
	^ direction isSouth.! !

!MarsRover methodsFor: 'testing' stamp: 'HG 10/25/2020 13:13:04'!
pointsWest
	^direction isWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'EjercicioMarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FS 10/24/2020 21:06:18'!
startingAt: aStartingPoint pointingTo: aCardinalPoint withMapHeight: aMapHeight withMapWidth: aMapWidth

	^self new initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth! !


!MarsRover class methodsFor: 'actions' stamp: 'FS 10/24/2020 20:05:44'!
receiveOrder
	^nil! !
