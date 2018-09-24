import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2, numberOfThemes: emojiThemes.count)

    @IBOutlet weak var moveCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchResetButton(_ sender: UIButton) {
        game.reset()
        updateViewFromModel()
    }
    
//    var emojiChoices = ["🎃", "👻", "🧟‍♀️", "🧛🏻‍♂️", "👽", "🧟‍♂️", "🦇", "🍫"]

    var emojiChoices = [String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        moveCountLabel.text = "Moves: \(game.flipCount)"
    }
    
    var emojiThemes = Dictionary<Int,[String]>()
    var emoji = Dictionary<Int,String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        emojiThemes[0] = ["🎃", "👻", "🧟‍♀️", "🧛🏻‍♂️", "👽", "🧟‍♂️", "🦇", "🍫"]
        
        emojiThemes[1] = ["🦓", "🦒", "🦔", "🦕", "🐀", "🐊", "🐇", "🐆"]
        
        emojiThemes[2] = ["🤾‍♀️", "🏄‍♀️", "🚵‍♀️", "🤽‍♀️", "⛹️‍♀️", "🤾‍♀️", "🏊‍♀️", "🚣‍♀️"]
        
        emojiChoices = emojiThemes[game.themeIndex]!
    }
}

