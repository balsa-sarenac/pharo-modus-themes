"Renders a system browser under each Modus theme into screenshots/<variant>.png.
The second chunk compiles only after the first has loaded the themes."

| root |
root := (Smalltalk os environment at: 'GITHUB_WORKSPACE' ifAbsent: [ FileSystem workingDirectory fullName ]) asFileReference.
Metacello new
	baseline: 'ModusThemes';
	repository: 'tonel://' , (root / 'src') fullName;
	load.
!

| root out log world |
root := (Smalltalk os environment at: 'GITHUB_WORKSPACE' ifAbsent: [ FileSystem workingDirectory fullName ]) asFileReference.
out := (root / 'screenshots') ensureCreateDirectory; yourself.
log := [ :string | Stdio stdout nextPutAll: string; lf; flush ].
world := self currentWorld.

(Smalltalk at: #ModusThemes) themeClasses do: [ :themeClass |
	[ | window |
	(world submorphs select: [ :each | each isSystemWindow ]) do: [ :each | each delete ].
	themeClass beCurrent.
	ClyFullBrowserMorph openOnMethod: (Smalltalk at: #ModusStyleTable) >> #buildIdentifiers.
	world doOneCycleNow.
	window := world submorphs detect: [ :each | each isSystemWindow ].
	window
		position: 10 @ 10;
		extent: 1100 @ 640.
	3 timesRepeat: [ world doOneCycleNow ].
	PNGReadWriter
		putForm: window imageForm
		onFileNamed: (out / (themeClass variantName , '.png')) fullName.
	log value: 'Saved ' , themeClass themeName ]
		on: Error
		do: [ :error |
			log value: 'FAILED ' , themeClass themeName , ': ' , error description.
			log value: (String streamContents: [ :s | error signalerContext debugStackOn: s ]) ] ].

Smalltalk snapshot: false andQuit: true
!
