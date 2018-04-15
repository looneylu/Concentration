//
//  Concentration.swift
//  Concentration
//
//  Created by Luis Carbuccia on 4/14/18.
//  Copyright © 2018 Luis Carbuccia. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]() //Array<Card>()
    private var score = 0;
    private var flipCount = 0;
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    func getScore() -> Int {
        return score
    }
    
    private(set) var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set(newValue){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        flipCount += 1
        
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")

        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        shuffleCards()
    }
    
    private func shuffleCards(){
        var currentIndex = cards.count
        
        //while there are elements to "shuffle"...
        while currentIndex != 0{
            //pick a remaining element
            let randomIndex = Int (arc4random_uniform(UInt32(currentIndex)))
            currentIndex -= 1
            
            //swap with current element
            let tempValue = cards[currentIndex]
            cards[currentIndex] = cards[randomIndex]
            cards[randomIndex] = tempValue
        }
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
