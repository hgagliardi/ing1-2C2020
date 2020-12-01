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
	instanceVariableNames: 'testObjectsFactory validateBehaviour invalidUserId invalidPassword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp' stamp: 'HG 11/30/2020 19:00:02'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 11/30/2020 21:19:45'!
test04
	
	| interface |
	
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	
	self should: [interface addToCart: 5 aBookISBN: testObjectsFactory itemSellByTheStore withQuantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
								anError messageText = InternalRestInterface invalidCartErrorMessage.
								self deny: (interface hasRegisteredCart: 5)
							].
	! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 11/30/2020 21:19:45'!
test05
	
	| interface |
	
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	
	self should: [interface listCart: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | anError messageText = InternalRestInterface invalidCartErrorMessage].! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 11/30/2020 21:19:45'!
test06
	
	| interface cartId |
	
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	cartId _ testObjectsFactory createCartForValidUserIn: interface.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'HG 11/30/2020 21:19:45'!
test07
	
	| interface cartId validBook cartContent |
	
	validBook _ testObjectsFactory itemSellByTheStore.
	 
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	cartId _ testObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId aBookISBN: validBook withQuantity: 3. 
	
	cartContent _ interface listCart: cartId.
	
	self assert: (cartContent occurrencesOf: validBook) equals: 3.! !


!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 11/30/2020 21:19:45'!
test01
	
	| interface |
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	
	self should: [ interface createCartForUser: testObjectsFactory invalidUser withPassword: '000'. ]
			raise: Error
			withExceptionDo: [ :anError | 
									self assert: anError messageText =  InternalRestInterface invalidUserErrorMessage.
									self deny: (interface userHasCreatedCart: invalidUserId). ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 11/30/2020 21:19:45'!
test02
	
	| interface validUser |
	
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	validUser _ testObjectsFactory validUsers keys first.
	
	self should: [ interface createCartForUser: validUser withPassword: 'invalidPassword'. ]
			raise: Error
			withExceptionDo: [ :anError | 
									self assert: anError messageText =  InternalRestInterface invalidPasswordErrorMessage.
									self deny: (interface userHasCreatedCart: validUser). ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'HG 11/30/2020 21:19:45'!
test03
	
	| interface anotherCartId cartId |
	
	interface _ InternalRestInterface withValidUsers: testObjectsFactory validUsers withCatalog: testObjectsFactory defaultCatalog.
	
	cartId _ testObjectsFactory createCartForValidUserIn: interface.
	anotherCartId _ testObjectsFactory createCartForAnotherValidUserIn: interface.
	
	self assert: (interface hasRegisteredCart: cartId).
	self assert: (interface hasRegisteredCart: anotherCartId).
	self deny: (cartId = anotherCartId).! !


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


!classDefinition: #InternalRestInterface category: #TusLibros!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'validUsers cartOwner createdCarts lastId catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'HG 11/30/2020 21:21:13'!
initializeWithValidUsers: aValidUsersList withCatalog: aCatalog
	validUsers := aValidUsersList.
	lastId _ 1.
	createdCarts _ Dictionary new.
	catalog _ aCatalog.! !


!InternalRestInterface methodsFor: 'authentication' stamp: 'HG 11/30/2020 19:21:31'!
authenticateUser: anUserId withPassword: anUserPassword

	| validUserPassword |
	
	validUserPassword _ validUsers at: anUserId 
								ifAbsent: [self error: self class invalidUserErrorMessage.]. 
	(validUserPassword = anUserPassword) 
		ifFalse: [ self error: self class invalidPasswordErrorMessage. ]! !


!InternalRestInterface methodsFor: 'as yet unclassified' stamp: 'HG 11/30/2020 21:22:03'!
createCartForUser: anUserId withPassword: anUserPassword
	
	| newCartId cart |
	self authenticateUser: anUserId withPassword: anUserPassword.
	cartOwner _ anUserId.
	
	newCartId _ self generateCartId.
	cart _ Cart acceptingItemsOf: catalog.
	createdCarts at: newCartId put: cart. 
	^newCartId.! !

!InternalRestInterface methodsFor: 'as yet unclassified' stamp: 'HG 11/30/2020 19:38:30'!
generateCartId
	lastId _ lastId + 1.
	^lastId.! !


!InternalRestInterface methodsFor: 'testing' stamp: 'HG 11/30/2020 21:22:23'!
hasRegisteredCart: aCartId 
	^createdCarts includesKey: aCartId.! !

!InternalRestInterface methodsFor: 'testing' stamp: 'HG 11/30/2020 19:11:56'!
userHasCreatedCart: aUserId 
	^false.! !


!InternalRestInterface methodsFor: 'adding' stamp: 'HG 11/30/2020 21:35:13'!
CAMBIARgetCartOrFail: aCartId

	^ createdCarts at: aCartId 
		ifAbsent: [self error: self class invalidCartErrorMessage]! !

!InternalRestInterface methodsFor: 'adding' stamp: 'HG 11/30/2020 21:35:24'!
addToCart: aCartId aBookISBN: anItem withQuantity: aQuantity 
	
	| aCartToAdd |
	aCartToAdd _ self CAMBIARgetCartOrFail: aCartId.
	aCartToAdd add: aQuantity of: anItem.! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'HG 11/30/2020 21:35:34'!
listCart: aCartId 
	
	| aCartToList |
	aCartToList _ self CAMBIARgetCartOrFail: aCartId.
	
	^aCartToList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: #TusLibros!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'HG 11/30/2020 21:20:35'!
withValidUsers: aValidUsersList withCatalog: aCatalog 
	^self new initializeWithValidUsers: aValidUsersList withCatalog: aCatalog.! !


!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 20:37:49'!
invalidCartErrorMessage
	^'Invalid Cart'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 19:15:07'!
invalidPasswordErrorMessage
	^'Contrase�a inv�lida'.! !

!InternalRestInterface class methodsFor: 'error description' stamp: 'HG 11/30/2020 18:54:54'!
invalidUserErrorMessage
	^'Usuario inv�lido'.! !


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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HG 11/30/2020 21:06:49'!
createCartForAnotherValidUserIn: aRestInterface
	
	| passwords usernames validPassword validUser |
	usernames _ self validUsers keys.
	passwords _ self validUsers values.
	
	validUser _ usernames first.
	validPassword _ passwords first.

	^aRestInterface createCartForUser: validUser withPassword: validPassword.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HG 11/30/2020 21:06:57'!
createCartForValidUserIn: aRestInterface
	
	| passwords usernames validPassword validUser |
	usernames _ self validUsers keys.
	passwords _ self validUsers values.
	
	validUser _ usernames second.
	validPassword _ passwords second.

	^aRestInterface createCartForUser: validUser withPassword: validPassword.! !

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


!StoreTestObjectsFactory methodsFor: 'user interface support' stamp: 'HG 11/30/2020 19:01:31'!
invalidUser
	
	^ 'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'user interface support' stamp: 'HG 11/30/2020 19:32:39'!
validUsers
	^ Dictionary new 
		at: 'Usuario1' put: '12345'; at: 'Usuario 2' put:'67890'; yourself.! !