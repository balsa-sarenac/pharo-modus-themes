"
Elegant, highly legible light theme with a white background. Conforms to WCAG AAA (7:1 contrast).

Make me current with `ModusOperandiTheme beCurrent` or `ModusThemes load: #operandi`.
"
Class {
	#name : #ModusOperandiTheme,
	#superclass : #PharoLightTheme,
	#traits : 'TModusTheme',
	#classTraits : 'TModusTheme classTrait',
	#category : #'ModusThemes-Themes'
}

{ #category : #accessing }
ModusOperandiTheme class >> variantName [

	^ #operandi
]
