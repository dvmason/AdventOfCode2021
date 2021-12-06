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
