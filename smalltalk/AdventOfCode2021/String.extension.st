Extension { #name : #String }

{ #category : #'*AdventOfCode2021' }
String >> asPoint [
   | values |
   values := $, split: self.
   ^ values size = 2 ifTrue: [values first asNumber @ values last asNumber]
        ifFalse: [nil]
]

{ #category : #'*AdventOfCode2021' }
String >> foldAlong [
	^ self beginsWith: 'fold along'
]
