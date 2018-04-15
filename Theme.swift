//
//  Theme.swift
//  Concentration
//
//  Created by Luis Carbuccia on 4/14/18.
//  Copyright © 2018 Luis Carbuccia. All rights reserved.
//

import Foundation

class ThemeOptions{
    fileprivate let maskEmojis: Array<String> = ["👻", "🎃", "👿", "👹", "💀", "🤡"]
    fileprivate let faceEmojis: Array<String> = ["😀", "😇", "😍", "😎", "😡", "🤯"]
    fileprivate let animalEmojis: Array<String> = ["🐶", "🐹", "🦊", "🐼", "🐷", "🐵"]
    fileprivate let foodEmojis: Array<String> = ["🍏", "🍊", "🥥", "🍉", "🍞", "🍔"]
    
    fileprivate lazy var emojiChoices: Array<Array<String>> = [maskEmojis, faceEmojis, animalEmojis, foodEmojis]
    
    func getEmojiThemeOptions() -> Array<Array<String>> {
        return emojiChoices
    }
}
