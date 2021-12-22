"
This class contains the main code for the 2021 version of the [Advent of Code](https://adventofcode.com/2021)
"
Class {
	#name : #AdventOfCode2021,
	#superclass : #Object,
	#instVars : [
		'points'
	],
	#classVars : [
		'ChunkMatch',
		'IllegalCharacter'
	],
	#category : #'AdventOfCode2021-Core'
}

{ #category : #'class initialization' }
AdventOfCode2021 class >> initialize [
   ChunkMatch := { 
                    ($( -> $)).
                    ($[ -> $]).
                    (${ -> $}).
                    ($< -> $>) } asDictionary.
   IllegalCharacter := { 
                          ($) -> 3).
                          ($] -> 57).
                          ($} -> 1197).
                          ($> -> 25137) } asDictionary
]

{ #category : #updating }
AdventOfCode2021 >> addPoint: aPoint [ 
	points at: aPoint ifPresent: [: currentValue | points at: aPoint put: currentValue + 1 ] ifAbsentPut:  1
]

{ #category : #parsing }
AdventOfCode2021 >> correctChunk: aString [ 
	self shouldBeImplemented.
]

{ #category : #'day problem' }
AdventOfCode2021 >> day05: aString nonOrthogonal: aBlock [
   points := Dictionary new.
   aString lines do: [:line | 
      | substrings temp x1 y1 x2 y2 |
      substrings := line substrings.
      temp := substrings first splitOn: $,.
      x1 := temp first asNumber.
      y1 := temp last asNumber.
      temp := substrings last splitOn: $,.
      x2 := temp first asNumber.
      y2 := temp last asNumber.
      x1 = x2 ifTrue: [
         (y1 min: y2) to: (y1 max: y2) do: [:y | self addPoint: x1 @ y]]
         ifFalse: [
            y1 = y2 ifTrue: [
               (x1 min: x2) to: (x1 max: x2) do: [:x | self addPoint: x @ y1]]
               ifFalse: [ aBlock cull: x1 cull: y1 cull: x2 cull: y2 ]
            ]
      ].
   ^ (points values select: [:value | value >= 2]) size
]

{ #category : #'day problem' }
AdventOfCode2021 >> day05a: aString [
   ^ self day05: aString nonOrthogonal: [" ignore "]
]

{ #category : #'day problem' }
AdventOfCode2021 >> day05b: aString [
   ^ self day05: aString nonOrthogonal: [:x1 :y1 :x2 :y2 |
		| y ySign xSign |
		y := y1.
		ySign := (y2-y1) sign.
		xSign := (x2-x1) sign.
		x1 to: x2 by: xSign do: [: x |
			self addPoint: x@y.
			y := y + ySign
			  ]
	]
]

{ #category : #'day problem' }
AdventOfCode2021 >> day08a: aString [ 
	| count |
	count := 0.
	aString lines do: [: line |
		(line substrings last: 4) do: [: segments |
			(segments size = 7 or: [ segments size <= 4 ]) ifTrue: [ count := count + 1 ]
			]
	].
	^ count
]

{ #category : #'day problem' }
AdventOfCode2021 >> day08b: aString [
   | count |
   count := 0.
   aString lines do: [:line | 
      | digits examples fives sixes one two three four five six seven eight nine zero segments |
      examples := line substrings first: 10.
      digits := line substrings last: 4.
      one := examples detect: [:example | example size = 2].
      seven := examples detect: [:example | example size = 3].
      four := examples detect: [:example | example size = 4].
      eight := examples detect: [:example | example size = 7].
      fives := examples select: [:example | example size = 5].
      sixes := examples select: [:example | example size = 6].
      nine := sixes detect: [:each | 
                 (each includesAll: one) and: [each includesAll: four]].
      zero := sixes detect: [:each | 
                 (each includesAll: one) and: [(each includesAll: four) not]].
      six := sixes detect: [:each | 
                each ~= zero and: [each ~= nine]].
      three := fives detect: [:each | each includesAll: one].
      five := fives detect: [:each | six includesAll: each].
      two := fives detect: [:each | each ~= three and: [each ~= five]].
      segments := Dictionary new.
      segments
         at: zero sorted put: 0;
         at: one sorted put: 1;
         at: two sorted put: 2;
         at: three sorted put: 3;
         at: four sorted put: 4;
         at: five sorted put: 5;
         at: six sorted put: 6;
         at: seven sorted put: 7;
         at: eight sorted put: 8;
         at: nine sorted put: 9.
      digits with: #( 1000 100 10 1 )
         do: [:digit :multiplier | 
         count := (segments at: digit sorted) * multiplier + count]
      ].
   ^ count
]

{ #category : #'day problem' }
AdventOfCode2021 >> day09a: aString [
   | allRows riskSum |
   allRows := MapCell load: aString.
   riskSum := 0.
   allRows cellsDo: [:cell | 
         cell isLowPoint ifTrue: [riskSum := riskSum + cell riskLevel]].
   ^ riskSum
]

{ #category : #'day problem' }
AdventOfCode2021 >> day09b: aString [
   | allRows basins basinSize |
   allRows := MapCell load: aString.
   basins := Set new.
   allRows cellsDo: [:cell | basins add: cell basin].
   basinSize := 1.
   ((basins asArray sort: [:l :r | l basinSize >= r basinSize]) first: 3) do: [
      :basin | basinSize := basinSize * basin basinSize].
   ^ basinSize
]

{ #category : #'day problem' }
AdventOfCode2021 >> day10a: aString [
   | count |
   count := 0.
   aString linesDo: [:line | 
      | result |
      result := self parseChunk: line.
      count := count
               +
               (result isNumber ifTrue: [ result ] ifFalse: [0])
      ].
   ^ count
]

{ #category : #'day problem' }
AdventOfCode2021 >> day13a: aString [ 
	points := 
	(aString lines collect: #asPoint thenSelect: #notNil) asSet.
	^ (points foldAOC: (aString lines select: #foldAlong) first) size
]

{ #category : #'day problem' }
AdventOfCode2021 >> day13b: aString [
   points := (aString lines collect: #asPoint thenSelect: #notNil) asSet.
   (aString lines select: #foldAlong) do: [: foldInstruction |
			points foldAOC: foldInstruction ].
		^ points formatAOC
]

{ #category : #'day problem' }
AdventOfCode2021 >> day14a: aString [
   | pairInsertions template counts |
   pairInsertions := Dictionary new.
   aString lines do: [:line | 
      | substrings |
      substrings := line substrings.
      substrings size = 3 ifTrue: [
         pairInsertions at: substrings first put: substrings last first].
      substrings size = 1 ifTrue: [template := substrings first]
      ].
   10 timesRepeat: [
      | previous |
      previous := nil.
      template := String streamContents: [:stream | 
                     template do: [:char | 
                        previous ifNotNil: [
                           pairInsertions at: (String with: previous with: char)
                              ifPresent: [:insertChar | 
                              stream nextPut: insertChar]
                           ].
                        stream nextPut: char.
                        previous := char
                        ]
                     ]
      ].
   counts := template asBag valuesAndCounts.
   ^ counts max - counts min
]

{ #category : #'day problem' }
AdventOfCode2021 >> day14b: aString repeat: repeatTimes [
   | pairInsertions template counts |
   pairInsertions := Dictionary new.
   aString lines do: [:line | 
      | substrings |
      substrings := line substrings.
      substrings size = 3 ifTrue: [
         pairInsertions at: substrings first put: substrings last first].
      substrings size = 1 ifTrue: [template := substrings first]
      ].
   repeatTimes timesRepeat: [
	" this algorithm doesn't work because with 40 repetitions, the string grows to trillions of characters "
      | previous |
      previous := nil.
      template := String streamContents: [:stream | 
                     template do: [:char | 
                        previous ifNotNil: [
                           pairInsertions at: (String with: previous with: char)
                              ifPresent: [:insertChar | 
                              stream nextPut: insertChar]
                           ].
                        stream nextPut: char.
                        previous := char
                        ]
                     ]
      ].
   counts := template asBag valuesAndCounts.
   ^ counts max - counts min
]

{ #category : #parsing }
AdventOfCode2021 >> parseChunk: aString [ 
	| match result |
	aString ifEmpty: [ ^ '' ].
	match := ChunkMatch at: aString first ifAbsent: [ ^ aString ].
	result := self parseChunk: aString allButFirst.
	result isString ifFalse: [ ^ result ].
	result ifEmpty: [ ^ '' ].
	result first = match ifFalse: [ ^ IllegalCharacter at: result first].
	^ self parseChunk: result allButFirst
]
