!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'support'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:36:54'!
test01NewCartsAreCreatedEmpty

	self assert: support createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:06'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [ cart add: support itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:14'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := support createCart.
	
	cart add: support itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:20'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 0 of: support itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:26'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 2 of: support itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:32'!
test06CartRemembersAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: support itemSellByTheStore.
	self assert: (cart includes: support itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:39'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := support createCart.
	
	self deny: (cart includes: support itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'FS 11/21/2020 22:37:47'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := support createCart.
	
	cart add: 2 of: support itemSellByTheStore.
	self assert: (cart occurrencesOf: support itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'HG 11/22/2020 12:52:23'!
test09CartCanNotBeInitializedWithNonPositivePriceInCatalog
	
	self 
		should: [Cart acceptingItemsOf: TestSupport new nonPositivePriceCatalog.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart new nonPositivePriceInCatalogErrorMessage. ]
	
	! !

!CartTest methodsFor: 'tests' stamp: 'HG 11/22/2020 12:53:16'!
test10CannotAddNonIntegerNumberOfItems

	| cart |
	
	cart := support createCart.
	
	self 
		should: [cart add: 1.5 of: support itemSellByTheStore ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart fractionQuantityErrorMessage.
			self assert: cart isEmpty ]! !


!CartTest methodsFor: 'setUp' stamp: 'FS 11/21/2020 22:32:36'!
setUp
	support _ TestSupport new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'support'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:32:59'!
setUp
	support _ TestSupport new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:52:16'!
test01CannotCheckoutEmptyCart

	| cart cashier |
	cart _ support createCart.
	cashier _ Cashier new.
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: '0000'.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = cashier checkoutEmptyCartErrorMessage. ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:53:15'!
test02CheckOutCartWithOneItemChargesCorrectAmount

	| cart cashier chargedAmount |
	cart _ support createCart.
	cart add: support itemSellByTheStore .
	
	cashier _ Cashier new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: '0000'.
	
	self assert: chargedAmount equals: support itemSellByTheStorePrice .
		
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'HG 11/22/2020 11:36:38'!
test03CheckOutCartWithOneItemWithMultipleOcurrencesChargesCorrectAmount

	| cart cashier chargedAmount quantityOfItem |
	cart _ support createCart.
	quantityOfItem _ 13.
	cart add: quantityOfItem of: support itemSellByTheStore .
	
	cashier _ Cashier new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: '0000'.
	
	self assert: chargedAmount equals: (support itemSellByTheStorePrice * quantityOfItem) .
		
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 23:18:23'!
test04CheckOutCartWithMultipleItemsChargesCorrectAmount

	| cart cashier chargedAmount quantityOfItem quantityOfanotherItem correctPriceChargedForAnotherItem correctPriceChargedForItem |
	cart _ support createCartWithMultipleItems.
	quantityOfItem _ 13.
	quantityOfanotherItem _ 7.

	cart add: quantityOfItem of: support itemSellByTheStore .
	cart add: quantityOfanotherItem of: support anotherItemSellByTheStore .

	cashier _ Cashier new.
	chargedAmount _ cashier checkOutWithCart: cart usingCard: '0000'.
	
	correctPriceChargedForItem _ quantityOfItem * support itemSellByTheStorePrice.
	correctPriceChargedForAnotherItem _ quantityOfanotherItem * support anotherItemSellByTheStorePrice.
	
	self assert: chargedAmount equals: (correctPriceChargedForItem + correctPriceChargedForAnotherItem) .
		
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'HG 11/22/2020 12:56:10'!
test05
	| cart cashier |
	cart _ support createCart.
	cashier _ Cashier new.
	
	self 
		should: [cashier checkOutWithCart: cart usingCard: '0000'.]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = cashier checkoutEmptyCartErrorMessage. ]! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HG 11/22/2020 12:48:01'!
fractionQuantityErrorMessage
	^'Can not add a non integer quantity'.! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!Cart methodsFor: 'error messages' stamp: 'HG 11/22/2020 12:01:51'!
nonPositivePriceInCatalogErrorMessage
	
	^'A Catalog can not be initalized with non positive prices'! !


!Cart methodsFor: 'assertions' stamp: 'HG 11/21/2020 22:19:49'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HG 11/22/2020 12:48:44'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ].
	aQuantity isFloat ifTrue: [ self error: self fractionQuantityErrorMessage ].! !


!Cart methodsFor: 'initialization' stamp: 'HG 11/22/2020 12:20:54'!
initializeAcceptingItemsOf: aCatalog

	aCatalog do: [:aCatalogPrice | aCatalogPrice < 0 ifTrue: [self error: self nonPositivePriceInCatalogErrorMessage ]].
	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'accessing' stamp: 'FS 11/21/2020 22:45:45'!
priceList
	^catalog copy.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'error description' stamp: 'HG 11/21/2020 21:58:20'!
checkoutEmptyCartErrorMessage
	^'Can not checkout with empty cart'.! !


!Cashier methodsFor: 'checkout' stamp: 'HG 11/22/2020 11:37:46'!
checkOutWithCart: aCart usingCard: aCardNumber

	| priceList |
	(aCart isEmpty) ifTrue: [^self error: self checkoutEmptyCartErrorMessage.].
	
	priceList _ aCart priceList.
				
	^(priceList keys) 
		inject: 0 
		into: [ :totalAmount :anItem |
				(aCart includes: anItem) 
				ifTrue: [ totalAmount + ( (priceList at: anItem) * (aCart occurrencesOf:  anItem))]
			].
	 ! !


!classDefinition: #TestSupport category: #TusLibros!
Object subclass: #TestSupport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:57:45'!
anotherItemSellByTheStore
	^'anotherValidBook'! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:57:58'!
anotherItemSellByTheStorePrice
	
	^57! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:35:42'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 23:09:41'!
createCartWithMultipleItems
	
	^Cart acceptingItemsOf: (Dictionary newFromPairs: (
					Array with: self itemSellByTheStore with: self itemSellByTheStorePrice
						   with: self anotherItemSellByTheStore with: self anotherItemSellByTheStorePrice)).! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:36:22'!
defaultCatalog
	
	^ Dictionary newFromPairs: (Array with: self itemSellByTheStore with: self itemSellByTheStorePrice).! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:34:41'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:34:27'!
itemSellByTheStore
	^'validBook'.! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'FS 11/21/2020 22:36:31'!
itemSellByTheStorePrice
	
	^100! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'HG 11/22/2020 11:59:44'!
negativePrice
	
	^100 negated.! !

!TestSupport methodsFor: 'as yet unclassified' stamp: 'HG 11/22/2020 11:59:32'!
nonPositivePriceCatalog
	
	^ Dictionary newFromPairs: (Array with: self itemSellByTheStore with: self negativePrice).! !
