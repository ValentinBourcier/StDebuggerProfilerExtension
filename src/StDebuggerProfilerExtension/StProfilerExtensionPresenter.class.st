Class {
	#name : #StProfilerExtensionPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'profilerModel',
		'menuPane',
		'profilerPane'
	],
	#category : #'StDebuggerProfilerExtension-Presenters'
}

{ #category : #presenters }
StProfilerExtensionPresenter >> connectPresenters [

	menuPane onProfileDo: [ :context :iterations |
		profilerModel runFromContext: context iterations: iterations.
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

	"Model"
	profilerModel := TimeProfiler new
		            withBlockCodePane: false;
		            withToolBar: false;
		            yourself.
	"Widgets"
	menuPane := StProfilerExtensionMenuPresenter new.
	profilerPane := TimeProfilerPresenter new
		                withoutCodeAndStatistics;
		                profiler: profilerModel;
		                yourself
]

{ #category : #presenters }
StProfilerExtensionPresenter >> updatePresenter [

	debugger selectedContext ifNotNil: [
		menuPane context: debugger selectedContext.
		profilerModel reset.
		profilerPane refresh ]
]
