"
I check the Modus UI themes and their syntax highlighting, without making any of them the current theme.
"
Class {
	#name : #ModusThemeTest,
	#superclass : #TestCase,
	#category : #'ModusThemes-Tests'
}

{ #category : #helpers }
ModusThemeTest >> colorSelectors [

	^ #( #backgroundColor #textColor #baseColor #lightBaseColor #darkBaseColor
	     #basePassiveBackgroundColor #baseSelectionColor #lightSelectionColor
	     #veryLightSelectionColor #borderColor #buttonColor #caretColor
	     #selectionColor #selectionTextColor #unfocusedSelectionColor
	     #secondarySelectionColor #mouseOverColor #windowColor #menuColor
	     #desktopColor #balloonBackgroundColor #lineNumberColor #ghostTextColor
	     #disabledColor #dangerTextColor #warningTextColor #successTextColor
	     #diffAdditionalLineBackgroundColor #diffRemovedLinesBackgroundColor
	     #diffModificatedLineBackgroundColor #urlColor #classExtensionColor )
]

{ #category : #tests }
ModusThemeTest >> testColorsComeFromThePalette [

	self themeClasses do: [ :themeClass |
		| theme palette |
		theme := themeClass newDefault.
		palette := themeClass palette.
		self assert: theme backgroundColor equals: (palette at: #'bg-main').
		self assert: theme textColor equals: (palette at: #'fg-main').
		self assert: theme selectionColor equals: (palette at: #'bg-completion').
		self assert: theme settings windowColor equals: (palette at: #'bg-dim') ]
]

{ #category : #tests }
ModusThemeTest >> testDarkAndLightSuperclasses [

	ModusPalette darkVariantNames do: [ :each |
		self assert: ((ModusThemes themeClassNamed: each) inheritsFrom: PharoDarkTheme) ].
	ModusPalette lightVariantNames do: [ :each |
		self assert: ((ModusThemes themeClassNamed: each) inheritsFrom: PharoLightTheme) ]
]

{ #category : #tests }
ModusThemeTest >> testEveryColorAccessorAnswersAColor [

	self themeClasses do: [ :themeClass |
		| theme |
		theme := themeClass newDefault.
		self colorSelectors do: [ :selector |
			self
				assert: (theme perform: selector) isColor
				description: themeClass name , '>>' , selector ] ]
]

{ #category : #tests }
ModusThemeTest >> testStyleTableIsRegisteredWithShout [

	self themeClasses do: [ :themeClass |
		| table |
		table := SHRBTextStyler perform: themeClass styleTableSelector.
		self assert: table equals: themeClass styleTable.
		self assert: themeClass newDefault shStyleTable equals: table ]
]

{ #category : #tests }
ModusThemeTest >> testStyleTableUsesPaletteColors [

	self themeClasses do: [ :themeClass |
		| table palette lookup |
		palette := themeClass palette.
		table := themeClass styleTable.
		lookup := [ :key | (table detect: [ :each | each first = key ]) second ].
		self assert: (lookup value: #default) equals: (palette at: #'fg-main').
		self assert: (lookup value: #string) equals: (palette at: #string).
		self assert: (lookup value: #comment) equals: (palette at: #comment).
		self assert: (lookup value: #self) equals: (palette at: #builtin).
		self assert: (lookup value: #globalVar) equals: (palette at: #type).
		"Every entry can be turned into Shout text attributes"
		table do: [ :each |
			self assert: each size equals: 3.
			self assert: (Color colorFrom: each second) isColor ] ]
]

{ #category : #tests }
ModusThemeTest >> testStyleTableWithBoldAndItalicConstructs [

	| bold italic |
	bold := ModusThemes boldConstructs.
	italic := ModusThemes italicConstructs.
	[
	ModusThemes
		classVarNamed: 'BoldConstructs' put: true;
		classVarNamed: 'ItalicConstructs' put: true.
	self assert: ((ModusVivendiTheme styleTable detect: [ :each | each first = #comment ]) third) equals: #italic.
	self assert: ((ModusVivendiTheme styleTable detect: [ :each | each first = #patternSelector ]) third) equals: #bold ]
		ensure: [
			ModusThemes
				classVarNamed: 'BoldConstructs' put: bold;
				classVarNamed: 'ItalicConstructs' put: italic ]
]

{ #category : #tests }
ModusThemeTest >> testThemeClasses [

	self assert: ModusThemes themeClasses size equals: 8.
	self themeClasses do: [ :each |
		self deny: each isAbstract.
		self assert: (each themeName beginsWith: 'Modus ').
		self assert: (UITheme allThemeClasses includes: each) ]
]

{ #category : #tests }
ModusThemeTest >> testThemeNames [

	self assert: ModusVivendiTheme themeName equals: 'Modus Vivendi'.
	self assert: ModusOperandiTintedTheme themeName equals: 'Modus Operandi Tinted'.
	self assert: ModusVivendiDeuteranopiaTheme themeName equals: 'Modus Vivendi Deuteranopia'
]

{ #category : #helpers }
ModusThemeTest >> themeClasses [

	^ ModusThemes themeClasses
]
