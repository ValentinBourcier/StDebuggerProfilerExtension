Extension { #name : #TimeProfiler }

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> reset [

	result := nil.
	block := nil.
	blockSource := nil.
	rootMessageTally := nil
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> runCallFromContext: aContext [

	[	
		aContext receiver
			perform: aContext method selector
			withArguments: aContext arguments 
	] onErrorDo: [ nil ]
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> runFromContext: aContext iterations: aIterationNumber [

	aContext ifNil: [ self error: 'Cannot run the profiler on a nil context.' ].
	self runBlock: [ aIterationNumber timesRepeat: [ self runCallFromContext: aContext ] ]
]

{ #category : #'*StDebuggerProfilerExtension' }
TimeProfiler >> treeMorph: aMorph [

	treeMorph := aMorph
	
]
