Extension { #name : #TimeProfiler }

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> performCallFrom: aContext [

	[
	aContext receiver
		perform: aContext method selector
		withArguments: aContext arguments ] onErrorDo: [ nil ]
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> profileCallFrom: aContext iterations: aIterationNumber [

	self runBlock: [
		aIterationNumber timesRepeat: [ self performCallFrom: aContext ] ]
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> reset [

	result := nil.
	block := nil.
	blockSource := nil.
	rootMessageTally := nil
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> treeMorph: aMorph [

	treeMorph := aMorph
	
]
