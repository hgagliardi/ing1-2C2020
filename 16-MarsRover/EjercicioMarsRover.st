!classDefinition: #MarsRoverTest category: #EjercicioMarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:07:28'!
test01
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: ''.
	
	self assert: Rover currentPosition equals: 2@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:07:46'!
test02
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:07:51'!
test03
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:07:56'!
test04
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self assert: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:00'!
test05
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self assert: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:04'!
test06
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 2@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:09'!
test07
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 2@3.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:13'!
test08
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self assert: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:17'!
test09
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self assert: Rover pointsWest.
	self deny: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:20'!
test10
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@2! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:22'!
test11
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 3@2! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:27'!
test12
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self assert: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:30'!
test13
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self assert: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:33'!
test14
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 3@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:36'!
test15
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:39'!
test16
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'r'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self assert: Rover pointsSouth.
	self deny: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:43'!
test17
	| Rover|
	Rover _ MarsRover startingAt: 2@2 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'l'.
	
	self deny: Rover pointsEast.
	self deny: Rover pointsWest.
	self deny: Rover pointsSouth.
	self assert: Rover pointsNorth.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:08:46'!
test18
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:17:45'!
test19
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@3.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:26:38'!
test20
	| Rover|
	Rover _ MarsRover startingAt: 1@3 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:28:25'!
test21
	| Rover|
	Rover _ MarsRover startingAt: 3@1 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'f'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:31:36'!
test22
	| Rover|
	Rover _ MarsRover startingAt: 3@1 pointingTo:  'W' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:35:38'!
test23
	| Rover|
	Rover _ MarsRover startingAt: 1@3 pointingTo:  'N' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:35:57'!
test24
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'E' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 3@1.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:37:02'!
test25
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'b'.
	
	self assert: Rover currentPosition equals: 1@3.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:41:23'!
test26
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'ffr'.
	
	self assert: Rover currentPosition equals: 1@3.
	self assert: Rover pointsWest.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2020 21:48:14'!
test27
	| Rover|
	Rover _ MarsRover startingAt: 1@1 pointingTo:  'S' withMapHeight: 3 withMapWidth: 3.
	
	Rover receiveOrder: 'frNKf'.
	
	self assert: Rover currentPosition equals: 1@2.
	self assert: Rover pointsWest .
	 ! !


!classDefinition: #MarsRover category: #EjercicioMarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction mapHeight mapWidth validOrders'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'FS 10/24/2020 21:56:06'!
initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth 
	position := aStartingPoint.
	direction := aCardinalPoint.
	mapHeight := aMapHeight.
	mapWidth := aMapWidth.
	
	validOrders _ OrderedCollection with: 'f' with: 'b' with: 'r' with: 'l'.! !


!MarsRover methodsFor: 'actions' stamp: 'FS 10/24/2020 21:58:25'!
receiveOrder: aSequenceOfOrders 
	aSequenceOfOrders do: [ :anOrder | (validOrders includes: anOrder asString )				
									ifTrue:[ 
										self receiveSingleOrder: anOrder asString]
									ifFalse:[ ^nil].
									].! !

!MarsRover methodsFor: 'actions' stamp: 'FS 10/24/2020 21:43:07'!
receiveSingleOrder: anOrder 
	| yDecrementor xDecrementor xIncrementor yIncrementor |
	yDecrementor := 0@-1.
	xDecrementor := -1@0.
	yIncrementor := 0@1.
	xIncrementor := 1@0.

	anOrder = 'f' ifTrue:[

		self pointsNorth ifTrue:[  
						     position _  position + yDecrementor.
						     position y <1 ifTrue:[position _ (position x)@(mapHeight)
												].
						].
								
		self pointsSouth ifTrue:  [
							position _  position + yIncrementor.
							position y >mapHeight ifTrue:[position _ (position x)@1].
							 ].
		self pointsWest ifTrue: [		   
							position _ position + xDecrementor.
							position x <1 ifTrue: [position _ mapWidth@(position y)].
						].
								
		self pointsEast ifTrue: [position _ position +xIncrementor.
						     position x >mapWidth ifTrue: [position _ 1@(position y)].
						].
		].
	
	anOrder = 'b' ifTrue:[
		self pointsNorth ifTrue: [
							position _  position + yIncrementor.
							position y >mapHeight ifTrue:[position _ (position x)@1].
							 ].
		self pointsSouth ifTrue: [  
						     position _  position + yDecrementor.
						     position y <1 ifTrue:[position _ (position x)@(mapHeight)
												].
						].
		self pointsWest ifTrue:[position _ position + xIncrementor.
						     position x >mapWidth ifTrue: [position _ 1@(position y)].
						].
		self pointsEast ifTrue: [		   
							position _ position + xDecrementor.
							position x <1 ifTrue: [position _ mapWidth@(position y)].
						].
		].
	
	anOrder = 'l' ifTrue:[ 
		self pointsSouth	 ifTrue: [ ^direction _ 'E'].
		self pointsNorth ifTrue: [^direction _ 'W'].
		self pointsWest ifTrue: [^direction _ 'S'].
		self pointsEast ifTrue: [^direction _ 'N'].
		].	
	
	anOrder = 'r' ifTrue:[ 
		self pointsSouth	 ifTrue: [ ^direction _ 'W'].
		self pointsNorth ifTrue: [^direction _ 'E'].
		self pointsWest ifTrue: [^direction _ 'N'].
		self pointsEast ifTrue: [^direction _ 'S'].
		].
	^nil! !


!MarsRover methodsFor: 'accessing' stamp: 'FS 10/24/2020 20:06:55'!
currentPosition
	^position ! !


!MarsRover methodsFor: 'testing' stamp: 'FS 10/24/2020 20:13:56'!
pointsEast
	^ direction = 'E'! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/24/2020 20:35:15'!
pointsNorth
	^direction = 'N'! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/24/2020 20:35:06'!
pointsSouth
	^ direction = 'S'! !

!MarsRover methodsFor: 'testing' stamp: 'FS 10/24/2020 20:14:35'!
pointsWest
	^direction = 'W'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #EjercicioMarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'FS 10/24/2020 21:06:18'!
startingAt: aStartingPoint pointingTo: aCardinalPoint withMapHeight: aMapHeight withMapWidth: aMapWidth

	^self new initializeStartingAt: aStartingPoint pointingTo: aCardinalPoint MapHeight: aMapHeight MapWidth: aMapWidth! !


!MarsRover class methodsFor: 'actions' stamp: 'FS 10/24/2020 20:05:44'!
receiveOrder
	^nil! !
