!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing -- creating' stamp: 'HG 11/8/2020 19:56:23'!
test01PortfolioShouldBeEmptyWhenCreated
	
	| aPortfolio anAccount aTransaction |
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	self assert: aPortfolio balance equals: 0.
	self assert: aPortfolio transactions isEmpty.
	self deny: (aPortfolio hasRegistered: aTransaction). 
	! !


!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'HG 11/8/2020 19:56:17'!
test02RegisterTransactionOfAdddedAccount
	
	| aPortfolio anAccount aTransaction |
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	aPortfolio add: anAccount.
	
	self assert: aPortfolio balance equals: 100.
	self deny: aPortfolio transactions isEmpty.
	self assert: (aPortfolio hasRegistered: aTransaction). 
	! !

!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'HG 11/8/2020 19:56:09'!
test03RegisterTransactionsOfMultipleAccounts
	
	| aPortfolio anAccount a100Deposit a100Withdraw a300Deposit 
	aNonAgregateAccount aNonAgregateTransaction another100Withdraw another300Deposit |
	
	aPortfolio _ Portfolio new.
	
	aNonAgregateAccount _ ReceptiveAccount new.
	aNonAgregateTransaction _ Deposit register: 100 on: aNonAgregateAccount.
	
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	aPortfolio add: anAccount.
	
	anAccount _ ReceptiveAccount new.
	a300Deposit _ Deposit register: 300 on: anAccount.
	a100Withdraw _ Withdraw register: 100 on: anAccount.
	aPortfolio add: anAccount.
	
	anAccount _ ReceptiveAccount new.
	another300Deposit _ Deposit register: 300 on: anAccount.
	another100Withdraw _ Withdraw register: 100 on: anAccount.
	aPortfolio add: anAccount.
	
	self assert: aPortfolio balance equals: 500.
	self assert: aPortfolio transactions size = 5.
	self assert: (aPortfolio hasRegistered: a100Deposit). 
	self assert: (aPortfolio hasRegistered: a100Withdraw). 
	self assert: (aPortfolio hasRegistered: a300Deposit). 
	self assert: (aPortfolio hasRegistered: another100Withdraw). 
	self assert: (aPortfolio hasRegistered: another300Deposit). 
	self deny: (aPortfolio hasRegistered: aNonAgregateTransaction).
	   
	! !

!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'HG 11/8/2020 19:56:01'!
test04RegisterTransactionOfAddedPortfolio
	
	| aPortfolio anAccount aTransaction aPortfolioToAdd |
	aPortfolio _ Portfolio new.
	
	aPortfolioToAdd _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	aPortfolioToAdd add: anAccount.
	
	aPortfolio add: aPortfolioToAdd.
		
	self assert: aPortfolio balance equals: 100.
	self assert: aPortfolio transactions size = 1.
	self assert: (aPortfolio hasRegistered: aTransaction). 
	! !


!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'HG 11/8/2020 19:55:54'!
test05CanNotAddAlreadyAddedAccount
	
	| aPortfolio anAccount a100Deposit  |
	aPortfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	aPortfolio add: anAccount.
	
	self should: [ aPortfolio add: anAccount. ]
		raise: Error
		withMessageText: Portfolio alreadyAddedAssetErrorDescription.
				
	self assert: aPortfolio balance equals: 100.
	self assert: aPortfolio transactions size = 1.
	self assert: (aPortfolio hasRegistered: a100Deposit). 
	! !

!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'HG 11/8/2020 19:57:50'!
test06CanNotAddAccountAlreadyAddedInHierarchy
	
	| aPortfolio aChildPortfolio anAccount a100Deposit  |
	aPortfolio _ Portfolio new.
	
	aChildPortfolio _ Portfolio new.
	
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	aChildPortfolio add: anAccount.
	aPortfolio add: aChildPortfolio. 
	
	self should: [ aPortfolio add: anAccount. ]
		raise: Error
		withMessageText: Portfolio alreadyAddedAssetErrorDescription.
				
	self assert: aPortfolio balance equals: 100.
	self assert: aPortfolio transactions size = 1.
	self assert: (aPortfolio hasRegistered: a100Deposit). 
	! !

!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'HG 11/8/2020 19:58:20'!
test07CanNotAddRepeatedPortfolio
	
	| aPortfolio aChildPortfolio |
	aPortfolio _ Portfolio new.
	aChildPortfolio _ Portfolio new.
	
	aPortfolio add: aChildPortfolio. 
	
	self should: [ aPortfolio add: aChildPortfolio.  ]
		raise: Error
		withMessageText: Portfolio alreadyAddedAssetErrorDescription.
				
	self assert: aPortfolio balance equals: 0.
	self assert: aPortfolio transactions size = 0.
	! !


!PortfolioTest methodsFor: 'testing -- hierarchy checks' stamp: 'HG 11/8/2020 19:59:32'!
test08CanNotAddPortfolioWithRepeatedAccountsInHierarchy
	
	| aParentPortfolio aPortfolioToAdd aChildPortfolio a100Deposit anAccount |
	aParentPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	aParentPortfolio add: anAccount.
	
	aChildPortfolio _ Portfolio new.
	aParentPortfolio add: aChildPortfolio.
	
	aPortfolioToAdd _ Portfolio new.
	aPortfolioToAdd add: anAccount.
	
	
	self should: [ aChildPortfolio add: aPortfolioToAdd.  ]
		raise: Error
		withMessageText: Portfolio alreadyAddedAssetErrorDescription.
				
	self assert: aParentPortfolio balance equals: 100.
	self assert: aParentPortfolio transactions size = 1.
	self assert: (aParentPortfolio hasRegistered: a100Deposit).
	! !

!PortfolioTest methodsFor: 'testing -- hierarchy checks' stamp: 'HG 11/8/2020 20:00:29'!
test09CanNotAddPortfolioWithRepeatedElementsInAddedAssetHierarchy
	
	| aParentPortfolio aChildPortfolio a100Deposit anAccount anotherChildPortfolio anotherParentPortfolio |
	
	aParentPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	aParentPortfolio add: anAccount.
	aChildPortfolio _ Portfolio new.
	aParentPortfolio add: aChildPortfolio.
	
	anotherParentPortfolio _ Portfolio new.
	anotherParentPortfolio add: anAccount.
	anotherChildPortfolio _ Portfolio new.
	anotherParentPortfolio add: anotherChildPortfolio.
	
	
	self should: [ aChildPortfolio add: anotherChildPortfolio.  ]
		raise: Error
		withMessageText: Portfolio alreadyAddedAssetErrorDescription.
				
	self assert: aParentPortfolio balance equals: 100.
	self assert: aParentPortfolio transactions size = 1.
	self assert: (aParentPortfolio hasRegistered: a100Deposit).
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operations' stamp: 'HG 11/6/2020 11:50:40'!
addToBalance: aReceptiveAccount
	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'HG 11/2/2020 21:05:47'!
addToBalance: aReceptiveAccount
	^aReceptiveAccount contributeToBalanceAsDeposit: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'operations' stamp: 'HG 11/6/2020 10:44:20'!
addToBalance: aReceptiveAccount
	^aReceptiveAccount contributeToBalanceAsWithdraw: self value.! !


!Withdraw methodsFor: 'value' stamp: 'HG 11/2/2020 19:23:54'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'balance' stamp: 'HG 11/7/2020 19:14:20'!
balance
	self subclassResponsibility. ! !


!FinancialAsset methodsFor: 'transactions' stamp: 'HG 11/8/2020 18:38:04'!
transactions
	self subclassResponsibility. ! !


!FinancialAsset methodsFor: 'testing' stamp: 'HG 11/8/2020 18:37:55'!
hasRegistered: aTransaction
	self subclassResponsibility. ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets hierarchyState portfoliosThatContainsMe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'HG 11/7/2020 19:22:33'!
balance
	
	assets isEmpty ifTrue: [^0].
	^assets sum: [:aFinancialAsset | aFinancialAsset balance].! !


!Portfolio methodsFor: 'transactions' stamp: 'HG 11/8/2020 18:39:34'!
transactions
	^self collectAssetPropertiesWith: [:anAsset | anAsset transactions ] in: assets.	
	
	
	! !


!Portfolio methodsFor: 'testing' stamp: 'HG 11/6/2020 12:29:52'!
hasRegistered: aTransaction 
	^self transactions includes: aTransaction.
	! !


!Portfolio methodsFor: 'accounts operations' stamp: 'HG 11/8/2020 19:43:37'!
add: anAssetToAdd 
	
	self roots do: [:aRootAsset | 
		(self checkForRepeatedElementsBetween: aRootAsset andRootsHierarchiesOf: anAssetToAdd) 
			ifFalse: [^self signalCantAddAlreadyAddedAsset]].
			
	assets add: anAssetToAdd.
	anAssetToAdd addParentPortfolio: self.  ! !


!Portfolio methodsFor: 'initialization' stamp: 'HG 11/8/2020 18:29:02'!
initialize
	assets _ OrderedCollection new.
	hierarchyState _ RootState for: self.
	portfoliosThatContainsMe _ OrderedCollection new.! !


!Portfolio methodsFor: 'exceptions' stamp: 'HG 11/6/2020 19:31:25'!
signalCantAddAlreadyAddedAsset
	^self error: self class alreadyAddedAssetErrorDescription. ! !


!Portfolio methodsFor: 'accessing' stamp: 'HG 11/8/2020 18:39:34'!
allAssets
	
	| containedAssets |
	containedAssets _ self collectAssetPropertiesWith: [:anAsset | anAsset allAssets ] in: assets.
	containedAssets add: self.
	^containedAssets.! !

!Portfolio methodsFor: 'accessing' stamp: 'HG 11/8/2020 18:39:51'!
roots
	^hierarchyState roots.! !


!Portfolio methodsFor: 'testing -- private' stamp: 'HG 11/8/2020 19:43:37'!
checkForRepeatedElementsBetween: aRootAsset andRootsHierarchiesOf: anAssetToAdd

	^(anAssetToAdd roots) 
		anySatisfy: [:anAssetToAddRoot | self portfolioHierarchy: aRootAsset isDisjointWith: anAssetToAddRoot].! !

!Portfolio methodsFor: 'testing -- private' stamp: 'HG 11/8/2020 19:32:50'!
portfolioHierarchy: aRootAsset isDisjointWith: anAssetToAddRoot

	^ ((anAssetToAddRoot allAssets) intersection: (aRootAsset allAssets)) isEmpty! !

!Portfolio methodsFor: 'testing -- private' stamp: 'HG 11/8/2020 19:25:19'!
shouldAddAssetInHierarchy: anAssetToAdd checkingAlreadyContentOf: aRootAsset

	^anAssetToAdd roots anySatisfy: 
		[:anAssetToAddRoot | ((anAssetToAddRoot allAssets) intersection: (aRootAsset allAssets)) isEmpty not].! !


!Portfolio methodsFor: 'accesing -- private' stamp: 'HG 11/8/2020 18:39:34'!
collectAssetPropertiesWith: anAssetPropertyBlock in: anAssetListToCollectFrom
	^(anAssetListToCollectFrom collect: [:anAsset | anAssetPropertyBlock value: anAsset ]) flatten.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'HG 11/8/2020 18:39:34'!
lookUpRootsBeingContainedPortfolio
	^self collectAssetPropertiesWith: [:anAsset | anAsset roots ] in: portfoliosThatContainsMe.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'HG 11/8/2020 18:34:33'!
lookUpRootsBeingRootPortfolio
	^{self}.! !


!Portfolio methodsFor: 'adding -- private' stamp: 'HG 11/8/2020 18:31:02'!
addParentPortfolio: aPortfolioWhoAddMe
	hierarchyState _ ContainedState for: self.
	portfoliosThatContainsMe add: aPortfolioWhoAddMe. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HG 11/6/2020 19:29:34'!
alreadyAddedAssetErrorDescription
	^'You cant add an already added asset.'.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions balanceCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HG 11/6/2020 10:44:46'!
initialize

	transactions := OrderedCollection new.
	balanceCount _ 0.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance contributions --private' stamp: 'HG 11/6/2020 10:43:42'!
contributeToBalanceAsDeposit: anAccountTransactionValue
	balanceCount _ balanceCount + anAccountTransactionValue. ! !

!ReceptiveAccount methodsFor: 'balance contributions --private' stamp: 'HG 11/6/2020 10:43:51'!
contributeToBalanceAsWithdraw: anAccountTransactionValue
	balanceCount _ balanceCount - anAccountTransactionValue. ! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HG 11/6/2020 11:49:27'!
balance
	transactions do: [ :aTransaction | aTransaction addToBalance: self ].
	^balanceCount. ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HG 11/6/2020 12:14:25'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accesing' stamp: 'HG 11/7/2020 19:43:50'!
allAssets
	^{self} asOrderedCollection.! !

!ReceptiveAccount methodsFor: 'accesing' stamp: 'HG 11/8/2020 19:05:25'!
roots
	^{self} asOrderedCollection.! !


!ReceptiveAccount methodsFor: '-- private' stamp: 'HG 11/6/2020 20:21:43'!
addParentPortfolio: aPortfolioWhoAddTheAsset

	^nil.! !


!classDefinition: #PortfolioHierarchyState category: #'Portfolio-Ejercicio'!
Object subclass: #PortfolioHierarchyState
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioHierarchyState methodsFor: 'initialization' stamp: 'HG 11/8/2020 18:30:06'!
initializeFor: aPortfolio
	portfolio _ aPortfolio. ! !


!PortfolioHierarchyState methodsFor: '-- private hierarchy' stamp: 'HG 11/8/2020 18:31:50'!
roots
	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioHierarchyState class' category: #'Portfolio-Ejercicio'!
PortfolioHierarchyState class
	instanceVariableNames: ''!

!PortfolioHierarchyState class methodsFor: 'instance creation' stamp: 'HG 11/8/2020 18:29:49'!
for: aPortfolio
	^self new initializeFor: aPortfolio. ! !


!classDefinition: #ContainedState category: #'Portfolio-Ejercicio'!
PortfolioHierarchyState subclass: #ContainedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ContainedState methodsFor: '-- private hierarchy' stamp: 'HG 11/8/2020 18:33:37'!
roots
	^portfolio lookUpRootsBeingContainedPortfolio.! !


!classDefinition: #RootState category: #'Portfolio-Ejercicio'!
PortfolioHierarchyState subclass: #RootState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootState methodsFor: '-- private hierarchy' stamp: 'HG 11/8/2020 18:33:14'!
roots
	^portfolio lookUpRootsBeingRootPortfolio. ! !
