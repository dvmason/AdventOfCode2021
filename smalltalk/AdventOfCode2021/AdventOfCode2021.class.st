"
This class contains the main code for the 2021 version of the [Advent of Code](https://adventofcode.com/2021)
"
Class {
	#name : #AdventOfCode2021,
	#superclass : #Object,
	#instVars : [
		'points'
	],
	#category : #'AdventOfCode2021-Core'
}

{ #category : #updating }
AdventOfCode2021 >> addPoint: aPoint [ 
	points at: aPoint ifPresent: [: currentValue | points at: aPoint put: currentValue + 1 ] ifAbsentPut:  1
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
AdventOfCode2021 >> day09: aString [
   | prevRow allRows |
   allRows := OrderedCollection new.
   prevRow := OrderedCollection new.
   aString lines do: [:line | 
      | cell prevCell currRow |
      prevCell := nil.
      currRow := OrderedCollection new.
      allRows add: currRow.
      line withIndexDo: [:char :index | 
         cell := MapCell new height: char asString asNumber.
         currRow add: cell.
         cell west: prevCell.
         prevCell east: cell.
         prevCell := cell.
         prevRow size < currRow size ifTrue: [prevRow add: nil].
         (prevRow at: index) south: cell.
         cell north: (prevRow at: index)
         ].
      prevRow := currRow
      ].
   ^ allRows
]

{ #category : #'day problem' }
AdventOfCode2021 >> day09a: aString [
   | allRows riskSum |
   allRows := self day09: aString.
   riskSum := 0.
   allRows do: [:row | 
      row do: [:cell | 
         cell isLowPoint ifTrue: [riskSum := riskSum + cell riskLevel]]].
   ^ riskSum
]

{ #category : #'day problem' }
AdventOfCode2021 >> day09b: aString [
   | allRows basins basinSize |
   allRows := self day09: aString.
   basins := Set new.
   allRows do: [:row | row do: [:cell | basins add: cell basin]].
basinSize := 1.
   ((basins asArray sort: [:l :r | l basinSize >= r basinSize]) first: 3) 
      do: [:basin | basinSize := basinSize * basin basinSize].
   ^ basinSize
]
