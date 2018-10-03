import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    static var identifierFactory = -1
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
}
