//
//  CardGame.swift
//  Sameh
//
//  Created by ジョナサン on 12/10/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import Foundation

class CardGame {
    
    var playingCardDeckView = PlayingCardDeckView()
    
    var availableCards = PlayingCardDeck()
    var cardsInHand = PlayingCardDeck()
    
    var cpuScore = 0;
    var playerScore = 0;
    var playerMoney = 100;
    var playerBet = 0;
    
    func getCards(noOfCards: Int) -> [PlayingCard]{
        var cards = [PlayingCard]()
        for _ in 0..<noOfCards {
            let card = availableCards.draw()!
            cards.append(card)
        }
        return cards
    }
    
    func computeScore(){
        
    }
    
    
}
