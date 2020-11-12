!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'HG 11/12/2020 19:28:14'!
test01
	
	| account |
	
	account _ ReceptiveAccount new.
	self assert: account summary last equals: 'Balance = 0'.
	! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'HG 11/12/2020 19:29:09'!
test02
	
	| account |
	
	account _ ReceptiveAccount new.
	Deposit register: 500 on: account. 
	
	self assert: account summary first equals: 'Deposito por 500'.
	self assert: account summary last equals: 'Balance = 500'.	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'Fs 11/9/2020 00:09:39'!
test02PortfolioRegistersTransactionOfAdddedAccount
	
	| aPortfolio anAccount aTransaction |
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	aPortfolio add: anAccount.
	
	self assert: aPortfolio balance equals: 100.
	self assert: aPortfolio transactions size = 1.
	self assert: (aPortfolio hasRegistered: aTransaction). 
	! !

!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'Fs 11/9/2020 00:47:26'!
test03PortfolioRegistersTransactionsOfMultipleAddedAccounts
	
	| aPortfolio anAccount a100Deposit a100Withdraw a300Deposit 
	aNotAddedAccount aNotAddedTransaction another100Withdraw another300Deposit |
	
	aPortfolio _ Portfolio new.
	
	aNotAddedAccount _ ReceptiveAccount new.
	aNotAddedTransaction _ Deposit register: 100 on: aNotAddedAccount.
	
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
	self deny: (aPortfolio hasRegistered: aNotAddedTransaction).
	   
	! !

!PortfolioTest methodsFor: 'testing -- adding assets' stamp: 'Fs 11/9/2020 00:49:24'!
test04PortfolioRegistersTransactionOfAddedPortfolio
	
	| aPortfolio anAccount aTransaction aPortfolioToAdd |
	anAccount _ ReceptiveAccount new.
	aTransaction _ Deposit register: 100 on: anAccount.
	
	aPortfolio _ Portfolio new.
	aPortfolioToAdd _ Portfolio new.
	
	aPortfolioToAdd add: anAccount.
	aPortfolio add: aPortfolioToAdd.
		
	self assert: aPortfolio balance equals: 100.
	self assert: aPortfolio transactions size = 1.
	self assert: (aPortfolio hasRegistered: aTransaction). 
	! !


!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'Fs 11/9/2020 00:21:27'!
test05CannotAddAlreadyAddedAccount
	
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

!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'Fs 11/9/2020 00:30:30'!
test06CannotAddAccountAlreadyInASubPortfolio
	
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

!PortfolioTest methodsFor: 'testing -- repeated elements' stamp: 'Fs 11/9/2020 00:30:43'!
test07CannotAddAlreadyAddedPortfolio
	
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


!PortfolioTest methodsFor: 'testing -- hierarchy checks' stamp: 'Fs 11/9/2020 00:45:10'!
test08ContainedPortfolioCannotAddAnotherPortfolioContainingAssetThatExistsInRootPortfolio
	
	| aParentPortfolio aPortfolioToAdd aChildPortfolio a100Deposit anAccount |
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	
	aParentPortfolio _ Portfolio new.
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

!PortfolioTest methodsFor: 'testing -- hierarchy checks' stamp: 'Fs 11/9/2020 00:45:52'!
test09ContainedPortfolioWithAssetInRootPortfolioCannotAddAnotherContainedPortofolioWithSameAssetWithinItsRootPortfolio
	
	| aParentPortfolio aChildPortfolio a100Deposit anAccount anotherChildPortfolio anotherParentPortfolio |
	anAccount _ ReceptiveAccount new.
	a100Deposit _ Deposit register: 100 on: anAccount.
	
	aParentPortfolio _ Portfolio new.
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


!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'Fs 11/9/2020 19:48:42'!
test01
	| destinationAccount sourceAccount |
	sourceAccount _ ReceptiveAccount new.
	Deposit register: 100 on: sourceAccount .
	
	destinationAccount _ ReceptiveAccount new.
	
	Transference from: sourceAccount  to: destinationAccount registerWithValue: 60.
	
	self assert: sourceAccount balance equals: 40.
	self assert: destinationAccount balance equals: 60.
	! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'Fs 11/9/2020 20:06:33'!
test02
	| destinationAccount sourceAccount |
	sourceAccount _ ReceptiveAccount new.
	Deposit register: 100 on: sourceAccount .
	
	destinationAccount _ ReceptiveAccount new.
	
	self should:[Transference from: sourceAccount  to: destinationAccount registerWithValue: -10] 
		raise:Error
		withMessageText: (Transference cannotTransferNegativeMoneyErrorDescription).
	! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'Fs 11/9/2020 20:09:45'!
test03
	| anAccount |
	anAccount _ ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
		
	self should:[Transference from: anAccount to:  anAccount registerWithValue: 100]
		raise:Error
		withMessageText: Transference cannotTransferFromAccountToSameAccount.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'exceptions' stamp: 'HG 11/6/2020 19:31:25'!
signalCantAddAlreadyAddedAsset
	^self error: self class alreadyAddedAssetErrorDescription. ! !


!Portfolio methodsFor: 'testing -- private' stamp: 'Fs 11/9/2020 01:32:43'!
isDisjointWith: anotherAsset

	^ ((anotherAsset allAssets) intersection: (self allAssets)) isEmpty! !

!Portfolio methodsFor: 'testing -- private' stamp: 'Fs 11/9/2020 02:31:45'!
isDisjointWithPortfoliosThatContains: anAsset 

	^(anAsset roots) 
		anySatisfy: [:anAssetRoot |   self isDisjointWith: anAssetRoot].! !


!Portfolio methodsFor: 'accesing -- private' stamp: 'Fs 11/9/2020 02:29:02'!
allAssets
	| containedAssets |
	
	containedAssets _ self flattenCollect: [:anAsset | anAsset allAssets ] in: assets.
	containedAssets add: self.
	^containedAssets.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'Fs 11/9/2020 02:29:46'!
flattenCollect: anEvaluatingBlock in: aListToCollectFrom
	^(aListToCollectFrom collect: [:anElement | anEvaluatingBlock value: anElement ]) flatten.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'Fs 11/9/2020 02:29:02'!
lookUpRootsWhenContainedPortfolio
	^self flattenCollect: [:anAsset | anAsset roots ] in: portfoliosThatContainsMe.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'Fs 11/9/2020 00:40:07'!
lookUpRootsWhenRootPortfolio
	^{self}.! !

!Portfolio methodsFor: 'accesing -- private' stamp: 'HG 11/8/2020 18:39:51'!
roots
	^hierarchyState roots.! !


!Portfolio methodsFor: 'adding -- private' stamp: 'Fs 11/9/2020 01:54:01'!
addParentPortfolio: aPortfolioThatAddsMe
	hierarchyState _ ContainedState for: self.
	portfoliosThatContainsMe add: aPortfolioThatAddsMe. ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HG 11/6/2020 19:29:34'!
alreadyAddedAssetErrorDescription
	^'You cant add an already added asset.'.! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance --private' stamp: 'HG 11/6/2020 10:43:42'!
contributeToBalanceAsDeposit: anAccountTransactionValue
	balanceCount _ balanceCount + anAccountTransactionValue. ! !

!ReceptiveAccount methodsFor: 'balance --private' stamp: 'HG 11/6/2020 10:43:51'!
contributeToBalanceAsWithdraw: anAccountTransactionValue
	balanceCount _ balanceCount - anAccountTransactionValue. ! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'accesing' stamp: 'HG 11/7/2020 19:43:50'!
allAssets
	^{self} asOrderedCollection.! !

!ReceptiveAccount methodsFor: 'accesing' stamp: 'HG 11/8/2020 19:05:25'!
roots
	^{self} asOrderedCollection.! !


!ReceptiveAccount methodsFor: 'adding -- private' stamp: 'Fs 11/9/2020 01:53:41'!
addParentPortfolio: aPortfolioWhoAddTheAsset
	^nil.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'HG 11/12/2020 19:35:32'!
summary
	
	| report |
	
	report _ OrderedCollection new.
	self transactions do: [:aTransaction | (aTransaction isKindOf: Deposit) ifTrue: [ report add: ('Deposito por ', aTransaction value asString)] ].
	report add: ('Balance = ', self balance asString).
	^report.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operations' stamp: 'HG 11/6/2020 11:50:40'!
addToBalance: aReceptiveAccount
	self subclassResponsibility. ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'HG 11/2/2020 21:05:47'!
addToBalance: aReceptiveAccount
	^aReceptiveAccount contributeToBalanceAsDeposit: self value.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'operations' stamp: 'HG 11/6/2020 10:44:20'!
addToBalance: aReceptiveAccount
	^aReceptiveAccount contributeToBalanceAsWithdraw: self value.! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'sourceAccount destinationAccount transferenceValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'initialization' stamp: 'Fs 11/9/2020 20:10:41'!
initializeFrom: aSourceAccount to: aDestinationAccount withValue: aTransferenceValue 
	aTransferenceValue <= 0 ifTrue:[self error: self class cannotTransferNegativeMoneyErrorDescription ].
	aSourceAccount = aDestinationAccount ifTrue:[self error: self class cannotTransferFromAccountToSameAccount ].

	Deposit register: aTransferenceValue on: aDestinationAccount.
	Withdraw register: aTransferenceValue on: aSourceAccount.
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'Fs 11/9/2020 19:43:46'!
from: aSourceAccount to: aDestinationAccount registerWithValue: aTransferenceValue

	^self new initializeFrom: aSourceAccount to: aDestinationAccount withValue: aTransferenceValue ! !


!Transference class methodsFor: 'error handling' stamp: 'Fs 11/9/2020 19:42:46'!
error: aString 
	self shouldBeImplemented.! !


!Transference class methodsFor: 'error description' stamp: 'Fs 11/9/2020 20:10:14'!
cannotTransferFromAccountToSameAccount
	^'You cannot make a transfer from an account to the same account'! !

!Transference class methodsFor: 'error description' stamp: 'Fs 11/9/2020 20:05:29'!
cannotTransferNegativeMoneyErrorDescription
	^'You cannot transfer negative money!!'! !
