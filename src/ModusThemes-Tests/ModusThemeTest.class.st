Class {
	#name : #ModusThemeTest,
	#superclass : #TestCase,
	#category : #'ModusThemes-Tests'
}

{ #category : #tests }
ModusThemeTest >> testColorsComeFromThePalette [

	ModusThemes themeClasses do: [ :themeClass |
		| theme palette |
		theme := themeClass newDefault.
		palette := themeClass palette.
		self assert: theme backgroundColor equals: (palette at: #'bg-main').
		self assert: theme textColor equals: (palette at: #'fg-main').
		self assert: theme selectionColor equals: (palette at: #'bg-completion').
		self assert: theme settings windowColor equals: (palette at: #'bg-dim') ]
]

{ #category : #tests }
ModusThemeTest >> testColorsAreColors [

	ModusThemes themeClasses do: [ :themeClass |
		| theme |
		theme := themeClass newDefault.
		#( #backgroundColor #textColor #baseColor #lightBaseColor #darkBaseColor
		   #basePassiveBackgroundColor #baseSelectionColor #lightSelectionColor
		   #veryLightSelectionColor #borderColor #buttonColor #caretColor
		   #selectionColor #selectionTextColor #unfocusedSelectionColor
		   #secondarySelectionColor #mouseOverColor #windowColor #menuColor
		   #desktopColor #balloonBackgroundColor #lineNumberColor #ghostTextColor
		   #disabledColor #dangerTextColor #warningTextColor #successTextColor
		   #diffAdditionalLineBackgroundColor #diffRemovedLinesBackgroundColor
		   #diffModificatedLineBackgroundColor #urlColor #classExtensionColor )
			do: [ :selector |
				self
					assert: (theme perform: selector) isColor
					description: themeClass name , '>>' , selector ] ]
]

{ #category : #tests }
ModusThemeTest >> testLightAndDark [

	ModusThemes themeClasses do: [ :themeClass |
		self
			assert: (themeClass inheritsFrom: PharoDarkTheme)
			equals: themeClass palette isDark ]
]

{ #category : #tests }
ModusThemeTest >> testStyleTable [

	ModusThemes themeClasses do: [ :themeClass |
		| palette table colorOf |
		palette := themeClass palette.
		table := themeClass newDefault shStyleTable.
		colorOf := [ :key | (table detect: [ :each | each first = key ]) second ].
		self assert: table equals: themeClass styleTable.
		self assert: (colorOf value: #default) equals: (palette at: #'fg-main').
		self assert: (colorOf value: #string) equals: (palette at: #string).
		self assert: (colorOf value: #comment) equals: (palette at: #comment).
		self assert: (colorOf value: #self) equals: (palette at: #builtin).
		self assert: (colorOf value: #globalVar) equals: (palette at: #type) ]
]

{ #category : #tests }
ModusThemeTest >> testStyleTableWithBoldAndItalicConstructs [

	| bold italic emphasisOf |
	bold := ModusThemes boldConstructs.
	italic := ModusThemes italicConstructs.
	emphasisOf := [ :key | (ModusVivendiTheme styleTable detect: [ :each | each first = key ]) third ].
	[
	ModusThemes
		classVarNamed: 'BoldConstructs' put: true;
		classVarNamed: 'ItalicConstructs' put: true.
	self assert: (emphasisOf value: #comment) equals: #italic.
	self assert: (emphasisOf value: #patternSelector) equals: #bold ] ensure: [
		ModusThemes
			classVarNamed: 'BoldConstructs' put: bold;
			classVarNamed: 'ItalicConstructs' put: italic ]
]

{ #category : #tests }
ModusThemeTest >> testThemeClasses [

	self assert: (ModusThemes themeClasses collect: [ :each | each variantName ]) equals: ModusPalette variantNames.
	ModusThemes themeClasses do: [ :each |
		self deny: each isAbstract.
		self assert: (UITheme allThemeClasses includes: each) ]
]
