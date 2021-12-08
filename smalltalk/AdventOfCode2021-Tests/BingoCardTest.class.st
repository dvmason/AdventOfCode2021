Class {
	#name : #BingoCardTest,
	#superclass : #TestCase,
	#instVars : [
		'card'
	],
	#category : #'AdventOfCode2021-Tests-Tests'
}

{ #category : #running }
BingoCardTest >> setUp [
	super setUp.
	
		card := BingoCard new.
	card add: #(1 2 3 4 5);add: #(6 7 8 9 10);add: #(11 12 13 14 15);add: #(16 17 18 19 20);add: #(21 22 23 24 25)
]

{ #category : #tests }
BingoCardTest >> testCount [
   self
      assert: card count equals: (1 to: 25) sum;
      deny: (card mark: 5);
      assert: card count equals: (1 to: 25) sum - 5;
assert: card score equals: nil;
      deny: (card mark: 1);
      deny: (card mark: 2);
      deny: (card mark: 3);
      assert: (card mark: 4);
      assert: card count equals: (1 to: 25) sum - 15;
	assert: card score equals: 1240
]

{ #category : #tests }
BingoCardTest >> testCountByColumn [
   self
      assert: card count equals: (1 to: 25) sum;
      deny: (card mark: 8);
      assert: card count equals: (1 to: 25) sum - 8;
      deny: (card mark: 3);
      deny: (card mark: 13);
      deny: (card mark: 18);
      assert: (card mark: 23);
      assert: card count equals: 260
]
