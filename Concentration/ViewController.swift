import UIKit

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiChoices = ["🌚", "✈️", "🏙", "🐓", "🐳", "🐙"]
    
    private var emoji = [Int : String]()
    
    private (set) var flipCard = 0 {
        didSet {
            flipCountLabel.text = String(flipCard)
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCard += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    /**
     Returns emoji that card contains. If card does not contain emoji, it get random emoji from emojiChoices.
    */
    private func emoji(for card : Card) -> String {
        let cardId = card.identifier
        let emojiCount = emojiChoices.count
        if emoji[cardId] == nil, emojiCount > 0 {
            emoji[cardId] = emojiChoices.remove(at: emojiCount.arc4random)
        }
        return emoji[cardId] ?? "?"
    }
    
    private func updateViewFromModel() {
        for i in cardButtons.indices {
            let button = cardButtons[i]
            let card = game.cards[i]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle(nil, for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.2785325944, green: 0.399879247, blue: 1, alpha: 1)
            }
        }
    }
}

