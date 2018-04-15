//
//  ViewController.swift
//  Concentration
//
//  Created by Luis Carbuccia on 4/14/18.
//  Copyright © 2018 Luis Carbuccia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private lazy var emojiThemeChoices:Array<Array<String>> = themes.getEmojiThemeOptions()
    private lazy var emojiChoices: Array<String> = emojiThemeChoices[getRandomTheme()]

    private var numberOfPairsOfCards: Int{
        return ((cardButtons.count + 1) / 2) 
    }
    private var themes = ThemeOptions()
    private var emoji = [Int:String] ()//Dictionary<Int, String>()

    private(set) var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]! //same as saying Array<UIButtons>
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            print("cardNumber = \(cardNumber)")
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card no in cardButtons")
        }
    }
    
    @IBAction private func restartGameButton(_ sender: UIButton) {
        print("restartGameButton pressed")
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = emojiThemeChoices[getRandomTheme()]

        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        print("Score: \(score)")
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
    
    private func getRandomTheme() -> Int{
        return emojiThemeChoices.count.arc4random
    }
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex);
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random:Int{
        if (self > 0){
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

