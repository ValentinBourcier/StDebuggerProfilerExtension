Class {
	#name : #StMyProfilerExtensionPresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#instVars : [
		'profilerModel',
		'menuPane',
		'profilerPane'
	],
	#category : #'StDebuggerProfilerExtension-Template-Presenters'
}

{ #category : #initialization }
StMyProfilerExtensionPresenter >> connectPresenters [
	"
	Method to implement to bind the extension sub-components/widgets (presenters) together.
	"
	menuPane onProfileDo: [ :context :iterations |
		profilerModel runFromContext: context iterations: iterations.
		profilerPane refresh.
	].

]

{ #category : #'debugger extension' }
StMyProfilerExtensionPresenter >> debuggerExtensionToolName [
	"
	The name returned here will be printed in the settings 
	panel dedicated to debugger extensions (activation/de-activation).

	This method HAS to be overriden in every classes using the TStDebuggerExtension trait.
	Otherwise the settings panel cannot resolve debugger extension names, therefore it cannot be opened.
	"

	^ 'My profiler'
	"^ self explicitRequirement"
]

{ #category : #initialization }
StMyProfilerExtensionPresenter >> debuggerLayout [
	"
	To override in order to place elements in the extension pane.
	The method must return a subclass of SpExecutableLayout.
	"
	^ SpBoxLayout newVertical
		  		add: menuPane height: 70;
		  		add: profilerPane;
		  		yourself

]

{ #category : #initialization }
StMyProfilerExtensionPresenter >> initializePresenters [
	"
	Method to implement to initialize the extension sub-components.
	The method may also contain the initialization of sub-components' model entities.
	"

	profilerModel := TimeProfiler new
		            withBlockCodePane: false;
		            withToolBar: false;
		            yourself.

	menuPane := StProfilerExtensionMenuPresenter new.
	profilerPane := TimeProfilerPresenter new
		                withoutCodeAndStatistics;
				          profiler: profilerModel;
		                yourself
]

{ #category : #initialization }
StMyProfilerExtensionPresenter >> updatePresenter [
	"
	Method to implement to fetch data from the (entire) debugger and refresh the extension accordingly.
	Method called:
		- At the creation of the extension UI.
		- Whenever the debugger call stack is updated (See StDebugger >> #updateExtensionsFrom:).
	
	To access the debugger instance, use the variable ""debugger"" or the accessor ""self debugger"" inherited from TStDebuggerExtension.
	"	
		debugger selectedContext ifNotNil: [ 
			menuPane context: debugger selectedContext.
			profilerModel reset.
			profilerPane refresh
		].
	

	
]
