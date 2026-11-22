"
I hold everything the Modus themes share. I am used by `ModusOperandiTheme` (a `PharoLightTheme`) and `ModusVivendiTheme` (a `PharoDarkTheme`).

All colors come from a `ModusPalette`, which uses the names of the Emacs modus-themes. Colors are answered directly by the theme, rather than through the color configurators that Pharo 11 introduced, so the same code works from Pharo 9 onwards.

Users of me define `variantName` on the class side.
"
Trait {
	#name : #TModusTheme,
	#category : #'ModusThemes-Core'
}

{ #category : #'accessing - colors' }
TModusTheme classSide >> baseColor [

	^ self palette at: #'bg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> basePassiveBackgroundColor [

	^ self palette at: #'bg-inactive'
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> baseSelectionColor [

	^ self palette at: #'bg-completion'
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> darkBaseColor [

	^ self palette at: #'bg-dim'
]

{ #category : #testing }
TModusTheme classSide >> isAbstract [

	^ false
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> lightBaseColor [

	^ self palette at: #'bg-inactive'
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> lightSelectionColor [

	^ self palette at: #'bg-completion'
]

{ #category : #accessing }
TModusTheme classSide >> palette [

	^ ModusPalette named: self variantName
]

{ #category : #accessing }
TModusTheme classSide >> styleTable [
	"Answer the Shout style table of this theme."

	^ ModusStyleTable forPalette: self palette
]

{ #category : #accessing }
TModusTheme classSide >> styleTableSelector [
	"The SHRBTextStyler class side selector answering my style table, see the extensions in this package."

	^ ('modus' , self variantName first asUppercase asString , self variantName allButFirst , 'StyleTable') asSymbol
]

{ #category : #accessing }
TModusTheme classSide >> themeName [

	| name |
	name := self variantName.
	^ String streamContents: [ :stream |
		  stream nextPutAll: 'Modus '.
		  name withIndexDo: [ :char :index |
			  index = 1
				  ifTrue: [ stream nextPut: char asUppercase ]
				  ifFalse: [
					  char isUppercase ifTrue: [ stream space ].
					  stream nextPut: char ] ] ]
]

{ #category : #accessing }
TModusTheme classSide >> variantName [
	"Answer the name of my ModusPalette, e.g. #vivendiTinted."

	^ self explicitRequirement
]

{ #category : #'accessing - colors' }
TModusTheme classSide >> veryLightSelectionColor [

	^ self palette at: #'bg-hl-line'
]

{ #category : #initialization }
TModusTheme >> applyModusSettings [
	"Push the palette into the theme settings, which several Pharo versions read directly."

	self settings
		windowColor: (self modusColor: #'bg-dim');
		buttonColor: (self modusColor: #'bg-inactive');
		scrollbarColor: (self modusColor: #'bg-active');
		menuColor: (self modusColor: #'bg-dim');
		menuTitleColor: (self modusColor: #'bg-active');
		menuSelectionColor: (self modusColor: #'bg-completion');
		menuSelectionTextColor: (self modusColor: #'fg-main');
		selectionColor: (self modusColor: #'bg-completion');
		selectionTextColor: (self modusColor: #'fg-main');
		unfocusedSelectionColor: (self modusColor: #'bg-region');
		selectionBarColor: (self modusColor: #'bg-hl-line');
		secondarySelectionTextColor: (self modusColor: #'fg-main');
		findReplaceSelectionColor: (self modusColor: #'bg-search-current');
		findReplaceSelectionTextColor: (self modusColor: #'fg-search-current');
		progressBarColor: (self modusColor: #'bg-dim');
		progressBarProgressColor: (self modusColor: #'bg-completion');
		autoMenuColor: false;
		autoSelectionColor: false;
		standardColorsOnly: true;
		preferGradientFill: false;
		fadedBackgroundWindows: false;
		flatMenu: true
]

{ #category : #'accessing - colors' }
TModusTheme >> backgroundColor [

	^ self modusColor: #'bg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> badgeColor [

	^ self modusColor: #'bg-prominent-err'
]

{ #category : #'accessing - colors' }
TModusTheme >> badgeTextColor [

	^ self modusColor: #'fg-prominent-err'
]

{ #category : #'accessing - colors' }
TModusTheme >> balloonBackgroundColor [
	"Emacs tooltip face."

	^ self modusColor: #'bg-active'
]

{ #category : #'accessing - colors' }
TModusTheme >> balloonTextColor [

	^ self modusColor: #'fg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> baseColor [

	^ self class baseColor
]

{ #category : #'accessing - colors' }
TModusTheme >> basePassiveBackgroundColor [

	^ self class basePassiveBackgroundColor
]

{ #category : #'accessing - colors' }
TModusTheme >> baseSelectionColor [

	^ self class baseSelectionColor
]

{ #category : #'accessing - colors' }
TModusTheme >> borderColor [

	^ self modusColor: #border
]

{ #category : #'accessing - colors' }
TModusTheme >> buttonColor [

	^ self modusColor: #'bg-inactive'
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonDisabledBorderStyleFor: aButton [

	^ SimpleBorderStyle new
		  width: self modusBorderWidth;
		  baseColor: (self modusColor: #'bg-inactive')
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonDisabledFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-dim')
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonMouseOverFillStyleFor: aButton [

	(aButton valueOfProperty: #noFill ifAbsent: [ false ]) ifTrue: [
		^ SolidFillStyle color: Color transparent ].
	^ SolidFillStyle color: (self modusColor: #'bg-hover')
]

{ #category : #'border-styles - buttons' }
TModusTheme >> buttonNormalBorderStyleFor: aButton [

	(aButton valueOfProperty: #noBorder ifAbsent: [ false ]) ifTrue: [
		^ SimpleBorderStyle new
			  width: 0;
			  baseColor: Color transparent ].
	^ SimpleBorderStyle new
		  width: self modusBorderWidth;
		  baseColor: (self modusColor: #border)
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonNormalFillStyleFor: aButton [

	(aButton valueOfProperty: #noFill ifAbsent: [ false ]) ifTrue: [
		^ SolidFillStyle color: Color transparent ].
	^ SolidFillStyle color: (self modusColor: #'bg-inactive')
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonPressedFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-active')
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> buttonSelectedFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-completion')
]

{ #category : #'accessing - colors' }
TModusTheme >> caretColor [

	^ self modusColor: #cursor
]

{ #category : #'accessing - colors' }
TModusTheme >> classExtensionColor [

	^ self modusColor: #'fg-alt'
]

{ #category : #'border-styles' }
TModusTheme >> configureWindowBorderFor: aWindow [

	aWindow borderStyle: (SimpleBorderStyle new
			 color: (self modusColor: #border);
			 width: self modusBorderWidth)
]

{ #category : #'fill-styles - buttons' }
TModusTheme >> controlButtonNormalFillStyleFor: aButton [

	^ self buttonNormalFillStyleFor: aButton
]

{ #category : #'accessing - colors' }
TModusTheme >> dangerBackgroundColor [

	^ self modusColor: #'bg-red-subtle'
]

{ #category : #'accessing - colors' }
TModusTheme >> dangerTextColor [

	^ self modusColor: #err
]

{ #category : #'accessing - colors' }
TModusTheme >> darkBaseColor [

	^ self class darkBaseColor
]

{ #category : #'fill-styles' }
TModusTheme >> desktopColor [

	^ self modusColor: #'bg-inactive'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffAdditionalLineBackgroundColor [

	^ self modusColor: #'bg-added'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffAdditionalTextInLineBackgroundColor [

	^ self modusColor: #'bg-added-refine'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffEdgeColor [

	^ self modusColor: #border
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffJoinColor [

	^ self modusColor: #'bg-active'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffMapColor [

	^ self modusColor: #'bg-dim'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffModificatedLineBackgroundColor [

	^ self modusColor: #'bg-changed'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffRemovalHighlightColor [

	^ self modusColor: #'bg-removed-refine'
]

{ #category : #'basic-colors - diffs' }
TModusTheme >> diffRemovedLinesBackgroundColor [

	^ self modusColor: #'bg-removed'
]

{ #category : #'accessing - colors' }
TModusTheme >> disabledColor [

	^ self modusColor: #'fg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> disabledLabelColor [

	^ self modusColor: #'fg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> disabledTextColor [

	^ self modusColor: #'fg-dim'
]

{ #category : #'fill-styles' }
TModusTheme >> dropListNormalFillStyleFor: aDropList [

	^ self modusColor: #'bg-main'
]

{ #category : #'border-styles' }
TModusTheme >> dropListNormalListBorderStyleFor: aDropList [

	^ SimpleBorderStyle new
		  width: self modusBorderWidth;
		  baseColor: (self modusColor: #border)
]

{ #category : #'fill-styles' }
TModusTheme >> dropListNormalListFillStyleFor: aDropList [

	^ self modusColor: #'bg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> enabledColor [

	^ self modusColor: #'fg-main'
]

{ #category : #'basic-colors' }
TModusTheme >> errorPopperBackgroundColor [

	^ self modusColor: #'bg-prominent-err'
]

{ #category : #'accessing - colors' }
TModusTheme >> ghostTextColor [

	^ self modusColor: #'fg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> highlightTextColor [

	^ self modusColor: #'fg-completion-match-0'
]

{ #category : #initialization }
TModusTheme >> initialize [

	super initialize.
	self applyModusSettings
]

{ #category : #testing }
TModusTheme >> isModusTheme [

	^ true
]

{ #category : #'label-styles' }
TModusTheme >> labelDisabledColorFor: aLabel [

	^ self modusColor: #'fg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> lightBackgroundColor [

	^ self modusColor: #'bg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> lightBaseColor [

	^ self class lightBaseColor
]

{ #category : #'accessing - colors' }
TModusTheme >> lightSelectionColor [

	^ self class lightSelectionColor
]

{ #category : #'accessing - colors' }
TModusTheme >> lineNumberColor [

	^ self modusColor: #'fg-line-number-inactive'
]

{ #category : #'accessing - colors' }
TModusTheme >> listBackgroundColor [

	^ self modusColor: #'bg-main'
]

{ #category : #'fill-styles' }
TModusTheme >> listNormalFillStyleFor: aList [

	^ self modusColor: #'bg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> listTextColor [

	^ self modusColor: #'fg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> menuBorderColor [

	^ self modusColor: #border
]

{ #category : #'accessing - colors' }
TModusTheme >> menuColor [

	^ self modusColor: #'bg-dim'
]

{ #category : #defaults }
TModusTheme >> menuItemDisabledTextColorFor: aMenuItem [

	^ self modusColor: #'fg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> menuKeyboardFocusColor [

	^ self modusColor: #keybind
]

{ #category : #'accessing - colors' }
TModusTheme >> menuSelectionColor [

	^ self modusColor: #'bg-completion'
]

{ #category : #'accessing - colors' }
TModusTheme >> menuTitleColor [

	^ self modusColor: #'bg-active'
]

{ #category : #private }
TModusTheme >> modusBorderWidth [

	^ 1 * self displayScaleFactor
]

{ #category : #accessing }
TModusTheme >> modusColor: aSymbol [
	"Answer the color named aSymbol in my palette, e.g. #'bg-main' or #err."

	^ self palette at: aSymbol
]

{ #category : #'accessing - colors' }
TModusTheme >> mouseOverColor [
	"Emacs highlight face."

	^ self modusColor: #'bg-hover'
]

{ #category : #accessing }
TModusTheme >> palette [

	^ self class palette
]

{ #category : #'accessing - colors' }
TModusTheme >> scrollbarColor [

	^ self modusColor: #'bg-active'
]

{ #category : #'fill-styles - scrollbars' }
TModusTheme >> scrollbarNormalFillStyleFor: aScrollbar [

	^ SolidFillStyle color: (self modusColor: #'bg-dim')
]

{ #category : #'fill-styles - scrollbars' }
TModusTheme >> scrollbarPressedThumbFillStyleFor: aScrollbar [

	^ SolidFillStyle color: (self modusColor: #'bg-completion')
]

{ #category : #'accessing - colors' }
TModusTheme >> secondarySelectionColor [
	"Emacs secondary-selection face."

	^ self modusColor: #'bg-hover-secondary'
]

{ #category : #'accessing - colors' }
TModusTheme >> selectedItemListTextColor [

	^ self modusColor: #'fg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> selectionBarColor [

	^ self modusColor: #'bg-hl-line'
]

{ #category : #'accessing - colors' }
TModusTheme >> selectionColor [

	^ self modusColor: #'bg-completion'
]

{ #category : #'accessing - colors' }
TModusTheme >> selectionTextColor [

	^ self modusColor: #'fg-main'
]

{ #category : #accessing }
TModusTheme >> shStyleTable [

	^ self class styleTable
]

{ #category : #accessing }
TModusTheme >> shStyleTableName [

	^ self class styleTableSelector
]

{ #category : #'fill-styles' }
TModusTheme >> sliderNormalFillStyleFor: aSlider [

	^ self modusColor: #'bg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> spotlightWindowColor [

	^ self modusColor: #'bg-dim'
]

{ #category : #'accessing - colors' }
TModusTheme >> successBackgroundColor [

	^ self modusColor: #'bg-green-subtle'
]

{ #category : #'accessing - colors' }
TModusTheme >> successTextColor [
	"Emacs success face."

	^ self modusColor: #info
]

{ #category : #'fill-styles' }
TModusTheme >> tabLabelNormalFillStyleFor: aTabLabel [

	^ SolidFillStyle color: (self modusColor: #'bg-tab-other')
]

{ #category : #'fill-styles' }
TModusTheme >> tabLabelSelectedFillStyleFor: aTabLabel [

	^ SolidFillStyle color: (self modusColor: #'bg-tab-current')
]

{ #category : #'basic-colors' }
TModusTheme >> taskbarButtonLabelColorFor: aButton [

	^ (aButton model notNil and: [ aButton model isActive ])
		  ifTrue: [ self modusColor: #'fg-main' ]
		  ifFalse: [ self modusColor: #'fg-dim' ]
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarFillStyleFor: aTaskbar [

	^ SolidFillStyle color: (self modusColor: #'bg-tab-bar')
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemDisabledBorderStyleFor: aButton [

	^ self taskbarItemNormalBorderStyleFor: aButton
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemDisabledFillStyleFor: aButton [

	^ self taskbarItemNormalFillStyleFor: aButton
]

{ #category : #'basic-colors' }
TModusTheme >> taskbarItemLabelColorForCollapsed: aButton [

	^ self modusColor: #'fg-dim'
]

{ #category : #'basic-colors' }
TModusTheme >> taskbarItemLabelColorForExpanded: aButton [

	^ self modusColor: #'fg-main'
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemMouseOverBorderStyleFor: aButton [

	^ BottomBorderStyle new
		  color: (self modusColor: #'accent-0');
		  width: 2 * self displayScaleFactor;
		  yourself
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemMouseOverFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-hover')
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemNormalBorderStyleFor: aButton [

	^ BottomBorderStyle new
		  color: (self modusColor: #border);
		  width: 1 * self displayScaleFactor;
		  trimSize: 2 * self displayScaleFactor;
		  yourself
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemNormalFillStyleFor: aButton [

	^ SolidFillStyle color: Color transparent
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemPressedBorderStyleFor: aButton [

	^ self taskbarItemNormalBorderStyleFor: aButton
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemPressedFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-active')
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemSelectedBorderStyleFor: aButton [

	^ self taskbarItemMouseOverBorderStyleFor: aButton
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemSelectedDisabledBorderStyleFor: aButton [

	^ self taskbarItemMouseOverBorderStyleFor: aButton
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemSelectedFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-tab-current')
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemSelectedMouseOverBorderStyleFor: aButton [

	^ self taskbarItemMouseOverBorderStyleFor: aButton
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemSelectedMouseOverFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-hover')
]

{ #category : #'border-styles - taskbar' }
TModusTheme >> taskbarItemSelectedPressedBorderStyleFor: aButton [

	^ self taskbarItemMouseOverBorderStyleFor: aButton
]

{ #category : #'fill-styles - taskbar' }
TModusTheme >> taskbarItemSelectedPressedFillStyleFor: aButton [

	^ SolidFillStyle color: (self modusColor: #'bg-active')
]

{ #category : #'accessing - colors' }
TModusTheme >> textColor [

	^ self modusColor: #'fg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> textColorForNonStandardBackground [

	^ self modusColor: #'fg-main'
]

{ #category : #'fill-styles' }
TModusTheme >> textEditorNormalFillStyleFor: aTextEditor [

	^ self modusColor: #'bg-main'
]

{ #category : #'fill-styles' }
TModusTheme >> textFieldNormalFillStyleFor: aTextField [

	^ self modusColor: #'bg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> unfocusedSelectionColor [

	^ self modusColor: #'bg-region'
]

{ #category : #'accessing - colors' }
TModusTheme >> urlColor [

	^ self modusColor: #'fg-link'
]

{ #category : #'accessing - colors' }
TModusTheme >> veryLightSelectionColor [

	^ self class veryLightSelectionColor
]

{ #category : #'accessing - colors' }
TModusTheme >> warningBackgroundColor [

	^ self modusColor: #'bg-yellow-subtle'
]

{ #category : #'accessing - colors' }
TModusTheme >> warningTextColor [

	^ self modusColor: #warning
]

{ #category : #'fill-styles' }
TModusTheme >> windowActiveLabelFillStyleFor: aWindow [

	^ self modusColor: #'fg-main'
]

{ #category : #'accessing - colors' }
TModusTheme >> windowColor [

	^ self modusColor: #'bg-dim'
]

{ #category : #'fill-styles' }
TModusTheme >> windowInactiveLabelFillStyleFor: aWindow [

	^ self modusColor: #'fg-dim'
]

{ #category : #'fill-styles' }
TModusTheme >> worldMainDockingBarColorFor: aDockingBar [

	^ self modusColor: #'bg-tab-bar'
]
