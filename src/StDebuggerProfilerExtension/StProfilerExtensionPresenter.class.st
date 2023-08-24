Class {
	#name : #StProfilerExtensionPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'profiler',
		'profilerPane',
		'toolbarPane'
	],
	#category : #'StDebuggerProfilerExtension-Presenters'
}

{ #category : #presenters }
StProfilerExtensionPresenter >> connectPresenters [
		
		toolbarPane onStartDo: [
			self
				profileMethodFrom: debugger selectedContext
				iterations: toolbarPane iterations.
			profilerPane refresh
		]
	
]

{ #category : #'debugger extension' }
StProfilerExtensionPresenter >> debuggerExtensionToolName [
	
		^ 'Time profiler'
	
]

{ #category : #layout }
StProfilerExtensionPresenter >> debuggerLayout [
	
		^ SpBoxLayout newVertical
			  add: toolbarPane height: 160;
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
		toolbarPane := StProfilerExtensionMenuPresenter new.
		profilerPane := TimeProfilerPresenter new
		                profiler: profiler;
		                yourself
	
]

{ #category : #context }
StProfilerExtensionPresenter >> profileMethodFrom: aContext iterations: aIterationNumber [

		profiler runBlock: [
			aIterationNumber timesRepeat: [ self runMethodFromContext: aContext ] 
		]
	
]

{ #category : #context }
StProfilerExtensionPresenter >> runMethodFromContext: aContext [

		[ 
			aContext receiver 
				perform: aContext method selector 
				withArguments: aContext arguments 
		] 
		onErrorDo: [ nil ] 
	
]

{ #category : #presenters }
StProfilerExtensionPresenter >> updatePresenter [
	
		debugger selectedContext ifNotNil: [
			toolbarPane context: debugger selectedContext.
			profiler reset.
			profilerPane refresh
		]
	
]
