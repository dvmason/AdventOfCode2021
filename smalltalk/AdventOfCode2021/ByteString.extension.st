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
