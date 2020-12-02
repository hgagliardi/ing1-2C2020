!classDefinition: #CartTest category: 'TusLibros'!
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


!classDefinition: #CashierTest category: 'TusLibros'!
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

!CashierTest methodsFor: 'tests' stamp: 'FS 12/2/2020 00:06:29'!
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
	self assert: salesBook first amount = total.! !

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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'validNumber validName today futureExpirationDate now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test01CreditCardNumberShouldOnlyHave16Digits

	self should: [CreditCard withNumber: '123456789123456a' 
						withName: validName 
						expiringOn: futureExpirationDate] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: 
			[:anError | self assert: anError messageText equals: CreditCard invalidCreditCardNumberErrorMessage].! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test02CreditCardNameShouldNotBeBlank

	self should: [CreditCard withNumber: validNumber withName: '' expiringOn: futureExpirationDate ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: 
			[:anError | self assert: anError messageText equals: CreditCard invalidCreditCardName].! !

!CreditCardTest methodsFor: 'tests' stamp: 'FS 12/2/2020 02:02:05'!
test03CanRetrieveCreditCardDataCorrectly

	| creditCard |
	creditCard  _ CreditCard withNumber: validNumber 
						  withName: validName 
						  expiringOn: futureExpirationDate.
						
	self assert: creditCard number equals: validNumber.
	self assert: creditCard owner equals: validName.
	self deny: (creditCard isExpiredOn:  now  ).! !


!CreditCardTest methodsFor: 'setUp' stamp: 'FS 12/2/2020 02:02:05'!
setUp
	validNumber _ '1234567891234567'.
	validName _ 'Jorge Matone'.
	today _ GregorianMonthOfYear current.
	futureExpirationDate _ today next.
	now _ DateAndTime now.! !


!classDefinition: #InternalRestInterfaceTest category: 'TusLibros'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'interfaceObjectsFactory storeObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterfaceTest methodsFor: 'setUp' stamp: 'FS 12/1/2020 17:43:28'!
setUp

	interfaceObjectsFactory := InterfaceTestObjectsFactory new.
	storeObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test04CannotAdItemsToNotExistingCart
	
	| interface cartToAddID |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	cartToAddID _ 5.
	
	self should: [interface addToCart: cartToAddID anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
							self assert: anError messageText = InternalRestInterface invalidCartErrorMessage.
							self deny: (interface hasRegisteredCart: cartToAddID)
							].
	! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test05CannotListNotExistingCart
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	
	self should: [interface listCart: 5. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface invalidCartErrorMessage.
								self deny: (interface hasRegisteredCart: 5)]! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test06CartHasNoItemsWhenCreated
	
	| interface cartId |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InternalRestInterfaceTest methodsFor: 'testing - add/list cart' stamp: 'FS 12/1/2020 17:44:01'!
test07CartRemembersItemsAddedToIt
	
	| interface cartId validBook cartContent aQuantityToAdd |
	
	validBook _ storeObjectsFactory itemSellByTheStore.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self.
	
	aQuantityToAdd _ 3.
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToAdd. 
	
	cartContent _ interface listCart: cartId.
	
	self assert: (cartContent occurrencesOf: validBook) equals: aQuantityToAdd.! !


!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/2/2020 00:16:11'!
test01CannotCreateCartForUnregisteredUser
	
	| interface |
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self
.
	
	self should: [ interface createCartForUser: interfaceObjectsFactory invalidUser withPassword: '000'. ]
			raise: Error
			withExceptionDo: [ :anError | 					self assert: anError messageText =  InternalRestInterface invalidUserErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/2/2020 00:16:26'!
test02CannotCreateCartWithIncorrectPassword
	
	| interface validUser |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	validUser _ interfaceObjectsFactory validUser .
	
	self should: [ interface createCartForUser: validUser withPassword: interfaceObjectsFactory invalidPassword . ]
			raise: Error
			withExceptionDo: [ :anError | 			self assert: anError messageText =  
										InternalRestInterface invalidPasswordErrorMessage.
									  ].! !

!InternalRestInterfaceTest methodsFor: 'testing - createCart' stamp: 'FS 12/1/2020 17:44:01'!
test03InterfaceRemembersCartsAndCartIDsDontCollide
	
	| interface anotherCartId cartId  |
						
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	anotherCartId _  interfaceObjectsFactory createCartForAnotherValidUserIn: interface.
	
	self assert: (interface hasRegisteredCart: cartId).
	self assert: (interface hasRegisteredCart: anotherCartId).
	self deny: (cartId = anotherCartId).! !


!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 00:16:46'!
test08CannotCheckoutNotCreatedCart
	
	| interface |
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should: [self checkout: 'invalidCartId' using: interface]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface invalidCartErrorMessage .].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 00:21:37'!
test09CannotCheckoutEmptyCart
	
	| interface cartId |		
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	self should: [self checkout: cartId using: interface.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface emptyCartErrorMessage.
							    self assert: (self validUserHasNoPuchasesIn: interface)].! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 00:22:31'!
test10ClientStartsWithNoPurchases
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self assert:  (self validUserHasNoPuchasesIn: interface)  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 17:44:01'!
test11CannotListPurchasesOfUnregisteredUser
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory invalidUser 
					  withPassword: '123']
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidUserErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 17:44:01'!
test12CannotListPurchasesWithInvalidPassword
	
	| interface |
	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	self should:[ interface listPurchasesOf: interfaceObjectsFactory validUser 
					  withPassword: interfaceObjectsFactory invalidPassword]
		raise:Error - MessageNotUnderstood 
		withExceptionDo:[:anError | self assert: anError messageText = InternalRestInterface invalidPasswordErrorMessage ]
			 		  ! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/2/2020 00:17:43'!
test13TransactionIdsDontCollide

	| cartId interface aQuantityToBuy validBook transactionId anotherTransactionId anotherCartId |
 	
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	
	cartId  _ interfaceObjectsFactory createCartForValidUserIn: interface .
	anotherCartId  _ interfaceObjectsFactory createCartForAnotherValidUserIn: interface .
	
	validBook _ storeObjectsFactory itemSellByTheStore .
	aQuantityToBuy _ 3.
	interface addToCart: cartId anItem: validBook withQuantity: aQuantityToBuy. 
	interface addToCart: anotherCartId anItem: validBook withQuantity: aQuantityToBuy. 
	
	transactionId _ self checkout: cartId using: interface.
	anotherTransactionId _ self checkout: anotherCartId using: interface.
	
	self deny: transactionId = anotherTransactionId.! !

!InternalRestInterfaceTest methodsFor: 'testing - checkout / purchases' stamp: 'FS 12/1/2020 22:32:16'!
test14ListPurchasesCorrectlyAfterCheckout
	| cartId interface userPurchases itemToBuy quantityToBuy receiptForFirstPurchase |
	
	interface _  interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	itemToBuy _ storeObjectsFactory itemSellByTheStore.
	quantityToBuy _ 3.
	
	interface addToCart: cartId anItem: itemToBuy withQuantity: quantityToBuy.
	
	self checkout: cartId using: interface.
	
	userPurchases _ interface listPurchasesOf: interfaceObjectsFactory validUser 
						  withPassword: interfaceObjectsFactory validUserPassword .
	receiptForFirstPurchase _  userPurchases first.
	
	self assert: receiptForFirstPurchase amount equals: quantityToBuy * storeObjectsFactory itemSellByTheStorePrice .
	self assert: (receiptForFirstPurchase itemsSold occurrencesOf: itemToBuy) equals: quantityToBuy.
! !


!InternalRestInterfaceTest methodsFor: 'checkout -- private' stamp: 'HG 12/1/2020 14:55:20'!
checkout: cartId using: interface

	^ interface checkoutCart: cartId 
							  withCreditCardNumber: interfaceObjectsFactory creditCardNumber 
							  withCreditCardExpiredAt: interfaceObjectsFactory cardFutureExpirationDate 
							  withOwnerName: interfaceObjectsFactory ownersName! !


!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 02:31:36'!
test15CannotListCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface listCart: cartId]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface sessionExpiredMessageError ]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 02:31:33'!
test16CannotAddToCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 30 minutes.
	
	self should: [interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface sessionExpiredMessageError.]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 02:31:29'!
test17CannotCheckoutCartAfterSessionExpired

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	interface addToCart: cartId anItem: storeObjectsFactory itemSellByTheStore withQuantity: 1.
	clock moveForward: 30 minutes.
	
	self should: [self checkout: cartId using: interface]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [:anError | 
								self assert: anError messageText = InternalRestInterface sessionExpiredMessageError. 
								self assert:  (self validUserHasNoPuchasesIn: interface)]. 
					! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/1/2020 17:44:01'!
test18AddingToCartRefreshesSession

	| interface cartId clock |
	
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	clock moveForward: 20 minutes.
	interface listCart: cartId.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [interface listCart:cartId.].! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/1/2020 17:44:01'!
test19ListingCartRefreshesSession

	| interface cartId clock product cartContents |
	
	product _ storeObjectsFactory itemSellByTheStore.
	clock _ interfaceObjectsFactory clock.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	clock moveForward: 20 minutes.
	interface addToCart: cartId anItem: product withQuantity: 1.
	clock moveForward: 20 minutes.
	
	self shouldntFail: [cartContents _ interface listCart: cartId].
	self assert: (cartContents occurrencesOf: product) equals: 1.! !

!InternalRestInterfaceTest methodsFor: 'testing - session' stamp: 'FS 12/2/2020 02:31:20'!
test20CheckingOutACartKillsSession

	| interface cartId product |
	
	product _ storeObjectsFactory itemSellByTheStore.
	interface _ interfaceObjectsFactory defaultInterfaceThrough: self .
	cartId _ interfaceObjectsFactory createCartForValidUserIn: interface.
	
	interface addToCart: cartId anItem: product withQuantity: 1.
	self checkout: cartId using: interface.
	
	self should: [interface listCart: cartId]
		 raise: Error - MessageNotUnderstood
		 withExceptionDo: [:anError | self assert: anError messageText = InternalRestInterface sessionExpiredMessageError].! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'FS 12/1/2020 17:40:06'!
debit: anAmount from: aCreditCard
	^debitBehavior value: anAmount value: aCreditCard! !


!InternalRestInterfaceTest methodsFor: 'interface -- private' stamp: 'FS 12/2/2020 00:20:50'!
validUserHasNoPuchasesIn: interface

	^ (interface listPurchasesOf: interfaceObjectsFactory validUser 
							                                   withPassword:  interfaceObjectsFactory validUserPassword) 
											      isEmpty! !


!classDefinition: #SalesReceiptTest category: 'TusLibros'!
TestCase subclass: #SalesReceiptTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesReceiptTest methodsFor: 'tests' stamp: 'FS 12/1/2020 22:27:10'!
test01AmountShouldBePositive
	
	| itemsSold |
	itemsSold _ Bag new.
	itemsSold add: 'itemSold'.
	
	self should: [SalesReceipt totaling: -1  for: itemsSold ]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [:anError | self assert: anError messageText = 
										SalesReceipt cannotReceiptForNonPositiveAmountErrorMesage]
	
	 ! !

!SalesReceiptTest methodsFor: 'tests' stamp: 'FS 12/1/2020 22:26:53'!
test02CannotCreateReceiptWithNoItemsSold

	self should: [SalesReceipt totaling: 10  for: Bag new. ]
	 raise: Error - MessageNotUnderstood
	 withExceptionDo: [:anError | self assert: anError messageText = 
											SalesReceipt cannotReceiptWhenNoItemsBought]! !


!classDefinition: #SessionTest category: 'TusLibros'!
TestCase subclass: #SessionTest
	instanceVariableNames: 'testObjectFactory now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SessionTest methodsFor: 'as yet unclassified' stamp: 'FS 12/2/2020 02:09:35'!
setUp
	testObjectFactory _ StoreTestObjectsFactory new.
	! !

!SessionTest methodsFor: 'as yet unclassified' stamp: 'FS 12/2/2020 02:56:05'!
test01SessionRetrievesDataAndExpiresSessionCorrectly
	|   cartSession expirationTime |
 	expirationTime _ 30 minutes.
	cartSession _ Session        usedLastOn: (testObjectFactory today) 
						    ownedBy: 'User' withExpirationTime:
						    expirationTime. 
						
	self assert: cartSession owner equals: 'User'.
	self deny: (cartSession isExpiredOn: (testObjectFactory today)).
	self assert: (cartSession isExpiredOn: (testObjectFactory today + expirationTime)).! !

!SessionTest methodsFor: 'as yet unclassified' stamp: 'FS 12/2/2020 02:50:34'!
test02SessionUpdatesLastUsedTimeCorrectly
	| cartSession expirationTime |
 
	expirationTime _ 30 minutes.
	cartSession _ Session  
						    usedLastOn: (testObjectFactory today) 
						    ownedBy: 'User' withExpirationTime:
						    expirationTime. 
						
	cartSession updateLastTimeUsed: testObjectFactory today + 10 minutes.
	self deny: (cartSession isExpiredOn: (testObjectFactory today + expirationTime)).! !


!classDefinition: #Cart category: 'TusLibros'!
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


!Cart methodsFor: 'queries' stamp: 'FS 12/2/2020 02:47:24'!
contents
	^items copy asBag ! !

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

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'FS 12/1/2020 23:59:31'!
createSale

	^ SalesReceipt totaling:  total for: cart
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

!classDefinition: 'Cashier class' category: 'TusLibros'!
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


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'startingAt offset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'accesing' stamp: 'FS 12/2/2020 02:00:02'!
now
	^startingAt + offset. ! !


!Clock methodsFor: 'time control' stamp: 'FS 12/2/2020 02:00:09'!
moveForward: aTimelapse
	^offset _ offset + aTimelapse.! !


!Clock methodsFor: 'initialization' stamp: 'FS 12/2/2020 01:49:09'!
initializeStartingAt: aDateAndTime 
	startingAt := aDateAndTime.
	offset _ 0 seconds.! !


!Clock methodsFor: 'accessing' stamp: 'HG 12/1/2020 13:57:34'!
startingTime
	^startingAt. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'instance creation' stamp: 'HG 12/1/2020 11:01:58'!
startingAt: aDateAndTime 
	^self new initializeStartingAt: aDateAndTime ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration cardNumber ownersName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'FS 12/2/2020 02:05:51'!
isExpiredOn: aDateTime
	
	^expiration  < (GregorianMonthOfYear yearNumber: aDateTime yearNumber monthNumber: aDateTime monthIndex )! !


!CreditCard methodsFor: 'initialization' stamp: 'FS 12/2/2020 00:43:09'!
initializeWithNumber: aCardNumber withName: anOwnersName expiringOn: aMonthOfYear 
	cardNumber := aCardNumber.
	ownersName := anOwnersName.
	expiration := aMonthOfYear.! !


!CreditCard methodsFor: 'accessing' stamp: 'FS 12/2/2020 00:40:33'!
number
	^cardNumber! !

!CreditCard methodsFor: 'accessing' stamp: 'FS 12/2/2020 00:43:17'!
owner
	^ownersName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'FS 12/2/2020 00:40:06'!
assertIsAValidCreditCardNumber: aCreditCardNumber
	
	(self isAValidCreditCardNumber: aCreditCardNumber) ifFalse: [self error: self invalidCreditCardNumberErrorMessage ]. ! !

!CreditCard class methodsFor: 'assertions' stamp: 'FS 12/2/2020 00:40:13'!
assertIsValidOwnerName: anOwnerName

	( anOwnerName isEmpty ) ifTrue: [self error: self invalidCreditCardName ].
	! !


!CreditCard class methodsFor: 'testing' stamp: 'FS 12/2/2020 00:34:45'!
isAValidCreditCardNumber: aCreditCardNumber

	^ (aCreditCardNumber size = 16) and: [ aCreditCardNumber allSatisfy: [:aDigit | aDigit isDigit]].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 00:42:40'!
withNumber: aCardNumber withName: anOwnersName  expiringOn: aMonthOfYear 
	
	self assertIsAValidCreditCardNumber: aCardNumber.
	self assertIsValidOwnerName: anOwnersName.
	
	^self new initializeWithNumber: aCardNumber withName: anOwnersName expiringOn: aMonthOfYear! !


!CreditCard class methodsFor: 'error description' stamp: 'FS 12/2/2020 00:39:27'!
invalidCreditCardName
	^'Credit card name should not be blank'! !

!CreditCard class methodsFor: 'error description' stamp: 'FS 12/2/2020 00:39:04'!
invalidCreditCardNumberErrorMessage
	^'Credit card number is invalid'! !


!classDefinition: #InterfaceTestObjectsFactory category: 'TusLibros'!
Object subclass: #InterfaceTestObjectsFactory
	instanceVariableNames: 'clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTestObjectsFactory methodsFor: 'cart' stamp: 'FS 12/1/2020 16:09:04'!
createCartForAnotherValidUserIn: aRestInterface

	^aRestInterface createCartForUser: self anotherValidUser withPassword: self anotherValidUserPassword.! !

!InterfaceTestObjectsFactory methodsFor: 'cart' stamp: 'FS 12/1/2020 00:05:23'!
createCartForValidUserIn: aRestInterface

	^aRestInterface createCartForUser: self validUser withPassword: self validUserPassword.! !


!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:13'!
anotherValidUser 
	^  'Usuario2' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:25'!
anotherValidUserPassword
	^  '456' ! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/2/2020 02:19:06'!
defaultInterfaceThrough: aMerchantProcessor
	^InternalRestInterface 
		withValidUsers: self defaultUsers 
		withCatalog: StoreTestObjectsFactory new defaultCatalog
		using: clock
		through: aMerchantProcessor 
		withSessionExpirationTime: 30 minutes.! !

!InterfaceTestObjectsFactory methodsFor: 'users' stamp: 'FS 12/1/2020 16:08:04'!
defaultUsers
	^ Dictionary new 
		at: self validUser put: self validUserPassword;
		at: self anotherValidUser put: self anotherValidUserPassword;  yourself.! !

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


!InterfaceTestObjectsFactory methodsFor: 'initialization' stamp: 'FS 12/2/2020 02:00:40'!
initialize
	clock _ Clock startingAt: DateAndTime now.! !


!InterfaceTestObjectsFactory methodsFor: 'clock' stamp: 'HG 12/1/2020 14:41:14'!
clock
	^clock.! !


!classDefinition: #InternalRestInterface category: 'TusLibros'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'validUsers sessions lastCartId catalog lastTransactionId clock merchantProcessor salesByUser expirationTime carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'FS 12/2/2020 02:46:33'!
initializeWithValidUsers: aValidUsersList withCatalog: aCatalog withClock: aClock through: aMerchantProcessor
withExpirationTime: aTimeForSessionToExpire.
	validUsers := aValidUsersList.
	
	lastCartId _ 1.
	lastTransactionId _ 0.
	
	sessions _ Dictionary new.
	carts _ Dictionary new.
	
	salesByUser _ Dictionary newFrom: aValidUsersList.
	aValidUsersList keysDo: [:anUser | salesByUser at: anUser put: OrderedCollection new].

	merchantProcessor _ aMerchantProcessor .
	catalog _ aCatalog.
	clock _ aClock.
	expirationTime _ aTimeForSessionToExpire .! !


!InternalRestInterface methodsFor: 'authentication' stamp: 'FS 11/30/2020 23:20:20'!
authenticateUser: anUserId withPassword: anUserPassword

	| validUserPassword |
	
	validUserPassword _ validUsers at: anUserId 
								ifAbsent: [self error: self class invalidUserErrorMessage.]. 
								
	(validUserPassword = anUserPassword) 
								ifFalse: [ self error: self class invalidPasswordErrorMessage. ]! !


!InternalRestInterface methodsFor: 'cart creation' stamp: 'FS 12/2/2020 02:59:59'!
createCartForUser: anUserId withPassword: anUserPassword
	
	| newCartId cart |
	self authenticateUser: anUserId withPassword: anUserPassword.
		
	newCartId _ self generateCartId.
	cart _ Cart acceptingItemsOf: catalog.

	sessions at: newCartId put: (Session usedLastOn: clock now
						   ownedBy: anUserId
						   withExpirationTime: expirationTime).
	carts at: newCartId put: cart.
	
	^newCartId.! !

!InternalRestInterface methodsFor: 'cart creation' stamp: 'HG 12/1/2020 10:03:32'!
generateCartId
	lastCartId _ lastCartId + 1.
	^lastCartId asString.! !


!InternalRestInterface methodsFor: 'testing' stamp: 'FS 12/2/2020 02:21:26'!
hasRegisteredCart: aCartId 
	^sessions includesKey: aCartId.! !


!InternalRestInterface methodsFor: 'session' stamp: 'FS 12/2/2020 02:28:01'!
resetSessionOf: aCartId

	^ (sessions at: aCartId) updateLastTimeUsed: clock now. ! !

!InternalRestInterface methodsFor: 'session' stamp: 'FS 12/2/2020 02:22:35'!
userOwnerOf: aCartId
	^(sessions at: aCartId) owner! !


!InternalRestInterface methodsFor: 'adding' stamp: 'HG 12/1/2020 15:05:14'!
addToCart: aCartId anItem: anItem withQuantity: aQuantity 
	
	| aCartToAdd |
	aCartToAdd _ self cartWithId: aCartId.
	self assertSessionNotExpiredOf: aCartId.
	self resetSessionOf: aCartId.
	
	aCartToAdd add: aQuantity of: anItem.! !


!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/2/2020 02:47:02'!
cartWithId: aCartId

	^ carts at: aCartId 
		ifAbsent: [self error: self class invalidCartErrorMessage]! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/2/2020 02:47:24'!
listCart: aCartId 
	
	| aCartToList |
	
	aCartToList _ self cartWithId: aCartId.
	self assertSessionNotExpiredOf: aCartId.
	self resetSessionOf: aCartId.
	
	^aCartToList contents.! !

!InternalRestInterface methodsFor: 'accessing' stamp: 'FS 12/2/2020 00:15:42'!
listPurchasesOf: anUsername withPassword: aPassword 

	self authenticateUser: anUsername withPassword: aPassword.
	
	^salesByUser at: anUsername! !


!InternalRestInterface methodsFor: 'checkout' stamp: 'FS 12/2/2020 02:45:15'!
checkoutCart: aCartId withCreditCardNumber: aCreditCardNumber withCreditCardExpiredAt: anExpirationDate withOwnerName: aName 
	| cart  userCreditCard userCheckingOut cashierToCheckout currentTime userPurchases |
	cart _ self cartWithId: aCartId.
	
	self assertIsNotEmpty: cart.
	self assertSessionNotExpiredOf: aCartId.
	
	userCheckingOut _ self userOwnerOf: aCartId.
	
	userCreditCard _ CreditCard withNumber: aCreditCardNumber  withName: aName expiringOn: anExpirationDate.
	currentTime _ clock now.
	userPurchases _ salesByUser at: userCheckingOut . 
	
	cashierToCheckout _ Cashier toCheckout: cart charging: userCreditCard 
					throught: merchantProcessor 
					on: currentTime 
					registeringOn: userPurchases.
	cashierToCheckout checkOut.
	
	sessions removeKey: aCartId.
	
	^ self generateTransactionId.
	! !

!InternalRestInterface methodsFor: 'checkout' stamp: 'HG 12/1/2020 10:03:59'!
generateTransactionId
	lastTransactionId _ lastTransactionId + 1.
	^lastTransactionId asString.! !


!InternalRestInterface methodsFor: 'assertions' stamp: 'HG 12/1/2020 00:47:04'!
assertIsNotEmpty: cart

	^ cart isEmpty ifTrue: [self error: self class emptyCartErrorMessage]! !

!InternalRestInterface methodsFor: 'assertions' stamp: 'FS 12/2/2020 02:45:02'!
assertSessionNotExpiredOf: aCartId
	
	| cartSession errorClosure |
	
	errorClosure _ [^self error: self class sessionExpiredMessageError].
	
	cartSession _ sessions at: aCartId ifAbsent: errorClosure.
	(cartSession isExpiredOn: clock now) ifTrue: errorClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: 'TusLibros'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 02:20:27'!
withValidUsers: aValidUsersList withCatalog: aCatalog using: aClock through: aMerchantProcessor 
withSessionExpirationTime: aTimeForASessionToExpire
	^self new initializeWithValidUsers: aValidUsersList 
			withCatalog: aCatalog 
			withClock: aClock
			through:aMerchantProcessor 
			withExpirationTime: aTimeForASessionToExpire.! !


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

!InternalRestInterface class methodsFor: 'error description' stamp: 'FS 12/2/2020 02:29:32'!
sessionExpiredMessageError
	^'Session Expired'.! !


!classDefinition: #SalesReceipt category: 'TusLibros'!
Object subclass: #SalesReceipt
	instanceVariableNames: 'amount itemsSold'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesReceipt methodsFor: 'initialization' stamp: 'FS 12/1/2020 22:27:36'!
initializeTotaling: anAmount  for: aCollectionOfitemsSold
	self assertAmountIsPositive: anAmount.
	self assertNonEmptyItemsSold: aCollectionOfitemsSold .
	amount  _ anAmount .
	itemsSold  _ aCollectionOfitemsSold.! !


!SalesReceipt methodsFor: 'accessing' stamp: 'FS 12/1/2020 21:50:01'!
amount
	^amount! !

!SalesReceipt methodsFor: 'accessing' stamp: 'FS 12/1/2020 22:27:36'!
itemsSold
	^itemsSold copy! !


!SalesReceipt methodsFor: 'assertions' stamp: 'FS 12/1/2020 22:22:36'!
assertAmountIsPositive: anAmount 
	anAmount <= 0 ifTrue: [self error: self class cannotReceiptForNonPositiveAmountErrorMesage ]! !

!SalesReceipt methodsFor: 'assertions' stamp: 'FS 12/1/2020 22:26:41'!
assertNonEmptyItemsSold: aCollectionOfitemsSold 
	aCollectionOfitemsSold isEmpty ifTrue:[self error: self class cannotReceiptWhenNoItemsBought]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SalesReceipt class' category: 'TusLibros'!
SalesReceipt class
	instanceVariableNames: ''!

!SalesReceipt class methodsFor: 'instance creation' stamp: 'FS 12/1/2020 21:45:40'!
totaling: anAmount for: aCollectionOfItemsBought
	^self new initializeTotaling: anAmount for: aCollectionOfItemsBought .
	! !


!SalesReceipt class methodsFor: 'error description' stamp: 'FS 12/1/2020 22:21:01'!
cannotReceiptForNonPositiveAmountErrorMesage
	^'Cannot create receipt for non positive amount'! !

!SalesReceipt class methodsFor: 'error description' stamp: 'FS 12/1/2020 22:25:44'!
cannotReceiptWhenNoItemsBought
	^'Cannot receipt when no items were sold'! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'lastTimeUsed expirationTime nameOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Session methodsFor: 'initialization' stamp: 'FS 12/2/2020 02:58:55'!
initializeUsedLastOn: aLastUsedTime ownedBy: aNameOwner withExpirationTime: aTimeToExpire 
	lastTimeUsed := aLastUsedTime.
	nameOwner := aNameOwner.
	expirationTime := aTimeToExpire.! !


!Session methodsFor: 'accessing' stamp: 'FS 12/2/2020 02:57:27'!
owner
	^nameOwner ! !


!Session methodsFor: 'testing' stamp: 'FS 12/2/2020 02:58:11'!
isExpiredOn: aDateAndTime 
	^aDateAndTime - lastTimeUsed >= expirationTime ! !


!Session methodsFor: 'updating' stamp: 'FS 12/2/2020 02:59:21'!
updateLastTimeUsed: aDateAndTime 
	lastTimeUsed _ aDateAndTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'FS 12/2/2020 02:56:39'!
usedLastOn: aLastUsedTime ownedBy: aNameOwner withExpirationTime: aTimeToExpire 

	^self new initializeUsedLastOn: aLastUsedTime ownedBy: aNameOwner withExpirationTime: aTimeToExpire ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/2/2020 02:04:15'!
expiredCreditCard
	
	^CreditCard withNumber: '1234567891234567' withName: 'Jorge' 
											expiringOn: (GregorianMonthOfYear yearNumber: today yearNumber
											 monthNumber: today monthIndex ) 
											 previous.
		 ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 12/2/2020 02:03:38'!
notExpiredCreditCard
	
	^CreditCard withNumber: '1234567891234567' 
			     withName:  'Jorge' 
			     expiringOn: (GregorianMonthOfYear yearNumber: today yearNumber
											 monthNumber: today monthIndex ) 
											 next.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
