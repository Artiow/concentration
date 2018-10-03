import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count + 1 / 2)
    
    var emojiChoices = ["🌚", "✈️", "🏙", "🐓", "🐳", "🐙"]
    
    var emoji = [Int : String]()
    
    var flipCard = 0 {
        didSet {
            flipCountLabel.text = String(flipCard)
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func emoji(for card : Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for i in cardButtons.indices {
            let button = cardButtons[i]
            let card = game.cards[i]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.2785325944, green: 0.399879247, blue: 1, alpha: 1)
            }
        }
    }
}

