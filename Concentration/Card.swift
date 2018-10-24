import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
    private static var identifierFactory = -1
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
