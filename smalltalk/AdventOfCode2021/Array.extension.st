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

{ #category : #'*AdventOfCode2021' }
Array >> day06a: repetitions [ 
	| working |
	working := OrderedCollection withAll: self.
	repetitions timesRepeat: [
		1 to: working size do: [: index |
			(working at: index) = 0 ifTrue: [
					working at: index put: 6.
					working add: 8
				] ifFalse: [
					working at: index put: (working at: index) - 1
				]
		]
	].
	^ working size
]

{ #category : #'*AdventOfCode2021' }
Array >> day06b: repetitions [
	| ages |
	ages := (1 to: 9) collect: [: age | (self select: [: each | each = (age - 1) ]) size ].
	repetitions timesRepeat: [ | zeroes |
		zeroes := ages at: 1.
		1 to: 8 do: [: index | ages at: index put: (ages at: index + 1) ].
		ages at: 7 put: (ages at: 7)+zeroes.
		ages at: 9 put: zeroes
	].
	^ ages sum
]

{ #category : #'*AdventOfCode2021' }
Array >> day07a [
	| bestPosition |
	bestPosition := self median.
	^ (self collect: [: position | (bestPosition - position) abs ]) sum
]

{ #category : #'*AdventOfCode2021' }
Array >> day07b [
	| bestSoFar bestPosition |
	bestSoFar := SmallInteger maxVal.
	bestPosition := -1.
	self min to: self max do: [: possibleBest | | cost |
		cost := 0.
		self do: [: position | | distance |
			distance := (position - possibleBest) abs.
			cost := cost + ((distance * (distance+1))/2)
		].
		cost < bestSoFar ifTrue: [
			bestSoFar := cost.
			bestPosition := possibleBest ]
	].
	^ bestSoFar
]
