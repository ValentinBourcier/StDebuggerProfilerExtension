Extension { #name : #TimeProfiler }

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
