"
Elegant, highly legible dark theme with a black background. Conforms to WCAG AAA (7:1 contrast).

Make me current with `ModusVivendiTheme beCurrent` or `ModusThemes load: #vivendi`.
"
Class {
	#name : #ModusVivendiTheme,
	#superclass : #PharoDarkTheme,
	#traits : 'TModusTheme',
	#classTraits : 'TModusTheme classTrait',
	#category : #'ModusThemes-Themes'
}

{ #category : #accessing }
ModusVivendiTheme class >> variantName [

	^ #vivendi
]
