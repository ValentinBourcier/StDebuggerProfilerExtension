Class {
	#name : #StProfilerExtensionMenuPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'startBlock',
		'startButton',
		'iterationsInput',
		'selectedMethodLabel'
	],
	#category : #'StDebuggerProfilerExtension-Presenters'
}

{ #category : #accessing }
StProfilerExtensionMenuPresenter >> context: aContext [

	selectedMethodLabel text: (self contextMethodText: aContext)
]

{ #category : #context }
StProfilerExtensionMenuPresenter >> contextMethodText: aContext [

	^ aContext receiver asString 
		, ' '
		, (Message selector: aContext selector arguments: aContext arguments) asString
]

{ #category : #layout }
StProfilerExtensionMenuPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 5;
		  add: 'Stack''s selected call' width: 100;
		  add: selectedMethodLabel height: 60;
		  add: (SpBoxLayout newHorizontal
				   add: 'Iterations' width: 100;
				   add: iterationsInput width: 100;
				   hAlignStart;
				   yourself)
		  height: 24;
		  add: startButton height: 34;
		  yourself
]

{ #category : #initialization }
StProfilerExtensionMenuPresenter >> initializePresenters [

	selectedMethodLabel := self newText beNotEditable.

	iterationsInput := self newNumberInput
		                   number: 1000;
		                   minimum: 0;
		                   climbRate: 100;
		                   yourself.

	startButton := self newButton
		               label: 'Start profiling';
		               icon: (self iconNamed: #glamorousGo);
		               action: startBlock;
		               yourself
]

{ #category : #accessing }
StProfilerExtensionMenuPresenter >> iterations [
	
	^ iterationsInput number
]

{ #category : #enumerating }
StProfilerExtensionMenuPresenter >> onStartDo: aBlock [

	startButton action: aBlock 
]
