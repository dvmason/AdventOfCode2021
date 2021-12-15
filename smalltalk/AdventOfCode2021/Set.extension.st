Extension { #name : #Set }

{ #category : #'*AdventOfCode2021' }
Set >> foldAOC: aString [
   | parts coordinate fold highPoints |
   parts := $= split: aString substrings last.
   coordinate := parts first asSymbol.
   fold := parts last asNumber.
   highPoints := self select: [:point | (point perform: coordinate) > fold].
   highPoints do: [:point | 
      self remove: point.
      self add: (coordinate = #x ifTrue: [fold * 2 - point x @ point y]
             ifFalse: [point x @ (fold * 2 - point y)])
      ]
]
