"
I build Shout syntax highlighting tables (as used by `SHRBTextStyler`) from a `ModusPalette`.

The mapping follows the semantic code mappings of the Emacs modus-themes:

- method names in definitions use `fnname`
- `^` uses `keyword`
- `self`, `super`, `thisContext` and `thisProcess` use `builtin`
- `true`, `false`, `nil` and symbols use `constant`
- strings and characters use `string`
- class names and other globals use `type`
- pragmas and primitives use `preprocessor`
- variable definitions use `variable` and variable uses `variable-use`
- comments use `comment`
- numbers, operators and punctuation stay `fg-main`, as upstream
- nested parentheses, brackets and braces use the `rainbow-N` colors

The table contains the token names of both the older (Pharo 9/10) and newer (Pharo 11+) Shout versions, so the same table works everywhere; unknown keys are ignored by Shout.

```
ModusStyleTable forPalette: ModusPalette vivendi.
```
"
Class {
	#name : #ModusStyleTable,
	#superclass : #Object,
	#instVars : [
		'palette',
		'entries'
	],
	#category : #'ModusThemes-Core'
}

{ #category : #'instance creation' }
ModusStyleTable class >> forPalette: aModusPalette [
	"Answer a Shout style table (an Array of arrays) for aModusPalette."

	^ self new
		  setPalette: aModusPalette;
		  build
]

{ #category : #private }
ModusStyleTable >> add: keys color: colorName [

	self add: keys color: colorName emphasis: #normal
]

{ #category : #private }
ModusStyleTable >> add: keys color: colorName emphasis: anEmphasis [

	| color |
	color := palette at: colorName.
	keys do: [ :each | entries add: { each. color. anEmphasis } ]
]

{ #category : #private }
ModusStyleTable >> bold [

	^ ModusThemes boldConstructs
		  ifTrue: [ #bold ]
		  ifFalse: [ #normal ]
]

{ #category : #building }
ModusStyleTable >> build [

	entries := OrderedCollection new.
	self
		buildDefaults;
		buildLiterals;
		buildIdentifiers;
		buildSelectors;
		buildPunctuation;
		buildPragmas;
		buildErrors.
	^ entries asArray
]

{ #category : #building }
ModusStyleTable >> buildDefaults [

	self add: #( #default #keyword #binary #unary #selector #literal ) color: #'fg-main'.
	self add: #( #comment ) color: #comment emphasis: self italic.
	self add: #( #assignment #ansiAssignment ) color: #operator
]

{ #category : #building }
ModusStyleTable >> buildErrors [

	self
		add: #( #invalid #excessCode #unfinishedComment #unfinishedString
		        #undefinedIdentifier #undefinedKeyword #undefinedBinary
		        #undefinedUnary #undefinedSelector )
		color: #err.
	self
		add: #( #incompleteIdentifier #incompleteKeyword #incompleteBinary
		        #incompleteUnary #incompleteSelector )
		color: #'fg-main'
		emphasis: #italic
]

{ #category : #building }
ModusStyleTable >> buildIdentifiers [

	self add: #( #self #super #thisContext #thisProcess ) color: #builtin.
	self add: #( #return ) color: #keyword emphasis: self bold.
	self add: #( #globalVar #global ) color: #type.
	self add: #( #instVar #classVar #poolConstant ) color: #variable.
	"Definitions"
	self add: #( #patternArg #patternTempVar ) color: #variable.
	self
		add: #( #blockPatternArg #blockPatternTempVar )
		color: #variable
		emphasis: self italic.
	"Uses"
	self
		add: #( #argument #methodArg #tempVar #workspaceVar )
		color: #'variable-use'.
	self
		add: #( #blockArg #blockTempVar )
		color: #'variable-use'
		emphasis: self italic
]

{ #category : #building }
ModusStyleTable >> buildLiterals [

	self add: #( #true #false #nil #symbol #stringSymbol ) color: #constant.
	self add: #( #string #character #'$' ) color: #string.
	self add: #( #number #integer #- #literalArray ) color: #number
]

{ #category : #building }
ModusStyleTable >> buildPragmas [

	self
		add: #( #pragma #pragmaKeyword #pragmaUnary #pragmaBinary #primitive
		        #module #externalCallType #externalCallTypePointerIndicator
		        #externalFunctionCallingConvention )
		color: #preprocessor.
	self
		add: #( #primitiveOrExternalCallStart #primitiveOrExternalCallEnd )
		color: #preprocessor
		emphasis: self bold
]

{ #category : #building }
ModusStyleTable >> buildPunctuation [

	self
		add: #( #blockArgColon #methodTempBar #blockTempBar #blockArgsBar )
		color: #delimiter.
	self add: #( #cascadeSeparator #statementSeparator ) color: #punctuation.
	self
		add: #( #parenthesis #leftParenthesis #rightParenthesis #block #blockStart
		        #blockEnd #brace #leftBrace #rightBrace #arrayStart #arrayEnd
		        #arrayStart1 #arrayEnd1 )
		color: #bracket.
	1 to: 7 do: [ :level |
		self
			add: (#( 'parenthesis' 'leftParenthesis' 'rightParenthesis' 'block'
			         'blockStart' 'blockEnd' 'brace' ) collect: [ :each |
					 (each , level printString) asSymbol ])
			color: ('rainbow-' , level printString) asSymbol ]
]

{ #category : #building }
ModusStyleTable >> buildSelectors [

	self
		add: #( #patternSelector #patternKeyword #patternBinary #patternUnary )
		color: #fnname
		emphasis: self bold
]

{ #category : #private }
ModusStyleTable >> italic [

	^ ModusThemes italicConstructs
		  ifTrue: [ #italic ]
		  ifFalse: [ #normal ]
]

{ #category : #initialization }
ModusStyleTable >> setPalette: aModusPalette [

	palette := aModusPalette
]
