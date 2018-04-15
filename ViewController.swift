//
//  ViewController.swift
//  Concentration
//
//  Created by Luis Carbuccia on 4/14/18.
//  Copyright © 2018 Luis Carbuccia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    lazy var emojiThemeChoices:Array<Array<String>> = themes.getEmojiThemeOptions()
    lazy var emojiChoices: Array<String> = emojiThemeChoices[getRandomTheme()]

    var themes = ThemeOptions()
    var emoji = [Int:String] ()//Dictionary<Int, String>()

    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]! //same as saying Array<UIButtons>
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card no in cardButtons")
        }
    }
    
    @IBAction func restartGameButton(_ sender: UIButton) {
        print("restartGameButton pressed")
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = emojiThemeChoices[getRandomTheme()]

        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  UIColor.clear : UIColor.orange
            }
        }
    }
    
    fileprivate func getRandomTheme() -> Int{
        return Int(arc4random_uniform(UInt32(emojiThemeChoices.count)))
    }
    
    fileprivate func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int (arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex);
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

