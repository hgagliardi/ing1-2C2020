!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 12:20:36'!
test01
	
	| aPortfolio anAccount aTransaction |
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	self assert: aPortfolio balance equals: 0.
	self assert: aPortfolio transactions isEmpty.
	self deny: (aPortfolio hasRegistered: aTransaction). 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 12:21:40'!
test02
	
	| aPortfolio anAccount aTransaction |
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	aPortfolio add: anAccount.
	
	self assert: aPortfolio balance equals: 100.
	self deny: aPortfolio transactions isEmpty.
	self assert: (aPortfolio hasRegistered: aTransaction). 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 12:47:42'!
test03
	
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 12:52:30'!
test04
	
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 19:30:04'!
test05
	
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 19:30:01'!
test06
	
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 19:29:16'!
test07
	
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

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'HG 11/6/2020 19:54:57'!
test08
	
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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'assets'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'HG 11/7/2020 19:22:33'!
balance
	
	assets isEmpty ifTrue: [^0].
	^assets sum: [:aFinancialAsset | aFinancialAsset balance].! !


!Portfolio methodsFor: 'transactions' stamp: 'HG 11/7/2020 19:50:09'!
transactions
	^self collectAssetPropertiesWith: [:anAsset | anAsset transactions ] over: assets.	
	
	
	! !


!Portfolio methodsFor: 'testing' stamp: 'HG 11/6/2020 12:29:52'!
hasRegistered: aTransaction 
	^self transactions includes: aTransaction.
	! !


!Portfolio methodsFor: 'accounts operations' stamp: 'HG 11/7/2020 19:43:50'!
add: anAssetToAdd 

	(self roots anySatisfy: 
		[:aRootAsset | (aRootAsset allAssets intersection: (anAssetToAdd allAssets)) isEmpty not.]) 
		ifTrue: [self signalCantAddAlreadyAddedAsset. ]. 
		
	assets add: anAssetToAdd.
	anAssetToAdd addParentPortfolio: self.  ! !


!Portfolio methodsFor: 'initialization' stamp: 'HG 11/7/2020 20:11:04'!
initialize
	assets _ OrderedCollection new.! !


!Portfolio methodsFor: 'exceptions' stamp: 'HG 11/6/2020 19:31:25'!
signalCantAddAlreadyAddedAsset
	^self error: self class alreadyAddedAssetErrorDescription. ! !


!Portfolio methodsFor: 'accessing' stamp: 'HG 11/7/2020 19:49:30'!
allAssets
	
	| containedAssets |
	containedAssets _ self collectAssetPropertiesWith: [:anAsset | anAsset allAssets ] over: assets.
	containedAssets add: self.
	^containedAssets.! !

!Portfolio methodsFor: 'accessing' stamp: 'HG 11/7/2020 20:19:36'!
roots
	self subclassResponsibility. ! !


!Portfolio methodsFor: '-- private' stamp: 'HG 11/7/2020 20:15:03'!
addParentPortfolio: aPortfolioWhoAddTheAsset
	self subclassResponsibility.! !

!Portfolio methodsFor: '-- private' stamp: 'HG 11/7/2020 19:49:57'!
collectAssetPropertiesWith: anAssetPropertyBlock over: anAssetListToCollectFrom
	^(anAssetListToCollectFrom collect: [:anAsset | anAssetPropertyBlock value: anAsset ]) flatten.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HG 11/6/2020 19:29:34'!
alreadyAddedAssetErrorDescription
	^'You cant add an already added asset.'.! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HG 11/7/2020 20:10:13'!
new
	^RootPortfolio basicNew.! !


!classDefinition: #ContainedPortfolio category: #'Portfolio-Ejercicio'!
Portfolio subclass: #ContainedPortfolio
	instanceVariableNames: 'portfoliosThatContainsMe'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ContainedPortfolio methodsFor: 'initialization' stamp: 'HG 11/7/2020 20:12:12'!
initialize
	portfoliosThatContainsMe _ OrderedCollection new.! !


!ContainedPortfolio methodsFor: 'portfolio operations --private' stamp: 'HG 11/7/2020 20:15:34'!
addParentPortfolio: aPortfolioWhoAddTheAsset
	portfoliosThatContainsMe add: aPortfolioWhoAddTheAsset. ! !


!ContainedPortfolio methodsFor: 'as yet unclassified' stamp: 'HG 11/7/2020 20:19:28'!
roots
	^self collectAssetPropertiesWith: [:anAsset | anAsset roots ] over: portfoliosThatContainsMe.! !


!classDefinition: #RootPortfolio category: #'Portfolio-Ejercicio'!
Portfolio subclass: #RootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'portfolio operations --private' stamp: 'HG 11/7/2020 20:21:56'!
addParentPortfolio: aPortfolioWhoAddTheAsset
	| originalAssets |
	originalAssets _ assets.
	self become: ContainedPortfolio new.
	assets _ originalAssets.
	self addParentPortfolio: aPortfolioWhoAddTheAsset.! !


!RootPortfolio methodsFor: 'as yet unclassified' stamp: 'HG 11/7/2020 20:19:18'!
roots
	^{self}.! !


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


!ReceptiveAccount methodsFor: '-- private' stamp: 'HG 11/6/2020 20:21:43'!
addParentPortfolio: aPortfolioWhoAddTheAsset

	^nil.! !
