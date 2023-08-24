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
	#name : #StExtensionTemplatePresenter,
	#superclass : #SpPresenter,
	#traits : 'TStDebuggerExtension',
	#classTraits : 'TStDebuggerExtension classTrait',
	#category : #'StDebuggerProfilerExtension-Template'
}

{ #category : #binding }
StExtensionTemplatePresenter >> connectPresenters [
	"
	Method to implement to bind the extension sub-components/widgets (presenters) together.
	
	Example:
	
		widget onClickDo: [
			""TODO: implement the binding behavior.""
			label text: 'New updated text'
		].
	"
]

{ #category : #accessing }
StExtensionTemplatePresenter >> debugger [
	"
	This accessor provides access to the debugger UI.
	It is inherited from the TStDebuggerTrait.
	"

	^ debugger
]

{ #category : #'debugger extension' }
StExtensionTemplatePresenter >> debuggerExtensionToolName [
	"
	The name returned here will be printed in the settings 
	panel dedicated to debugger extensions (activation/de-activation).

	This method HAS to be overriden in every classes using the TStDebuggerExtension trait.
	Otherwise the settings panel cannot resolve debugger extension names, therefore it cannot be opened.
	"

	^ 'Extension template'
	"^ self explicitRequirement"
]

{ #category : #layout }
StExtensionTemplatePresenter >> debuggerLayout [
	"
	To override in order to place elements in the extension pane.
	The method must return a subclass of SpExecutableLayout.
	
	Example:
	
		^ SpBoxLayout newVertical
			add: 'I am a label';
			yourself
	"

	^ self defaultLayout
]

{ #category : #initialization }
StExtensionTemplatePresenter >> initializePresenters [

	"
	Method to implement to initialize the extension sub-components.
	The method may also contain the initialization of sub-components' model entities.
	
	Example:
	
		calendarModel := CalendarModel new.
		calendarWidget := CalendarPresenter new
			model: calendarModel; 
			yourself.
	"
]

{ #category : #updating }
StExtensionTemplatePresenter >> updatePresenter [
	"
	Method to implement to fetch data from the (entire) debugger and refresh the extension consequently.
	Method called:
		- At the creation of the extension UI.
		- Whenever the debugger call stack is updated (See StDebugger >> #updateExtensionsFrom:).
		
	Example:
	
		debugger selectedContext ifNotNil: [ 
			""TODO: update the extension according to the selected context.""
		].
	"
]
