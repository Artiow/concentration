import Foundation

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

extension MutableCollection {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

struct Concentration {
    
    private (set) var cards = [Card]()
    
    private (set) var flips = 0
    
    private var _score = 0
    private (set) var score: Int! {
        get {
            return _score
        }
        set (newValue) {
            if newValue >= 0 {
                _score = newValue
            }
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter {
                cards[$0].isFaceUp
                }.oneAndOnly
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards : Int) {
        assert((numberOfPairsOfCards > 0), "init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index : Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choosen index not in the cards")
        if !cards[index].isMatched {
            flips = flips + 1
            if let mathIndex = indexOfOneAndOnlyFaceUpCard, mathIndex != index {
                cards[mathIndex].isFaceUp = false
                if cards[mathIndex] != cards[index] {
                    cards[index].isFaceUp = true
                    score = score - 1
                } else {
                    cards[mathIndex].isMatched = true
                    cards[index].isMatched = true
                    score = score + 10
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                score = score - 1
            }
        }
    }
}

