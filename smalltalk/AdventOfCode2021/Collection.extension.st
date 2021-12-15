Extension { #name : #Collection }

{ #category : #'*AdventOfCode2021' }
Collection >> cellsDo: aBlockClosure [ 
	self do: [: row | row do: aBlockClosure ]
]
