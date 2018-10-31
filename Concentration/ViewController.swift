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
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIView!
    
    @IBAction func newGameHandler(_ sender: UIButton) {
        game.startNewGame(with: numberOfPairsOfCards)
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
        updateViewFromModel()
    }
    
    
    private var emojiThemes = [
        ["😄", "😁", "😆", "😅", "🤣", "😊", "🙂", "🙃", "😋", "🤨"],
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐮", "🐷"],
        ["🌗", "🌘", "🌚", "🌑", "🌒", "🌓", "🌔", "🌝", "🌕", "🌖"],
        ["☀️", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨"],
        ["🍏", "🍎", "🍐", "🍊", "🍋", "🍓", "🍈", "🍑", "🍅", "🥔"]
    ]
    
    private var emojiChoices = [String]()
    
    private var emoji = [Card : String]()
    
    private (set) var flips = 0 {
        didSet {
            flipCountLabel.text = String(flips)
        }
    }
    
    private (set) var score = 0 {
        didSet {
            scoreCountLabel.text = String(score)
        }
    }
    
    /**
     Called if view did load.
     */
    override func viewDidLoad() {
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
        super.viewDidLoad()
    }
    
    /**
     Choose card and update view.
     */
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    /**
     Returns emoji that card contains. If card does not contain emoji, it get random emoji from emojiChoices.
    */
    private func emoji(for card : Card) -> String {
        let emojiCount = emojiChoices.count
        if emoji[card] == nil, emojiCount > 0 {
            emoji[card] = emojiChoices.remove(at: emojiCount.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        flips = game.flips
        score = game.score
        for i in cardButtons.indices {
            let card = game.cards[i]
            let button = cardButtons[i]
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

