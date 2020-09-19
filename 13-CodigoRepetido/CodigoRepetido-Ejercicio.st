!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 15:01:29'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	self testearQueElMensaje: #addCustomerNamed: conParametro: 'John Lennon' alObjeto: customerBook tardeMenosDe: (50 * millisecond). 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 15:00:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'paulMcCartney'.
	customerBook := self inicializarCustomerBookConNombre: paulMcCartney.
	self testearQueElMensaje: #removeCustomerNamed: conParametro: 'paulMcCartney' alObjeto: customerBook tardeMenosDe: 100*millisecond. 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 14:42:46'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook unClosureDeVerificacion |
			
	customerBook := CustomerBook new.
	unClosureDeVerificacion := [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	
	self testearErrorAlEnviarElMensaje: #addCustomerNamed: alObjeto: customerBook conParametro: '' conError: Error conVerificacionDelTest: unClosureDeVerificacion.  ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 14:50:05'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon unClosureDeVerificacion |
	
	johnLennon := 'John Lennon'.
	customerBook := self inicializarCustomerBookConNombre: johnLennon.
	
	unClosureDeVerificacion := [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
	
	^self testearErrorAlEnviarElMensaje: #removeCustomerNamed: alObjeto: customerBook conParametro: 'Paul McCartney' conError: NotFound conVerificacionDelTest: unClosureDeVerificacion.  
	
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 15:21:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomerSuspendido: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/17/2020 06:03:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 15:19:33'!
inicializarCustomerBookConCustomerSuspendido: unNombre
	
	| customerBookConSuspendido |
	
	customerBookConSuspendido := self inicializarCustomerBookConNombre: unNombre.
	customerBookConSuspendido suspendCustomerNamed: unNombre.
	^customerBookConSuspendido.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:47:36'!
inicializarCustomerBookConNombre: unNombre

	^CustomerBook new addCustomerNamed: unNombre.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:41:27'!
medirTiempoDeEjecucionEnMilisegundos: unClosure
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := self tiempoActual.
	unClosure value.
	millisecondsAfterRunning := self tiempoActual.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning).! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:23:46'!
testearErrorAlEnviarElMensaje: unMensaje alObjeto: unCustomerBook conParametro: unString conError: unTipoDeError conVerificacionDelTest: unClosure.  

	[ unMensaje sendTo: unCustomerBook with: unString.
	self fail ]
		on: unTipoDeError 
		do: unClosure.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 15:00:51'!
testearQueElMensaje: unMensaje conParametro: unNombre alObjeto: unCustomerBook tardeMenosDe: unNumero 

	| tiempoDeEjecucion |
	tiempoDeEjecucion := self medirTiempoDeEjecucionEnMilisegundos: [unMensaje sendTo: unCustomerBook with: unNombre].
	self assert: tiempoDeEjecucion < unNumero
	
	
	
	! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 15:46:04'!
testearQueElObjeto: unCustomerBook tengaSuspendidos: unaCantidadDeCustomersSuspendidos tengaCantidadTotal: unaCantidadDeCustomers conCustomerDeNombre: unCustomer
	
	| mensaje | 
	mensaje := #assert:.
	
	self assert: 0 equals: unCustomerBook numberOfActiveCustomers.
	self assert: unaCantidadDeCustomersSuspendidos equals: unCustomerBook numberOfSuspendedCustomers.
	self assert: unaCantidadDeCustomers equals: unCustomerBook numberOfCustomers.
	
	(unaCantidadDeCustomers == 0) ifTrue: [ mensaje:=#deny: ].
	
	mensaje sendTo: self with: (unCustomerBook includesCustomerNamed: unCustomer).
! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:33:52'!
tiempoActual
	
	^Time millisecondClockValue * millisecond.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/17/2020 21:39:56'!
removeCustomerNamed: aName 
 	
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !
