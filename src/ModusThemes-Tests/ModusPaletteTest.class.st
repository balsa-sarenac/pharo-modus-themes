Class {
	#name : #ModusPaletteTest,
	#superclass : #TestCase,
	#category : #'ModusThemes-Tests'
}

{ #category : #helpers }
ModusPaletteTest >> palettes [

	^ ModusPalette variantNames collect: [ :each | ModusPalette named: each ]
]

{ #category : #tests }
ModusPaletteTest >> testAllPalettesHaveTheSameColorNames [

	| names |
	names := (ModusPalette named: #vivendi) colorNames.
	self palettes do: [ :palette | self assert: palette colorNames equals: names ]
]

{ #category : #tests }
ModusPaletteTest >> testBackgrounds [

	self palettes do: [ :palette |
		| luminance |
		luminance := (palette at: #'bg-main') luminance.
		palette isDark
			ifTrue: [ self assert: luminance < 0.2 ]
			ifFalse: [ self assert: luminance > 0.8 ] ]
]

{ #category : #tests }
ModusPaletteTest >> testCodeColorsAreReadable [
	"Most variants reach 7:1. A few tinted accents land a little lower upstream, so check for AA."

	self palettes do: [ :palette |
		#( #comment #string #keyword #builtin #constant #fnname #type
		   #variable #'variable-use' #preprocessor #err #warning #info )
			do: [ :key |
				self
					assert: (palette contrastBetween: key and: #'bg-main') >= 4.5
					description: palette printString , ' ' , key ] ]
]

{ #category : #tests }
ModusPaletteTest >> testContrastRatio [

	self assert: (ModusPalette contrastRatioOf: Color black and: Color white) closeTo: 21.
	self assert: (ModusPalette contrastRatioOf: Color white and: Color white) closeTo: 1
]

{ #category : #tests }
ModusPaletteTest >> testMainTextReachesAAA [

	self palettes do: [ :palette |
		#( #'bg-main' #'bg-dim' #'bg-completion' ) do: [ :background |
			self assert: (palette contrastBetween: #'fg-main' and: background) >= 7 ] ]
]

{ #category : #tests }
ModusPaletteTest >> testNamed [

	self assert: (ModusPalette named: #vivendi) identicalTo: (ModusPalette named: #vivendi).
	self should: [ ModusPalette named: #solarized ] raise: Error
]

{ #category : #tests }
ModusPaletteTest >> testUpstreamValues [

	| vivendi |
	vivendi := ModusPalette named: #vivendi.
	self assert: (vivendi at: #'bg-main') equals: (Color fromHexString: '000000').
	self assert: (vivendi at: #'fg-main') equals: (Color fromHexString: 'ffffff').
	self assert: (vivendi at: #string) equals: (vivendi at: #'blue-warmer').
	self assert: ((ModusPalette named: #operandi) at: #'bg-main') equals: (Color fromHexString: 'ffffff').
	self should: [ vivendi at: #'no-such-color' ] raise: Error
]
