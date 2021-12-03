Extension { #name : #Array }

{ #category : #'*AdventOfCode2021' }
Array >> day01a [
	| previous count |
	count := 0.
	previous := self first.
	self do: [: current |
			current > previous ifTrue: [ count := count + 1 ].
			previous := current
		].
	^ count
]

{ #category : #'*AdventOfCode2021' }
Array >> day01b [
	| n threeSum count previous |
	n := self size - 2.
	threeSum := (self first: n)+(self allButFirst first: n)+(self allButFirst: 2).
	count := 0.
	previous := threeSum first.
	threeSum do: [: current |
		current > previous ifTrue: [ count := count + 1 ].
		previous := current
	 ].
	^ count
]
