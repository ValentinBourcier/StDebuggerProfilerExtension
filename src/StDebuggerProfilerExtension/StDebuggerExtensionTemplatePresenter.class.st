"
I explain how to create an extension for the Pharo debugger (StDebugger).

Pre-requisites:
- Create a spec window, i.e. a class extending SpPresenter.
- Use the trait TStDebuggerExtension.

Important points:
- The extension can access to the instance of debugger it is embedded into.
  Either from the inherited accessor #debugger, or via the instance variable ""debugger"".
- On each update of the debugger call stack, a message ""updatePresenter"" is sent to all active extensions.
"
Class {
	#name : #StDebuggerExtensionTemplatePresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#category : #'StDebuggerProfilerExtension-Template-Presenters'
}

{ #category : #initialization }
StDebuggerExtensionTemplatePresenter >> connectPresenters [
	"
	Method to implement to bind the extension sub-components/widgets (presenters) together.
	
	Example:
	
		widget onClickDo: [
			""TODO: implement the binding behavior.""
			label text: 'New updated text'
		].
	"
]

{ #category : #'debugger extension' }
StDebuggerExtensionTemplatePresenter >> debuggerExtensionToolName [
	"
	The name returned here will be printed in the settings 
	panel dedicated to debugger extensions (activation/de-activation).

	This method HAS to be overriden in every classes using the TStDebuggerExtension trait.
	Otherwise the settings panel cannot resolve debugger extension names, therefore it cannot be opened.
	"

	^ 'Debugger extension template'
	"^ self explicitRequirement"
]

{ #category : #initialization }
StDebuggerExtensionTemplatePresenter >> debuggerLayout [
	"
	To override in order to place elements in the extension pane.
	The method must return a subclass of SpExecutableLayout.
	
	Example:
	
		^ SpBoxLayout newVertical
		  		add: menuPane height: 70;
		  		add: profilerResultsPane;
		  		yourself
	"

	^ SpBoxLayout newVertical
]

{ #category : #initialization }
StDebuggerExtensionTemplatePresenter >> initializePresenters [
	"
	Method to implement to initialize the extension sub-components.
	The method may also contain the initialization of sub-components' model entities.
	
	Example:
	
		profilerModel := TimeProfiler new
		            withBlockCodePane: false;
		            withToolBar: false;
		            yourself.
		menuPane := StProfilerExtensionMenuPresenter new.
		profilerResultsPane := TimeProfilerPresenter new
				          withoutCodeAndStatistics;
		                profiler: profilerModel;
		                yourself
	"

	
]

{ #category : #initialization }
StDebuggerExtensionTemplatePresenter >> updatePresenter [
	"
	Method to implement to fetch data from the (entire) debugger and refresh the extension accordingly.
	Method called:
		- At the creation of the extension UI.
		- Whenever the debugger call stack is updated (See StDebugger >> #updateExtensionsFrom:).
	
	To access the debugger instance, use the variable ""debugger"" or the accessor ""self debugger"" inherited from TStDebuggerExtension.
	
	Example:
	
		debugger selectedContext ifNotNil: [ 
			""TODO: update the extension according to the selected context.""
		].
	"

	
]
