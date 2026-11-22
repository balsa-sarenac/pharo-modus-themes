"
Switch between the Modus themes and set their options.

```
ModusThemes vivendi.
ModusThemes load: #operandiTinted.
ModusThemes toggle.
ModusThemes rotate.
ModusThemes boldConstructs: true.
ModusThemes italicConstructs: true.
```
"
Class {
	#name : #ModusThemes,
	#superclass : #Object,
	#classVars : [
		'BoldConstructs',
		'ItalicConstructs',
		'ToggleThemes'
	],
	#category : #'ModusThemes-Core'
}

{ #category : #settings }
ModusThemes class >> boldConstructs [

	^ BoldConstructs ifNil: [ false ]
]

{ #category : #settings }
ModusThemes class >> boldConstructs: aBoolean [

	BoldConstructs := aBoolean.
	self refresh
]

{ #category : #accessing }
ModusThemes class >> current [
	"The current Modus theme class, or nil."

	^ self themeClasses detect: [ :each | each = UITheme current class ] ifNone: [ nil ]
]

{ #category : #settings }
ModusThemes class >> italicConstructs [

	^ ItalicConstructs ifNil: [ false ]
]

{ #category : #settings }
ModusThemes class >> italicConstructs: aBoolean [

	ItalicConstructs := aBoolean.
	self refresh
]

{ #category : #switching }
ModusThemes class >> load: aVariantName [

	^ (self themeClasses detect: [ :each | each variantName = aVariantName ]) beCurrent
]

{ #category : #switching }
ModusThemes class >> operandi [

	<script>
	^ self load: #operandi
]

{ #category : #switching }
ModusThemes class >> refresh [

	self current ifNotNil: [ :themeClass | themeClass beCurrent ]
]

{ #category : #switching }
ModusThemes class >> rotate [

	<script>
	| classes |
	classes := self themeClasses.
	^ (classes at: (classes indexOf: self current) \\ classes size + 1) beCurrent
]

{ #category : #settings }
ModusThemes class >> settingsOn: aBuilder [

	<systemsettings>
	(aBuilder group: #modusThemes)
		label: 'Modus Themes';
		parent: #appearance;
		with: [
			(aBuilder setting: #boldConstructs)
				target: self;
				label: 'Bold constructs';
				description: 'Bold method names, return carets and primitives.'.
			(aBuilder setting: #italicConstructs)
				target: self;
				label: 'Italic constructs';
				description: 'Italic comments and block variables.' ]
]

{ #category : #accessing }
ModusThemes class >> themeClasses [

	^ {
		  ModusOperandiTheme.
		  ModusOperandiTintedTheme.
		  ModusOperandiDeuteranopiaTheme.
		  ModusOperandiTritanopiaTheme.
		  ModusVivendiTheme.
		  ModusVivendiTintedTheme.
		  ModusVivendiDeuteranopiaTheme.
		  ModusVivendiTritanopiaTheme }
]

{ #category : #switching }
ModusThemes class >> toggle [
	"Like modus-themes-toggle in Emacs."

	<script>
	| pair |
	pair := self toggleThemes.
	^ self load: (self current
			   ifNotNil: [ :current |
				   current variantName = pair first
					   ifTrue: [ pair last ]
					   ifFalse: [ pair first ] ]
			   ifNil: [ pair first ])
]

{ #category : #settings }
ModusThemes class >> toggleThemes [

	^ ToggleThemes ifNil: [ #( #operandi #vivendi ) ]
]

{ #category : #settings }
ModusThemes class >> toggleThemes: aPairOfVariantNames [

	ToggleThemes := aPairOfVariantNames
]

{ #category : #switching }
ModusThemes class >> vivendi [

	<script>
	^ self load: #vivendi
]
