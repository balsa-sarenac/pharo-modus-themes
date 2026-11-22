"
I check that the generated palettes are complete and keep the Modus accessibility promise.
"
Class {
	#name : #ModusPaletteTest,
	#superclass : #TestCase,
	#category : #'ModusThemes-Tests'
}

{ #category : #helpers }
ModusPaletteTest >> palettesDo: aBlock [

	ModusPalette variantNames do: [ :each | aBlock value: (ModusPalette named: each) ]
]

{ #category : #running }
ModusPaletteTest >> setUp [

	super setUp.
	ModusPalette resetCache
]

{ #category : #tests }
ModusPaletteTest >> testAllPalettesHaveTheSameKeys [

	| keys |
	keys := ModusPalette vivendi colorNames.
	self palettesDo: [ :palette | self assert: palette colorNames equals: keys ]
]

{ #category : #tests }
ModusPaletteTest >> testBackgroundsOfLightAndDarkVariants [

	self palettesDo: [ :palette |
		| background |
		background := palette at: #'bg-main'.
		palette isDark
			ifTrue: [ self assert: background luminance < 0.2 ]
			ifFalse: [ self assert: background luminance > 0.8 ] ]
]

{ #category : #tests }
ModusPaletteTest >> testCachesPalettes [

	self assert: (ModusPalette named: #vivendi) identicalTo: ModusPalette vivendi
]

{ #category : #tests }
ModusPaletteTest >> testCodeColorsAreReadable [
	"Upstream tunes accents for at least 7:1 against the main background in most variants. A few tinted ones land a bit lower, so require WCAG AA here."

	self palettesDo: [ :palette |
		#( #comment #string #keyword #builtin #constant #fnname #type
		   #variable #'variable-use' #preprocessor #err #warning #info )
			do: [ :key |
				self
					assert: (palette contrastBetween: key and: #'bg-main') >= 4.5
					description: palette printString , ' ' , key , ' contrast' ] ]
]

{ #category : #tests }
ModusPaletteTest >> testMainTextReachesAAAContrast [
	"The point of Modus: a minimum contrast ratio of 7:1 (WCAG AAA) for text against its background."

	self palettesDo: [ :palette |
		self assert: (palette contrastBetween: #'fg-main' and: #'bg-main') >= 7.
		self assert: (palette contrastBetween: #'fg-main' and: #'bg-dim') >= 7.
		self assert: (palette contrastBetween: #'fg-main' and: #'bg-completion') >= 7 ]
]

{ #category : #tests }
ModusPaletteTest >> testContrastRatio [

	self
		assert: (ModusPalette contrastRatioOf: Color black and: Color white)
		closeTo: 21.
	self
		assert: (ModusPalette contrastRatioOf: Color white and: Color white)
		closeTo: 1
]

{ #category : #tests }
ModusPaletteTest >> testEightVariants [

	self assert: ModusPalette variantNames size equals: 8.
	self assert: ModusPalette lightVariantNames size equals: 4.
	self assert: ModusPalette darkVariantNames size equals: 4
]

{ #category : #tests }
ModusPaletteTest >> testKnownUpstreamValues [

	self assert: (ModusPalette vivendi hexAt: #'bg-main') equals: '000000'.
	self assert: (ModusPalette vivendi hexAt: #'fg-main') equals: 'ffffff'.
	self assert: (ModusPalette operandi hexAt: #'bg-main') equals: 'ffffff'.
	self assert: (ModusPalette operandi hexAt: #'fg-main') equals: '000000'.
	"Semantic mappings resolve to named colors"
	self
		assert: (ModusPalette vivendi hexAt: #string)
		equals: (ModusPalette vivendi hexAt: #'blue-warmer').
	self
		assert: (ModusPalette vivendi at: #'bg-main')
		equals: (Color fromHexString: '000000')
]

{ #category : #tests }
ModusPaletteTest >> testUnknownColor [

	self should: [ ModusPalette vivendi at: #'no-such-color' ] raise: Error.
	self assert: (ModusPalette vivendi at: #'no-such-color' ifAbsent: [ 42 ]) equals: 42
]

{ #category : #tests }
ModusPaletteTest >> testUnknownVariant [

	self should: [ ModusPalette named: #solarized ] raise: Error
]
