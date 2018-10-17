import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    private static var identifierFactory = -1
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
