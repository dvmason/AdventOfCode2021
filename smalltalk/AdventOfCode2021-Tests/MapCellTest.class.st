Class {
	#name : #MapCellTest,
	#superclass : #TestCase,
	#category : #'AdventOfCode2021-Tests-Tests'
}

{ #category : #tests }
MapCellTest >> testLoad [
   | allRows riskSum |
   allRows := MapCell load: '02
21'.
   riskSum := 0.
   allRows do: [:row | 
      row do: [:cell | 
         cell isLowPoint ifTrue: [riskSum := riskSum + cell riskLevel]]].

   self assert: riskSum equals: 3
]

{ #category : #tests }
MapCellTest >> testSingleCell [
   | cell |
   cell := MapCell new height: 3.
   self assert: cell isLowPoint.
	self assert: cell riskLevel equals: 4
]

{ #category : #tests }
MapCellTest >> testThreeCells [
   | cellL cellM cellR |
   cellL := MapCell new height: 3.
   cellM := MapCell new
               height: 2;
               west: cellL.
   cellR := MapCell new
               height: 4;
               west: cellM.
   cellL east: cellM.
   cellM east: cellR.
   self assert: cellM isLowPoint.
   self deny: cellL isLowPoint.
   self deny: cellR isLowPoint.
	self assert: cellM riskLevel equals: 3.
]
