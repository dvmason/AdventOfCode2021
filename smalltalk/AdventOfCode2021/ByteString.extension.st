Extension { #name : #ByteString }

{ #category : #'*AdventOfCode2021' }
ByteString >> day02a [
	| command amount horizontal depth |
	horizontal := depth := 0.
	self lines do: [: line |
		command := line substrings first asSymbol.
		amount := line substrings second asInteger.
		command = #forward ifTrue: [ horizontal := horizontal + amount ].
		command = #down ifTrue: [ depth := depth + amount ].
		command = #up ifTrue: [ depth := depth - amount ].
	].
	^ horizontal * depth
]

{ #category : #'*AdventOfCode2021' }
ByteString >> day02b [
   | command amount horizontal depth aim |
   horizontal := depth := aim := 0.
   self lines do: [:line | 
      command := line substrings first asSymbol.
      amount := line substrings second asInteger.
      command = #forward ifTrue: [
				horizontal := horizontal + amount.
				depth := depth + (aim * amount)
			].
      command = #down ifTrue: [aim := aim + amount].
      command = #up ifTrue: [aim := aim - amount]
      ].
   ^ horizontal * depth
]

{ #category : #'*AdventOfCode2021' }
ByteString >> day03a [
	| lines counts gamma epsilon halfPoint |
	lines := self lines.
	counts := nil.
	lines do: [: line |
		counts ifNil: [ counts := Array new: line size withAll: 0 ].
		line withIndexDo: [: char : index |
			char = $1 ifTrue: [ counts at: index put: (counts at: index) + 1 ]
		]
	].
	gamma := epsilon := 0.
	halfPoint := lines size // 2.
	counts do: [: count |
		gamma := gamma + gamma + (count > halfPoint) asBit.
		epsilon := epsilon + epsilon + 1 ].
	epsilon := epsilon - gamma.
	^ gamma * epsilon
]

{ #category : #'*AdventOfCode2021' }
ByteString >> day03b [
	| lines oxygen co2 |
	lines := self lines.
	oxygen := lines day03Filter: 1 for: #most.
	co2 := lines day03Filter: 1 for: #least.
	^ oxygen * co2
]

{ #category : #'*AdventOfCode2021' }
ByteString >> day04Common: successBlock [
   | lines calledNumbers bingoCards currentCard |
   lines := self lines.
   calledNumbers := (lines first splitOn: $,) collect: #asNumber.
   bingoCards := OrderedCollection new.
   currentCard := nil.
   lines allButFirst do: [:line | 
      line ifEmpty: [currentCard := nil] ifNotEmpty: [
         currentCard ifNil: [
            currentCard := BingoCard new.
            bingoCards add: currentCard
            ].
         currentCard add: (line substrings collect: #asNumber)
         ]
      ].
   calledNumbers do: [:calledNumber | 
      bingoCards do: [:card | 
         card score ifNil: [
            (card mark: calledNumber) ifTrue: [
               successBlock value: card
               ]
            ]
         ]
      ].

]

{ #category : #'*AdventOfCode2021' }
ByteString >> day04a [
   self day04Common: [: card | ^ card score].
   ^ #noWinningCard
]

{ #category : #'*AdventOfCode2021' }
ByteString >> day04b [
      | currentCard |
currentCard := nil.
              self day04Common: [: card | currentCard := card ].
   ^ currentCard score
]
