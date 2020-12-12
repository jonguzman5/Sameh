//
//  ViewController.swift
//  Sameh
//
//  Created by ジョナサン on 12/10/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let noOfCards = 5
    let initVal = 0
    
    @IBOutlet weak var cpuHandView: PlayingCardDeckView!
    @IBOutlet weak var playerHandView: PlayingCardDeckView!
    var playingCardView: PlayingCardView!
    
    // MARK: CPU UI components
    var cpuHand: [PlayingCardView]! {
        if let hand = cpuHandView { return hand.subviews as? [PlayingCardView] }
        else { return nil }
    }
    @IBOutlet weak var cpuScoreLabel: UILabel!
    var cpuScore = 0 { didSet { cpuScoreLabel.text = "Score: \(cpuScore)" } }
    
    // MARK: Player UI components
    var playerHand: [PlayingCardView]! {
        if let hand = playerHandView { return hand.subviews as? [PlayingCardView] }
        else { return nil }
    }
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerMoneyLabel: UILabel!
    @IBOutlet weak var playerBetLabel: UILabel!
    var playerScore = 0 { didSet { playerScoreLabel.text = "Score: \(playerScore)" } }
    var playerMoney = 100 { didSet { playerMoneyLabel.text = "Money: \(playerMoney)" } }
    var playerBet = 0 { didSet { playerBetLabel.text = "Bet: \(playerBet)" } }
    
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: Initial Setup
    var game = CardGame()
    
    func newGame(){
        game = CardGame()
        cpuScore = game.cpuScore
        playerScore = game.playerScore
        playerMoney = game.playerMoney
        playerBet = game.playerBet
        playerHand.forEach({ $0.removeFromSuperview() })
        cpuHand.forEach({ $0.removeFromSuperview() })
        game.availableCards = PlayingCardDeck()
        addCardsToGame(from: getCardViews(noOfCards: noOfCards), to: cpuHandView)
        addCardsToGame(from: getCardViews(noOfCards: noOfCards), to: playerHandView)
        //cpuHandView.animationHasBeenShown = false
        //playerHandView.animationHasBeenShown = false
    }
    
    override func viewDidLoad() {
        newGame()
        cpuScoreLabel.setBorder()
        playerScoreLabel.setBorder()
        playerMoneyLabel.setBorder()
        playerBetLabel.setBorder()
        dealButton.setBorder()
        betButton.setBorder()
        resetButton.setBorder()
        super.viewDidLoad()
    }
    
    // MARK: Game actions
    func getCardViews(noOfCards: Int) -> [PlayingCardView] {
        var playingCardViews = [PlayingCardView]()
        let cards = game.getCards(noOfCards: noOfCards)
        game.cardsInHand.cards.append(contentsOf: cards)
        for index in 0..<noOfCards {
            playingCardView = PlayingCardView()
            playingCardView.rank = cards[index].rank.order
            playingCardView.suit = cards[index].suit.rawValue
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.tradeCard(_:)))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            playingCardViews.append(playingCardView)
        }
        return playingCardViews
    }
    
    func addCardsToGame(from cardViews: [PlayingCardView], to handView: PlayingCardDeckView){
        for cardView in cardViews {
            handView.addSubview(cardView)
        }
    }
    
    @objc func tradeCard(_ sender: UITapGestureRecognizer){
        let card = sender.view as! PlayingCardView
        if game.playerMoney >= 5 {
            if let dealtCard = game.availableCards.draw(){
                card.rank = dealtCard.rank.order
                card.suit = dealtCard.suit.rawValue
            }
            game.playerMoney -= 5
            playerMoney = game.playerMoney
        }
    }
    
    @IBAction func deal(_ sender: Any) {
        let dealButton = sender as! UIButton
        if game.playerBet > 0 {
            dealButton.isEnabled = true
            for index in playerHand.indices {
                if let dealtCard = game.availableCards.draw(){
                    playerHand[index].rank = dealtCard.rank.order
                    playerHand[index].suit = dealtCard.suit.rawValue
                }
            }
        }
    }
    
    @IBAction func bet(_ sender: Any) {
        if(game.playerMoney > 0){
            game.playerBet += 1
            playerBet = game.playerBet
            game.playerMoney -= 1
            playerMoney = game.playerMoney
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        newGame()
    }
    
}

// MARK: Extensions
extension CGFloat {
    var arc4random: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
    }
}

extension UILabel {
    func setBorder(){
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 3.0
    }
}

extension UIButton {
    func setBorder(){
        self.layer.borderWidth = 6.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 6.0
    }
}
