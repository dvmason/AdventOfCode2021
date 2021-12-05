"
I implement a very simple Bingo card for use in Advent Of Code 2021
"
Class {
	#name : #BingoCard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'unmarked',
		'score'
	],
	#category : #'AdventOfCode2021-Support'
}

{ #category : #initialization }
BingoCard >> add: aCollection [ 
	cells addAll: aCollection.
	unmarked addAll: aCollection.
]

{ #category : #accessing }
BingoCard >> count [
	^ unmarked sum
]

{ #category : #testing }
BingoCard >> fullColumn: column [
   column to: column + 20 by: 5 do: [:index | 
   (unmarked includes: (cells at: index)) ifTrue: [^ false]
].
   ^ true
]

{ #category : #testing }
BingoCard >> fullRow: row [ 
	| rowBase |
	rowBase := (row - 1)*5+1.
	rowBase to: rowBase + 4 do: [: index |
		(unmarked includes: (cells at: index)) ifTrue: [ ^ false ]
	].
	^ true
]

{ #category : #initialization }
BingoCard >> initialize [
	super initialize.
	cells := OrderedCollection new.
	unmarked := Set new.

]

{ #category : #updating }
BingoCard >> mark: anInteger [
   (unmarked includes: anInteger) ifFalse: [^ false].
   unmarked remove: anInteger.
   1 to: 5 do: [:index | 
      (self fullRow: index) ifTrue: [ score := anInteger * self count. ^ true].
      (self fullColumn: index) ifTrue: [ score := anInteger * self count. ^ true]
      ].
   ^ false
]

{ #category : #accessing }
BingoCard >> score [
	^ score
]
