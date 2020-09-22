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

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 21:14:57'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := CustomerBook new.
	self testearQueElMensaje: #addCustomerNamed: conParametro: johnLennon alObjeto: customerBook tardeMenosDe: (50 * millisecond). 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 21:14:37'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'paulMcCartney'.
	customerBook := self inicializarCustomerBookConNombre: paulMcCartney.
	self testearQueElMensaje: #removeCustomerNamed: conParametro: paulMcCartney alObjeto: customerBook tardeMenosDe: 100*millisecond. 
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 19:54:47'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook unClosureDeVerificacion |
			
	customerBook := CustomerBook new.
	unClosureDeVerificacion := [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
	
	self testearErrorAlEnviarElMensaje: #addCustomerNamed: alObjeto: customerBook conParametro: '' alLevantarError: Error ejecute: unClosureDeVerificacion.  ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 21:13:51'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon unClosureDeVerificacion paulMcCartney |
	
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self inicializarCustomerBookConNombre: johnLennon.
	
	unClosureDeVerificacion := [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ].
	
	^self testearErrorAlEnviarElMensaje: #removeCustomerNamed: alObjeto: customerBook conParametro: paulMcCartney alLevantarError: NotFound ejecute: unClosureDeVerificacion.  
	
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 18:20:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomerSuspendido: paulMcCartney.
	
	self testearQueElCustomerBook: customerBook tieneSuspendidos: 1 tieneCantidadTotal: 1 usandoCustomerDeNombre: paulMcCartney.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/19/2020 18:22:20'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self inicializarCustomerBookConCustomerSuspendido: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self testearQueElCustomerBook: customerBook tieneSuspendidos: 0 tieneCantidadTotal: 0 usandoCustomerDeNombre: paulMcCartney.	


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 21:14:21'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon georgeHarrison |
	
	johnLennon := 'John Lennon'.
	georgeHarrison := 'George Harrison'.
	customerBook := self inicializarCustomerBookConNombre: johnLennon.
		
	self testearErrorAlEnviarElMensaje: #suspendCustomerNamed: alCustomerBook: customerBook conParametro: georgeHarrison alLevantarError: CantSuspend aseguraQueSoloEste: johnLennon.  
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HG 9/21/2020 20:26:05'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.	
	customerBook := self inicializarCustomerBookConCustomerSuspendido: johnLennon.
	
	self testearErrorAlEnviarElMensaje: #suspendCustomerNamed: alCustomerBook: customerBook conParametro: johnLennon alLevantarError: CantSuspend aseguraQueSoloEste: johnLennon.  
	
! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/21/2020 20:00:36'!
asegurarQueSoloEste: unCustomer enCustomerBook: unCustomerBook
	
	self assert: unCustomerBook numberOfCustomers = 1.
	self assert: (unCustomerBook includesCustomerNamed: unCustomer).! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 15:19:33'!
inicializarCustomerBookConCustomerSuspendido: unNombre
	
	| customerBookConSuspendido |
	
	customerBookConSuspendido := self inicializarCustomerBookConNombre: unNombre.
	customerBookConSuspendido suspendCustomerNamed: unNombre.
	^customerBookConSuspendido.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:47:36'!
inicializarCustomerBookConNombre: unNombre

	^CustomerBook new addCustomerNamed: unNombre.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 18:12:33'!
m1: unCustomer m2: unCustomerBook m3: unaCantidadDeCustomers

	| customerEstaIncluido |
	
	customerEstaIncluido := (unCustomerBook includesCustomerNamed: unCustomer).
	(unaCantidadDeCustomers == 0) ifTrue: [ self deny: customerEstaIncluido ] ifFalse: [ self assert: customerEstaIncluido ]! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 14:41:27'!
medirTiempoDeEjecucionEnMilisegundos: unClosure
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := self tiempoActual.
	unClosure value.
	millisecondsAfterRunning := self tiempoActual.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning).! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/21/2020 20:25:30'!
testearErrorAlEnviarElMensaje: unMensaje alCustomerBook: unCustomerBook conParametro: unObjeto alLevantarError: unTipoDeError aseguraQueSoloEste: unCustomer

	| unClosureDeVerificacion |
.	
	unClosureDeVerificacion := [ :anError | self asegurarQueSoloEste: unCustomer enCustomerBook: unCustomerBook ].
	self testearErrorAlEnviarElMensaje: unMensaje alObjeto: unCustomerBook conParametro: unObjeto alLevantarError: unTipoDeError ejecute: unClosureDeVerificacion. 
	! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/21/2020 19:55:01'!
testearErrorAlEnviarElMensaje: unMensaje alObjeto: unCustomerBook conParametro: unString alLevantarError: unTipoDeError ejecute: unClosure.  

	[ unMensaje sendTo: unCustomerBook with: unString.
	self fail ]
		on: unTipoDeError 
		do: unClosure.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 18:17:49'!
testearQueElCostumer: unCustomer enCustomerBook: unCustomerBook estaIncluido: unBooleano

	| customerEstaIncluido |
	
	customerEstaIncluido := (unCustomerBook includesCustomerNamed: unCustomer).
	unBooleano ifTrue: [ self deny: customerEstaIncluido ] ifFalse: [ self assert: customerEstaIncluido ]! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 18:21:12'!
testearQueElCustomerBook: unCustomerBook tieneSuspendidos: unaCantidadDeCustomersSuspendidos tieneCantidadTotal: unaCantidadDeCustomers usandoCustomerDeNombre: unCustomer 
	
	
	self assert: 0 equals: unCustomerBook numberOfActiveCustomers.
	self assert: unaCantidadDeCustomersSuspendidos equals: unCustomerBook numberOfSuspendedCustomers.
	self assert: unaCantidadDeCustomers equals: unCustomerBook numberOfCustomers.
	self testearQueElCostumer: unCustomer enCustomerBook: unCustomerBook estaIncluido: (unaCantidadDeCustomers==0).

! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'HG 9/19/2020 15:00:51'!
testearQueElMensaje: unMensaje conParametro: unNombre alObjeto: unCustomerBook tardeMenosDe: unNumero 

	| tiempoDeEjecucion |
	tiempoDeEjecucion := self medirTiempoDeEjecucionEnMilisegundos: [unMensaje sendTo: unCustomerBook with: unNombre].
	self assert: tiempoDeEjecucion < unNumero
	
	
	
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


!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 21:04:01'!
addCustomerNamed: aName
	self asegurarNombreNoVacio: aName.
	self asegurarNombreNoEsteAgregado: aName.
	self agregarACustomersActivos: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 21:05:02'!
numberOfActiveCustomers
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 21:05:09'!
numberOfCustomers
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 21:05:12'!
numberOfSuspendedCustomers
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 20:56:38'!
removeCustomerNamed: aName 
 	
	| nombreDeActivo nombreDeSuspendido |
	
	nombreDeActivo := self remover: aName deLista: active.
	(nombreDeActivo == NotFound) ifFalse: [ ^nombreDeActivo ].
	
	nombreDeSuspendido := self remover: aName deLista: suspended.
	(nombreDeSuspendido == NotFound) ifTrue: [ ^NotFound signal ] ifFalse: [ ^nombreDeSuspendido ] .! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HG 9/21/2020 21:07:11'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	active remove: aName.
	suspended add: aName.
! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'HG 9/21/2020 21:03:55'!
agregarACustomersActivos: unNombre.
	active add: unNombre.! !

!CustomerBook methodsFor: 'as yet unclassified' stamp: 'HG 9/21/2020 21:02:11'!
asegurarNombreNoEsteAgregado: unNombre
	
	((active includes: unNombre) or: [suspended includes: unNombre]) ifTrue: [ self signalCustomerAlreadyExists ].
! !

!CustomerBook methodsFor: 'as yet unclassified' stamp: 'HG 9/21/2020 21:00:57'!
asegurarNombreNoVacio: unNombre

	unNombre isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
! !

!CustomerBook methodsFor: 'as yet unclassified' stamp: 'HG 9/21/2020 20:41:25'!
remover: unObjeto deLista: unaLista

	1 to: unaLista size do: 
	[ :index |
		unObjeto = (unaLista at: index)
			ifTrue: [
				unaLista removeAt: index.
				^unObjeto
			] 
	].
	^NotFound.! !

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
