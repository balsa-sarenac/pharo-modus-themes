"
One of the eight Modus palettes, with the color names used upstream:

```
(ModusPalette named: #vivendi) at: #'bg-main'.
(ModusPalette named: #operandiTinted) at: #string.
```
"
Class {
	#name : #ModusPalette,
	#superclass : #Object,
	#instVars : [
		'name',
		'colors'
	],
	#classInstVars : [
		'cache'
	],
	#category : #'ModusThemes-Palette'
}

{ #category : #contrast }
ModusPalette class >> contrastRatioOf: aColor and: anotherColor [
	"WCAG 2 contrast ratio, from 1 to 21."

	| l1 l2 |
	l1 := self relativeLuminanceOf: aColor.
	l2 := self relativeLuminanceOf: anotherColor.
	^ ((l1 max: l2) + 0.05) / ((l1 min: l2) + 0.05)
]

{ #category : #accessing }
ModusPalette class >> named: aSymbol [

	(self variantNames includes: aSymbol) ifFalse: [
		^ self error: 'Unknown Modus variant: ' , aSymbol printString ].
	cache ifNil: [ cache := IdentityDictionary new ].
	^ cache at: aSymbol ifAbsentPut: [
		  self new setName: aSymbol entries: (ModusPaletteData perform: aSymbol) ]
]

{ #category : #contrast }
ModusPalette class >> relativeLuminanceOf: aColor [

	| linear |
	linear := [ :c |
	          c <= 0.03928
		          ifTrue: [ c / 12.92 ]
		          ifFalse: [ (c + 0.055) / 1.055 raisedTo: 2.4 ] ].
	^ (0.2126 * (linear value: aColor red))
	  + (0.7152 * (linear value: aColor green))
	  + (0.0722 * (linear value: aColor blue))
]

{ #category : #accessing }
ModusPalette class >> resetCache [

	cache := nil
]

{ #category : #accessing }
ModusPalette class >> variantNames [

	^ #( #operandi #operandiTinted #operandiDeuteranopia #operandiTritanopia
	     #vivendi #vivendiTinted #vivendiDeuteranopia #vivendiTritanopia )
]

{ #category : #accessing }
ModusPalette >> at: aSymbol [

	^ colors at: aSymbol ifAbsent: [
		  self error: self printString , ' has no color ' , aSymbol printString ]
]

{ #category : #accessing }
ModusPalette >> at: aSymbol ifAbsent: aBlock [

	^ colors at: aSymbol ifAbsent: aBlock
]

{ #category : #accessing }
ModusPalette >> colorNames [

	^ colors keys asSortedCollection asArray
]

{ #category : #contrast }
ModusPalette >> contrastBetween: aSymbol and: anotherSymbol [

	^ self class contrastRatioOf: (self at: aSymbol) and: (self at: anotherSymbol)
]

{ #category : #testing }
ModusPalette >> isDark [

	^ name beginsWith: 'vivendi'
]

{ #category : #accessing }
ModusPalette >> name [

	^ name
]

{ #category : #printing }
ModusPalette >> printOn: aStream [

	aStream
		nextPutAll: 'Modus ';
		nextPutAll: name
]

{ #category : #initialization }
ModusPalette >> setName: aSymbol entries: anArray [

	name := aSymbol.
	colors := IdentityDictionary new.
	anArray pairsDo: [ :key :hex | colors at: key put: (Color fromHexString: hex) ]
]
