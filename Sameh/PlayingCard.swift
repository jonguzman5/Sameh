//
//  PlayingCard.swift
//  Sameh
//
//  Created by ジョナサン on 12/10/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {

    var description: String {
        return "\(rank)\(suit)"
    }
    
    var suit: Suit
    var rank: Rank
    
    
    enum Suit: String, CustomStringConvertible {
        case clubs    = "♣️"
        case diamonds = "♦️"
        case hearts   = "❤️"
        case spades   = "♠️"
        
        var description: String {
            return self.rawValue
        }
        
        static var all = [Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs]
    }
    
    enum Rank: CustomStringConvertible {
        case ace
        case numeric(Int)
        case face(String)
        
        var description: String {
            switch self {
            case .ace: return "A"
            case .numeric(let pips): return (String(pips))
            case .face(let kind): return kind
            }
        }
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]
            
            return allRanks
        }

    }
    
    
}

