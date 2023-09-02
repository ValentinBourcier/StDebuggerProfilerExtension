Class {
	#name : #BaselineOfStDebuggerProfilerExtension,
	#superclass : #BaselineOf,
	#category : #BaselineOfStDebuggerProfilerExtension
}

{ #category : #baselines }
BaselineOfStDebuggerProfilerExtension >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'StDebuggerProfilerExtension' ]
]
