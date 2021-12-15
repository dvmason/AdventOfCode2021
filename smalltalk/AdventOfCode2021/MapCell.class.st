"
I represent cells in the Height map for Day 09
"
Class {
	#name : #MapCell,
	#superclass : #Object,
	#instVars : [
		'height',
		'north',
		'south',
		'east',
		'west'
	],
	#category : #'AdventOfCode2021-Support'
}

{ #category : #actions }
MapCell class >> load: aString [
   | prevRow allRows |
   allRows := OrderedCollection new.
   prevRow := OrderedCollection new.
   aString lines do: [:line | 
      | cell prevCell currRow |
      prevCell := nil.
      currRow := OrderedCollection new.
      allRows add: currRow.
      line withIndexDo: [:char :index | 
         cell := self new height: char asString asNumber.
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

{ #category : #calculating }
MapCell >> basin [
   ^ self basinIgnoring: (Set new add: nil;yourself)
]

{ #category : #calculating }
MapCell >> basinIgnoring: ignoreCollection [ 
		height = 9 ifTrue: [ ^ nil ].
	self isLowPoint ifTrue: [ ^ self ].
			ignoreCollection add: self.
	{ north . south . east . west } do: [: neighbour |
		(ignoreCollection includes: neighbour) ifFalse: [ ^ neighbour basinIgnoring: ignoreCollection ]
	].
	self error: 'Didn''t find a basin'
]

{ #category : #calculating }
MapCell >> basinSize [
   ^ (self basinSize: Set new) size
]

{ #category : #calculating }
MapCell >> basinSize: cells [
   height = 9 ifTrue: [^ cells].
	(cells includes: self) ifTrue: [ ^ cells ].
   cells add: self.
   { 
      north.
      south.
      east.
      west } do: [:neighbour | 
      neighbour basinSize: cells].
   ^ cells
]

{ #category : #accessing }
MapCell >> east: aMapCell [ 
	east := aMapCell
]

{ #category : #accessing }
MapCell >> height [
	^ height
]

{ #category : #accessing }
MapCell >> height: anInteger [ 
	height := anInteger
]

{ #category : #testing }
MapCell >> isLowPoint [
	^ height < north height and: [ height < south height and: [height < east height and: [ height < west height ] ] ]
]

{ #category : #accessing }
MapCell >> north: anUndefinedObject [ 
	north := anUndefinedObject
]

{ #category : #accessing }
MapCell >> riskLevel [
	^ height + 1
]

{ #category : #accessing }
MapCell >> south: aMapCell [ 
	south := aMapCell
]

{ #category : #accessing }
MapCell >> west: aMapCell [ 
	west := aMapCell
]
