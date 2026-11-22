"
I load the Modus themes, a port of Protesilaos Stavrou's highly accessible Emacs themes, into Pharo.

```
Metacello new
	baseline: 'ModusThemes';
	repository: 'github://balsa-sarenac/pharo-modus-themes:trunk/src';
	load.
```

Groups: `default` / `Core` (the themes) and `Tests` (themes plus their tests).
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
