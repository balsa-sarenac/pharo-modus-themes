"
```
Metacello new
	baseline: 'ModusThemes';
	repository: 'github://balsa-sarenac/pharo-modus-themes:trunk/src';
	load.
```
"
Class {
	#name : #BaselineOfModusThemes,
	#superclass : #BaselineOf,
	#category : #BaselineOfModusThemes
}

{ #category : #baselines }
BaselineOfModusThemes >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'ModusThemes';
			package: 'ModusThemes-Tests' with: [ spec requires: #( 'ModusThemes' ) ].
		spec
			group: 'Core' with: #( 'ModusThemes' );
			group: 'Tests' with: #( 'ModusThemes-Tests' );
			group: 'default' with: #( 'Core' ) ]
]
