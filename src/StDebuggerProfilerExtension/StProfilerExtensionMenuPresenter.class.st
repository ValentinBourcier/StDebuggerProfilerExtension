Class {
	#name : #StProfilerExtensionMenuPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'startBlock',
		'startButton',
		'iterationsInput',
		'selectedMethodLabel',
		'context',
		'withContextDescription'
	],
	#category : #'StDebuggerProfilerExtension-Presenters'
}

{ #category : #accessing }
StProfilerExtensionMenuPresenter >> context: aContext [

	context := aContext.
	selectedMethodLabel text: self contextDescription
]

{ #category : #context }
StProfilerExtensionMenuPresenter >> contextDescription [

	^ context receiver asString trimBoth
		, ' '
		, (Message selector: context selector arguments: context arguments) asString trimBoth
]

{ #category : #layout }
StProfilerExtensionMenuPresenter >> defaultLayout [

	| lt |
	lt := SpBoxLayout newVertical
		      spacing: 5;
		      yourself.

	withContextDescription ifTrue: [
		lt
			add: 'Stack''s selected call' width: 100;
			add: selectedMethodLabel height: 60 ].
	lt
		add: (SpBoxLayout newHorizontal
				 add: 'Iterations' width: 100;
				 add: iterationsInput width: 100;
				 hAlignStart;
				 yourself)
		height: 24;
		add: startButton height: 34.

	^ lt
]

{ #category : #initialization }
StProfilerExtensionMenuPresenter >> initializePresenters [

	withContextDescription := false.

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

{ #category : #hook }
StProfilerExtensionMenuPresenter >> onProfileDo: aBlock [

	startButton action: [ aBlock cull: context cull: iterationsInput number ]
]

{ #category : #accessing }
StProfilerExtensionMenuPresenter >> withContextDescription [

	withContextDescription := true
]

{ #category : #accessing }
StProfilerExtensionMenuPresenter >> withoutContextDescription [

	withContextDescription := false
]
