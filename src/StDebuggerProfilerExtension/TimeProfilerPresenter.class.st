Class {
	#name : #TimeProfilerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'profiler',
		'profilerMorph',
		'tree',
		'summary',
		'report',
		'code',
		'blockCode',
		'panel',
		'withCodeAndStatistics'
	],
	#category : #'StDebuggerProfilerExtension-TimeProfiler-Presenters'
}

{ #category : #'private - gui' }
TimeProfilerPresenter >> createBlockCodeComponent [

	| blockCodePaneMorph |
	blockCodePaneMorph := profilerMorph
		                      newTextEditorFor: profiler
		                      getText: #blockCode
		                      setText: #blockCode:notifying:
		                      getEnabled: nil.
	blockCodePaneMorph getMenuSelector: #codePaneMenu:shifted:.
	blockCodePaneMorph font: StandardFonts codeFont.
	blockCodePaneMorph alwaysAccept: true.
	blockCode := self specWrapperFor: blockCodePaneMorph
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> createCodeComponent [

	|codePaneMorph|
	codePaneMorph := profilerMorph
		                 newTextEditorFor: profiler
		                 getText: #selectedMethodCode
		                 setText: #selectedMethodCode:notifying:
		                 getEnabled: nil.
	codePaneMorph getMenuSelector: #codePaneMenu:shifted:.
	codePaneMorph font: StandardFonts codeFont.
	code := self specWrapperFor: codePaneMorph
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> createComponents [

	profilerMorph := TimeProfilerThemedModelMorph new model: profiler; yourself.

	self createTreeComponent.
	self createSummaryComponent.
	self createReportComponent.
	self createCodeComponent.
	self createBlockCodeComponent
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> createReportComponent [

	| fullReportMorph |
	fullReportMorph := profilerMorph
		                   newTextEditorFor: profiler
		                   getText: #fullReport
		                   setText: nil
		                   getEnabled: nil.
	fullReportMorph getMenuSelector: #fullReportMenu:shift:.
	report := self specWrapperFor: fullReportMorph
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> createSummaryComponent [

	summary := self specWrapperFor: (profilerMorph
		                newTextEditorFor: profiler
		                getText: #summaryText
		                setText: nil
		                getEnabled: nil)
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> createTreeComponent [
	| treeMorph|
	treeMorph := profiler treeMorph
			         buildContents;
			         yourself.
	profiler treeMorph: treeMorph.
	tree := self specWrapperFor: (treeMorph).
]

{ #category : #initialization }
TimeProfilerPresenter >> initializePresenters [

	withCodeAndStatistics := true
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> packComponents [

	| topLayout bottomLayout |
	"Creates layouts"
	topLayout := SpBoxLayout newVertical.
	bottomLayout := withCodeAndStatistics
		                ifTrue: [
			                SpPanedLayout newVertical
				                positionOfSlider: 0.7;
				                yourself ]
		                ifFalse: [ SpBoxLayout newVertical ].

	"Composes top layout"
	profiler withBlockCodePane ifTrue: [ topLayout add: blockCode ].
	topLayout add: bottomLayout.

	"Composes paned layout"
	bottomLayout add: (self newNotebook
			 addPageTitle: 'Call tree' provider: [ tree ];
			 addPageTitle: 'Full report' provider: [ report ];
			 yourself).
	withCodeAndStatistics ifTrue: [
		bottomLayout add: (self newNotebook
				 addPageTitle: 'Code' provider: [ code ];
				 addPageTitle: 'Statistics' provider: [ summary ];
				 yourself).
		bottomLayout positionOfSlider: 0.7 ].

	"Update the layout"
	self layout: topLayout
]

{ #category : #api }
TimeProfilerPresenter >> profiler: aProfiler [

	profiler := aProfiler.
	self createComponents.
	self packComponents.
]

{ #category : #api }
TimeProfilerPresenter >> refresh [

	self profiler: profiler
]

{ #category : #'private - gui' }
TimeProfilerPresenter >> specWrapperFor: aMorph [
	
	^ self newMorph morph: aMorph; yourself
]

{ #category : #options }
TimeProfilerPresenter >> withCodeAndStatistics [

	withCodeAndStatistics := true
]

{ #category : #options }
TimeProfilerPresenter >> withoutCodeAndStatistics [

	withCodeAndStatistics := false
]
