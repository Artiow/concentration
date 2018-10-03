import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards : Int ) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
    }
    
    func chooseCard(at index : Int) {
        if !cards[index].isMatched {
            if let mathIndex = indexOfOneAndOnlyFaceUpCard,
                mathIndex != index {
                if cards[mathIndex].identifier == cards[index].identifier {
                    cards[mathIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
