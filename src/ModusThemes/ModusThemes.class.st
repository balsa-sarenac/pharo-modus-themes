"
I am the entry point of the Modus themes for Pharo, a port of the Emacs modus-themes by Protesilaos Stavrou.

Switch themes:

```
ModusThemes operandi.            ""light, the default Modus light theme""
ModusThemes vivendi.             ""dark""
ModusThemes load: #vivendiTinted.
ModusThemes toggle.              ""between the two themes of #toggleThemes""
ModusThemes rotate.              ""through the themes of #rotateThemes""
```

The available variants are listed by `ModusThemes themeClasses`.

Like upstream, bold and italic constructs are off by default. Turn them on with:

```
ModusThemes boldConstructs: true.
ModusThemes italicConstructs: true.
```

Both are also available in the Settings browser under Appearance > Modus Themes, as is the pair of themes to toggle between.
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
	"Use bold for method names, ^, and other keywords. Mirrors modus-themes-bold-constructs."

	^ BoldConstructs ifNil: [ false ]
]

{ #category : #settings }
ModusThemes class >> boldConstructs: aBoolean [

	BoldConstructs := aBoolean.
	self refresh
]

{ #category : #accessing }
ModusThemes class >> current [
	"Answer the current Modus theme class, or nil if the current theme is not a Modus theme."

	| current |
	current := UITheme current class.
	^ (self themeClasses includes: current)
		  ifTrue: [ current ]
		  ifFalse: [ nil ]
]

{ #category : #settings }
ModusThemes class >> italicConstructs [
	"Use italics for comments and block arguments. Mirrors modus-themes-italic-constructs."

	^ ItalicConstructs ifNil: [ false ]
]

{ #category : #settings }
ModusThemes class >> italicConstructs: aBoolean [

	ItalicConstructs := aBoolean.
	self refresh
]

{ #category : #switching }
ModusThemes class >> load: aVariantName [
	"Make the theme for aVariantName (#operandi, #vivendiTinted, ...) the current UI theme."

	^ (self themeClassNamed: aVariantName) beCurrent
]

{ #category : #switching }
ModusThemes class >> operandi [

	<script>
	^ self load: #operandi
]

{ #category : #switching }
ModusThemes class >> refresh [
	"Re-apply the current Modus theme, e.g. after changing a setting."

	ModusPalette resetCache.
	self current ifNotNil: [ :themeClass | themeClass beCurrent ]
]

{ #category : #switching }
ModusThemes class >> rotate [
	"Switch to the next Modus theme, cycling through all of them."

	<script>
	| classes current index |
	classes := self themeClasses.
	current := self current.
	index := current
		         ifNil: [ 1 ]
		         ifNotNil: [ (classes indexOf: current) \\ classes size + 1 ].
	^ (classes at: index) beCurrent
]

{ #category : #settings }
ModusThemes class >> settingsOn: aBuilder [

	<systemsettings>
	(aBuilder group: #modusThemes)
		label: 'Modus Themes';
		parent: #appearance;
		description: 'Highly accessible themes conforming to WCAG AAA (7:1 contrast), ported from Emacs.';
		with: [
			(aBuilder setting: #boldConstructs)
				target: self;
				label: 'Bold constructs';
				description: 'Use bold for method names, return carets and similar constructs.'.
			(aBuilder setting: #italicConstructs)
				target: self;
				label: 'Italic constructs';
				description: 'Use italics for comments and similar constructs.'.
			(aBuilder pickOne: #toggleThemesSetting)
				target: self;
				label: 'Toggle between';
				description: 'The pair of themes used by ModusThemes toggle.';
				domainValues: self toggleChoices ]
]

{ #category : #accessing }
ModusThemes class >> themeClassNamed: aVariantName [

	^ self themeClasses
		  detect: [ :each | each variantName = aVariantName asSymbol ]
		  ifNone: [ self error: 'Unknown Modus variant: ' , aVariantName printString ]
]

{ #category : #accessing }
ModusThemes class >> themeClasses [
	"Answer all concrete Modus theme classes, light ones first."

	^ ModusPalette variantNames collect: [ :each |
		  self environment at:
			  ('Modus' , each first asUppercase asString , each allButFirst , 'Theme') asSymbol ]
]

{ #category : #switching }
ModusThemes class >> toggle [
	"Switch between the two themes of #toggleThemes, like modus-themes-toggle."

	<script>
	| pair |
	pair := self toggleThemes.
	^ self load: (self current
			   ifNil: [ pair first ]
			   ifNotNil: [ :current |
				   current variantName = pair first
					   ifTrue: [ pair last ]
					   ifFalse: [ pair first ] ])
]

{ #category : #settings }
ModusThemes class >> toggleChoices [

	^ {
		  ('Operandi / Vivendi' -> #( #operandi #vivendi )).
		  ('Operandi tinted / Vivendi tinted' -> #( #operandiTinted #vivendiTinted )).
		  ('Deuteranopia' -> #( #operandiDeuteranopia #vivendiDeuteranopia )).
		  ('Tritanopia' -> #( #operandiTritanopia #vivendiTritanopia )) }
]

{ #category : #settings }
ModusThemes class >> toggleThemes [
	"Answer the two variant names that #toggle switches between."

	^ ToggleThemes ifNil: [ #( #operandi #vivendi ) ]
]

{ #category : #settings }
ModusThemes class >> toggleThemes: aPairOfVariantNames [

	ToggleThemes := aPairOfVariantNames
]

{ #category : #settings }
ModusThemes class >> toggleThemesSetting [
	"Setting browser accessor."

	^ self toggleThemes
]

{ #category : #settings }
ModusThemes class >> toggleThemesSetting: aPairOfVariantNames [
	"Setting browser accessor."

	self toggleThemes: aPairOfVariantNames
]

{ #category : #switching }
ModusThemes class >> vivendi [

	<script>
	^ self load: #vivendi
]
