//
//  Theme.swift
//  Concentration
//
//  Created by Luis Carbuccia on 4/14/18.
//  Copyright © 2018 Luis Carbuccia. All rights reserved.
//

import Foundation

class ThemeOptions{
    private let maskEmojis: Array<String> = ["👻", "🎃", "👿", "👹", "💀", "🤡"]
    private let faceEmojis: Array<String> = ["😀", "😇", "😍", "😎", "😡", "🤯"]
    private let animalEmojis: Array<String> = ["🐶", "🐹", "🦊", "🐼", "🐷", "🐵"]
    private let foodEmojis: Array<String> = ["🍏", "🍊", "🥥", "🍉", "🍞", "🍔"]
    
    private lazy var emojiChoices: Array<Array<String>> = [maskEmojis, faceEmojis, animalEmojis, foodEmojis]
    
    func getEmojiThemeOptions() -> Array<Array<String>> {
        return emojiChoices
    }
}
