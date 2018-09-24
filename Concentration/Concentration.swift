//
//  Concentration.swift
//  Concentration
//
//  Created by Ryan Ming on 2018-09-22.
//  Copyright © 2018 Ryan Ming. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var themeIndex = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var alreadySeen = [Int]()
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += 2
                } else {
                    // they don't match
                    
                    if !alreadySeen.contains(index) {
                        alreadySeen.append(index)
                    } else {
                        score -= 1
                    }
                    
                    if !alreadySeen.contains(matchIndex) {
                        alreadySeen.append(matchIndex)
                    } else {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards  or 2 cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func reset() {
        for index in cards.indices {
            cards[index].reset()
        }
        
        cards.shuffle()
        
        // TODO: reset move count
        
        score = 0
        flipCount = 0
    }
    
    init(numberOfPairsOfCards: Int, numberOfThemes: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
        themeIndex = Int(arc4random_uniform(UInt32(numberOfThemes)))
    }
}
