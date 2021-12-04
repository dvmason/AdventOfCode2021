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

{ #category : #'*AdventOfCode2021' }
Array >> day03Filter: position for: match [
   | count search filtered |
   self size = 1 ifTrue: [^ Integer readFrom: self first base: 2].
   count := 0.
   self do: [:line | (line at: position) = $1 ifTrue: [count := count + 1]].
   search := $1.
   self size / 2 <= count ifTrue: [match = #least ifTrue: [search := $0]]
      ifFalse: [match = #most ifTrue: [search := $0]].
   filtered := self select: [:each | (each at: position) = search].
   filtered isEmpty ifTrue: [filtered := self].
   ^ filtered day03Filter: position + 1 for: match
]
