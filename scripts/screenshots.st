"Render a system browser under every Modus theme and save it as PNG.
Run from a checkout: pharo Pharo.image st --quit scripts/screenshots.st
Writes screenshots/<variant>.png next to src/."

| root out log |
root := (Smalltalk os environment at: 'GITHUB_WORKSPACE' ifAbsent: [ FileSystem workingDirectory fullName ]) asFileReference.
out := (root / 'screenshots') ensureCreateDirectory; yourself.
log := [ :string | Stdio stdout nextPutAll: string; lf; flush ].

Metacello new
	baseline: 'ModusThemes';
	repository: 'tonel://' , (root / 'src') fullName;
	load.

log value: 'Display: ' , Display extent printString , ' depth ' , Display depth printString.

ModusThemes themeClasses do: [ :themeClass |
	[ | window |
	(World submorphs select: [ :each | each isSystemWindow ]) do: [ :each | each delete ].
	themeClass beCurrent.
	ClyFullBrowserMorph openOnMethod: ModusStyleTable >> #buildIdentifiers.
	World doOneCycleNow.
	window := World submorphs detect: [ :each | each isSystemWindow ].
	window
		position: 10 @ 10;
		extent: 1100 @ 640.
	3 timesRepeat: [ World doOneCycleNow ].
	PNGReadWriter
		putForm: window imageForm
		onFileNamed: (out / (themeClass variantName , '.png')) fullName.
	log value: 'Saved ' , themeClass themeName ]
		on: Error
		do: [ :error |
			log value: 'FAILED ' , themeClass themeName , ': ' , error description.
			log value: (String streamContents: [ :s | error signalerContext debugStackOn: s ]) ] ].

Smalltalk snapshot: false andQuit: true
