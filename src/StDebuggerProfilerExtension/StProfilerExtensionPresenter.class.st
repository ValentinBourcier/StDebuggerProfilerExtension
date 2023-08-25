Class {
	#name : #StProfilerExtensionPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'profiler',
		'menuPane',
		'profilerPane'
	],
	#category : #'StDebuggerProfilerExtension-Presenters'
}

{ #category : #presenters }
StProfilerExtensionPresenter >> connectPresenters [

	menuPane onProfileDo: [ :context :iterations |
		profiler profileCallFrom: context iterations: iterations.
		profilerPane refresh ]
]

{ #category : #'debugger extension' }
StProfilerExtensionPresenter >> debuggerExtensionToolName [

	^ 'Profiler expected result'
]

{ #category : #layout }
StProfilerExtensionPresenter >> debuggerLayout [

	^ SpBoxLayout newVertical
		  add: menuPane height: 70;
		  add: profilerPane;
		  yourself
]

{ #category : #presenters }
StProfilerExtensionPresenter >> initializePresenters [

	"Configuration"
	profiler := TimeProfiler new
		            withBlockCodePane: false;
		            withToolBar: false;
		            yourself.
	"Widgets"
	menuPane := StProfilerExtensionMenuPresenter new.
	profilerPane := TimeProfilerPresenter new
		                profiler: profiler;
		                withoutCodeAndStatistics;
		                yourself
]

{ #category : #presenters }
StProfilerExtensionPresenter >> updatePresenter [

	debugger selectedContext ifNotNil: [
		menuPane context: debugger selectedContext.
		profiler reset.
		profilerPane refresh ]
]
