!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalRestInterfaceTest category: #TusLibros!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'interfaceObjectsFactory storeObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp' stamp: 'FS 12/1/2020 00:09:35'!
setUp

	interfaceObjectsFactory := InterfaceTestObjectsFactory new.
	storeObjectsFactory := StoreTestObjectsFactory new.! !


!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 01:52:57'!
test04CannotAdItemsToNotExistingCart
	
	| interface cartToAddID |
	
	interface _ interfaceObjectsFactory defaultInterface .
	cartToAddID _ 5.
	
	self should: [interface addToCart: cartToAddID anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
							self assert: anError messageText = InternalRestInterface invalidCartErrorMessage.
							self deny: (interface hasRegisteredCart: cartToAddID)
							].
	! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 01:53:04'!
test05CannotListNotExistingCart
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterface .
	
	self should: [interface listCart: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface invalidCartErrorMessage.
								self deny: (interface hasRegisteredCart: 5)]! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 12/1/2020 14:45:43'!
test06CartHasNoItemsWhenCreated
	
	| interface cartId |
	
	interface _ interfaceObjectsFactory defaultInterface.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 12/1/2020 14:45:53'!
test07CartRemembersItemsAddedToIt
	
	| interface cartId validBook cartContent aQuantityToAdd |
	
	validBook _ storeObjectsFactory itemSellByTheStore.
	interface _ interfaceObjectsFactory defaultInterface.
	
	aQuantityToAdd _ 3.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToAdd. 
	
	cartContent _ interface listCart: cartId.
	
	self assert: (cartContent occurrencesOf: validBook) equals: aQuantityToAdd.! !


!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 12/1/2020 14:45:24'!
test01CannotCreateCartForUnregisteredUser
	
	| interface |
	interface _ interfaceObjectsFactory defaultInterface.
	
	self should: [ interface createCartForUser: interfaceObjectsFactory invalidUser withPassword: '000'. ]
			raise: Error
			withExceptionDo: [ :anError | 
									self assert: anError messageText =  InternalRestInterface invalidUserErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 12/1/2020 14:44:39'!
test02CannotCreateCartWithIncorrectPassword
	
	| interface validUser |
	
	interface _ interfaceObjectsFactory defaultInterface.
	validUser _ interfaceObjectsFactory defaultUsers keys first.
	
	self should: [ interface createCartForUser: validUser withPassword: interfaceObjectsFactory invalidPassword . ]
			raise: Error
			withExceptionDo: [ :anError | 
									self assert: anError messageText =  InternalRestInterface invalidPasswordErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 12/1/2020 14:47:24'!
test03InterfaceRemembersCartsAndCartIDsDontCollide
	
	| interface anotherCartId cartId twoUsersDataBase anotherValidUser anotherValidUserPassword validUser validUserPassword |
	
	validUser _ interfaceObjectsFactory validUser.
	validUserPassword _ interfaceObjectsFactory validUserPassword.
	anotherValidUser _ 'Usuario 2'.
	anotherValidUserPassword _ '456'.
	
	twoUsersDataBase _ Dictionary new
							 at: validUser put: validUserPassword;
							 at: anotherValidUser put: anotherValidUserPassword;
							 yourself.
											
	interface _ InternalRestInterface withValidUsers: twoUsersDataBase withCatalog: storeObjectsFactory defaultCatalog using: interfaceObjectsFactory clock.
	
	cartId _ interface createCartForUser:  validUser withPassword: validUserPassword.
	anotherCartId _ interface createCartForUser:  anotherValidUser withPassword: anotherValidUserPassword.
	
	self assert: (interface hasRegisteredCart: cartId).
	self assert: (interface hasRegisteredCart: anotherCartId).
	self deny: (cartId = anotherCartId).! !


!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 02:24:23'!
test08CannotCheckoutNotCreatedCart
	
	| interface |
	'TODO: Creo que falta chequear que NO se hicieron ventas, o sea que el salesBook esta empty,
		como lo hicieron ellos en el cashier (y asi probar que no se uso el merchant processor)'.
		
	interface _ interfaceObjectsFactory defaultInterface.
	
	self should: [self checkout: 'invalidCartId' using: interface]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface invalidCartErrorMessage .].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 02:24:28'!
test09CannotCheckoutEmptyCart
	
	| interface cartId |
	'TODO: Creo que falta chequear que NO se hicieron ventas, o sea que el salesBook esta empty,
		como lo hicieron ellos en el cashier   (y asi probar que no se uso el merchant processor)'.
		
	interface _ interfaceObjectsFactory defaultInterface .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self should: [self checkout: cartId using: interface.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface emptyCartErrorMessage.].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 01:56:32'!
test10ClientStartsWithNoPurchases
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterface .
	
	self assert: (interface listPurchasesOf: interfaceObjectsFactory validUser 
					  withPassword: interfaceObjectsFactory validUserPassword) 
			 		  isEmpty  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 02:03:52'!
test11CannotListPurchasesOfUnregisteredUser
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterface .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory invalidUser 
					  withPassword: '123']
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidUserErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 02:04:08'!
test12CannotListPurchasesWithInvalidPassword
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterface .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory validUser 
					  withPassword: interfaceObjectsFactory invalidPassword]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidPasswordErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'HG 12/1/2020 14:47:28'!
test13TransactionIdsDontCollide

	| cartId interface aQuantityToAdd validBook transactionId anotherTransactionId anotherCartId anotherValidUser anotherValidUserPassword twoUsersDataBase validUser validUserPassword |
 	
	validBook _ storeObjectsFactory itemSellByTheStore.
	validUser _ interfaceObjectsFactory validUser.
	validUserPassword _ interfaceObjectsFactory validUserPassword.
	
	anotherValidUser _ 'Usuario 2'.
	anotherValidUserPassword _ '456'.
	
	twoUsersDataBase _ Dictionary new
							 at: validUser put: validUserPassword;
							 at: anotherValidUser put: anotherValidUserPassword;
							 yourself.
											
	interface _ InternalRestInterface withValidUsers: twoUsersDataBase withCatalog: storeObjectsFactory defaultCatalog using: interfaceObjectsFactory clock.
	cartId _ interface createCartForUser:  validUser withPassword: validUserPassword.
	anotherCartId _ interface createCartForUser:  anotherValidUser withPassword: anotherValidUserPassword.
	
	aQuantityToAdd _ 3.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToAdd. 
	interface addToCart: anotherCartId anItem: validBook withQuantity: aQuantityToAdd. 
	
	transactionId _ self checkout: cartId using: interface.
	anotherTransactionId _ self checkout: anotherCartId using: interface.
	
	self deny: transactionId = anotherTransactionId.! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 02:25:09'!
test14ListPurchasesCorrectlyAfterCheckout
	'TODO: Ademas de chequear que la lista de purchases se modifica con el checkout que hiciste, creo que tambien hay que chequear que se hicieron las ventas con el salesBook, como hicieron en cashier ellos (para demostrar que se contacto al merchant processor'.! !


!InternalRestInterfaceTest methodsFor: 'checkout support' stamp: 'HG 12/1/2020 14:55:20'!
checkout: cartId using: interface

	^ interface checkoutCart: cartId 
							  withCreditCardNumber: interfaceObjectsFactory creditCardNumber 
							  withCreditCardExpiredAt: interfaceObjectsFactory cardFutureExpirationDate 
							  withOwnerName: interfaceObjectsFactory ownersName! !


!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 14:48:48'!
test15

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface listCart: cartId]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = StoreSession sessionExpiredMessageError ]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 14:57:12'!
test16

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = StoreSession sessionExpiredMessageError.]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 14:58:34'!
test17

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1.
	clock moveForward: 30 minutes.
	
	self should: [self checkout: cartId using: interface]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | 
								self assert: anError messageText = StoreSession sessionExpiredMessageError. 
								self assert: (interface listPurchasesOf: interfaceObjectsFactory validUser 
														 withPassword: interfaceObjectsFactory validUserPassword) isEmpty]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 15:10:30'!
test18

	| interface cartId clock product |
	
	product _ storeObjectsFactory itemSellByTheStore.
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	clock moveForward: 20 minutes.
	interface listCart: cartId.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [interface listCart:cartId.].! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 15:11:47'!
test19

	| interface cartId clock product cartContents |
	
	product _ storeObjectsFactory itemSellByTheStore.
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	clock moveForward: 20 minutes.
	interface addToCart: cartId anItem: product withQuantity: 1.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [cartContents _ interface listCart: cartId].
	self assert: (cartContents occurrencesOf: product) equals: 1.! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'HG 12/1/2020 15:15:33'!
test20

	| interface cartId clock product |
	
	product _ storeObjectsFactory itemSellByTheStore.
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterface. 
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	interface addToCart: cartId anItem: product withQuantity: 1.
	self checkout: cartId using: interface.
	
	self should: [interface listCart: cartId]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError | self assert: anError messageText = StoreSession sessionExpiredMessageError].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'startingAt offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accesing' stamp: 'HG 12/1/2020 13:45:26'!
now
	^startingAt + offset. ! !


!Clock methodsFor: 'time control' stamp: 'HG 12/1/2020 11:57:36'!
moveForward: aTimelapse
	
	^offset _ offset + aTimelapse.! !


!Clock methodsFor: 'initialization' stamp: 'HG 12/1/2020 11:52:17'!
initializeStartingAt: aDateAndTime 
	startingAt := aDateAndTime.
	offset _ 0 seconds.! !


!Clock methodsFor: 'accessing' stamp: 'HG 12/1/2020 13:57:34'!
startingTime
	^startingAt. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: #TusLibros!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'HG 12/1/2020 11:01:58'!
startingAt: aDateAndTime 
	^self new initializeStartingAt: aDateAndTime ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InterfaceTestObjectsFactory category: #TusLibros!
Object subclass: #InterfaceTestObjectsFactory
	instanceVariableNames: 'clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTestObjectsFactory methodsFor: 'cart' stamp: 'FS 12/1/2020 00:05:23'!
createCartForValidUserIn: aRestInterface

	^aRestInterface createCartForUser: self validUser withPassword: self validUserPassword.! !


!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'HG 12/1/2020 14:44:56'!
defaultInterface
	^InternalRestInterface 
		withValidUsers: self defaultUsers 
		withCatalog: StoreTestObjectsFactory new defaultCatalog
		using: clock.! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 01:21:26'!
defaultUsers
	^ Dictionary new 
		at: self validUser put: self validUserPassword;  yourself.! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 02:01:25'!
invalidPassword
	^'invalidPassword'! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:05:57'!
invalidUser
	
	^ 'invalidUser'! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:06:06'!
validUser 
	^  'Usuario1' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 00:06:16'!
validUserPassword
	^  '123' ! !


!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/1/2020 01:32:04'!
cardFutureExpirationDate
	^GregorianMonthOfYear current next! !

!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/1/2020 01:31:32'!
creditCardNumber
	^'1232323232323232'! !

!InterfaceTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/1/2020 01:19:56'!
ownersName
	^'Jorge Matone'! !


!InterfaceTestObjectsFactory methodsFor: 'clock' stamp: 'HG 12/1/2020 14:41:14'!
clock
	^clock.! !

!InterfaceTestObjectsFactory methodsFor: 'clock' stamp: 'HG 12/1/2020 14:40:52'!
initialize
	clock _ Clock startingAt: DateAndTime now.! !


!classDefinition: #InternalRestInterface category: #TusLibros!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'validUsers createdCarts lastCartId catalog lastTransactionId clock cartTimeUpdates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'HG 12/1/2020 14:19:28'!
initializeWithValidUsers: aValidUsersList withCatalog: aCatalog
	validUsers := aValidUsersList.
	lastCartId _ 1.
	lastTransactionId _ 0.
	createdCarts _ Dictionary new.
	catalog _ aCatalog.! !

!InternalRestInterface methodsFor: 'initialization' stamp: 'HG 12/1/2020 14:34:51'!
initializeWithValidUsers: aValidUsersList withCatalog: aCatalog withClock: aClock
	validUsers := aValidUsersList.
	lastCartId _ 1.
	lastTransactionId _ 0.
	createdCarts _ Dictionary new.
	cartTimeUpdates _ Dictionary new.
	catalog _ aCatalog.
	clock _ aClock.! !


!InternalRestInterface methodsFor: 'authentication' stamp: 'FS 11/30/2020 23:20:20'!
authenticateUser: anUserId withPassword: anUserPassword

	| validUserPassword |
	
	validUserPassword _ validUsers at: anUserId 
								ifAbsent: [self error: self class invalidUserErrorMessage.]. 
								
	(validUserPassword = anUserPassword) 
								ifFalse: [ self error: self class invalidPasswordErrorMessage. ]! !


!InternalRestInterface methodsFor: 'cart creation' stamp: 'HG 12/1/2020 14:28:26'!
createCartForUser: anUserId withPassword: anUserPassword
	
	| newCartId cart |
	self authenticateUser: anUserId withPassword: anUserPassword.
		
	newCartId _ self generateCartId.
	cart _ Cart acceptingItemsOf: catalog.
	
	createdCarts at: newCartId put: cart. 
	cartTimeUpdates at: newCartId put: clock now.
	
	^newCartId.! !

!InternalRestInterface methodsFor: 'cart creation' stamp: 'HG 12/1/2020 10:03:32'!
generateCartId
	lastCartId _ lastCartId + 1.
	^lastCartId asString.! !


!InternalRestInterface methodsFor: 'testing' stamp: 'HG 11/30/2020 21:22:23'!
hasRegisteredCart: aCartId 
	^createdCarts includesKey: aCartId.! !


!InternalRestInterface methodsFor: 'adding' stamp: 'HG 12/1/2020 15:05:14'!
addToCart: aCartId anItem: anItem withQuantity: aQuantity 
	
	| aCartToAdd |
	aCartToAdd _ self cartWithId: aCartId.
	self assertSessionNotExpiredOf: aCartId.
	self resetSessionOf: aCartId.
	
	aCartToAdd add: aQuantity of: anItem.! !

!InternalRestInterface methodsFor: 'adding' stamp: 'HG 12/1/2020 15:05:14'!
resetSessionOf: aCartId

	^ cartTimeUpdates at: aCartId put: clock now! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'HG 12/1/2020 15:19:33'!
assertSessionNotExpiredOf: aCartId
	
	| cartLastUpdate errorClosure |
	
	errorClosure _ [^self error: StoreSession sessionExpiredMessageError].
	
	cartLastUpdate _ cartTimeUpdates at: aCartId ifAbsent: errorClosure.
	( clock now - cartLastUpdate < 30 minutes )
		ifFalse: errorClosure.! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'HG 12/1/2020 09:42:07'!
cartWithId: aCartId

	^ createdCarts at: aCartId 
		ifAbsent: [self error: self class invalidCartErrorMessage]! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'HG 12/1/2020 15:10:52'!
listCart: aCartId 
	
	| aCartToList |
	
	aCartToList _ self cartWithId: aCartId.
	self assertSessionNotExpiredOf: aCartId.
	self resetSessionOf: aCartId.
	^aCartToList.! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/1/2020 02:03:25'!
listPurchasesOf: anUsername withPassword: aPassword 

	self authenticateUser: anUsername withPassword: aPassword.
	^OrderedCollection new.! !


!InternalRestInterface methodsFor: 'checkout' stamp: 'HG 12/1/2020 00:47:04'!
assertIsNotEmpty: cart

	^ cart isEmpty ifTrue: [self error: self class emptyCartErrorMessage]! !

!InternalRestInterface methodsFor: 'checkout' stamp: 'HG 12/1/2020 14:54:53'!
checkoutCart: aCartId withCreditCardNumber: aCreditCardNumber withCreditCardExpiredAt: anExpirationDate withOwnerName: aName 
	| cart newTransactionId |
	cart _ self cartWithId: aCartId.
	self assertIsNotEmpty: cart.
	self assertSessionNotExpiredOf: aCartId.

	
	newTransactionId _ self generateTransactionId.
	^newTransactionId. 
	! !

!InternalRestInterface methodsFor: 'checkout' stamp: 'HG 12/1/2020 10:03:59'!
generateTransactionId
	lastTransactionId _ lastTransactionId + 1.
	^lastTransactionId asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: #TusLibros!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'HG 12/1/2020 14:21:08'!
withValidUsers: aValidUsersList withCatalog: aCatalog using: aClock
	^self new initializeWithValidUsers: aValidUsersList withCatalog: aCatalog withClock: aClock.! !


!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 12/1/2020 00:45:13'!
emptyCartErrorMessage
	^'Carrito vacío para checkout'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 20:37:49'!
invalidCartErrorMessage
	^'Invalid Cart'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 19:15:07'!
invalidPasswordErrorMessage
	^'Contraseña inválida'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 18:54:54'!
invalidUserErrorMessage
	^'Usuario inválido'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreSession category: #TusLibros!
Object subclass: #StoreSession
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreSession class' category: #TusLibros!
StoreSession class
	instanceVariableNames: ''!

!StoreSession class methodsFor: 'error description' stamp: 'HG 12/1/2020 13:58:03'!
sessionExpiredMessageError
	^'Session Expired'.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
