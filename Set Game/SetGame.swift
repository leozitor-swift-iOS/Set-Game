//
//  SetGame.swift
//  SetGame
//
//  Created by Leozítor Floro on 02/08/20.
//

import Foundation

struct SetGame<Features> where Features: FeaturesProtocol {
    private(set) var deck: Array<Card>
    private(set) var dealtCards: Array<Card>
    private(set) var score: Int
    private(set) var setsFound: Int
    
    private(set) var isMatched : Bool = false
    
    //currently selected cards
    private var selectedCards: [Card] {
        dealtCards.filter() { $0.isSelected } //filtering from dealt cards only the selected ones
    }
    // currently is cards matched
    private var matchedCards: [Card] {
        dealtCards.filter() { $0.isMatch != 0 } //filtering from dealt cards only the selected ones
    }
    
    var isGameFinished : Bool {
        setsFound == 27
    }
    
    mutating func choose(card: Card) {
        print("card chosen: id:\(card.id) selected: \(card.isSelected) matched: \(card.isMatch) \(card.features)")
        if isMatched {
            isMatched.toggle()
            throwAwayCards()
            dealCards(numberOfCards: 3)
        }
        if selectedCards.count > 2 {
            unMatchCards()
            unSelectCards()
        }
        if let chosenIndex = dealtCards.firstIndex(matching: card) {
            dealtCards[chosenIndex].isSelected.toggle()
        }
        if selectedCards.count == 3 {
            isMatched = ifIsSet(card1: selectedCards[0], card2: selectedCards[1], card3: selectedCards[2])
            if isMatched {
                setsFound += 1
                score += 1
                for selectedCard in selectedCards {
                    if let cardIndex = dealtCards.firstIndex(matching: selectedCard) {
                        dealtCards[cardIndex].isMatch =  2
                    }
                }
            } else {
                for selectedCard in selectedCards {
                    if let cardIndex = dealtCards.firstIndex(matching: selectedCard) {
                        dealtCards[cardIndex].isMatch =  1
                    }
                }
            }
        }
    }
    
    private func ifIsSet(card1:Card, card2: Card, card3:Card) -> Bool {
        let numbers = [card1.features.number, card2.features.number, card3.features.number]
        let colors = [card1.features.color, card2.features.color, card3.features.color]
        let shapes = [card1.features.shape, card2.features.shape, card3.features.shape]
        let shades = [card1.features.shading, card2.features.shading, card3.features.shading]
        
        return allItemsEqualOrDiff(items: numbers) && allItemsEqualOrDiff(items: colors)
            && allItemsEqualOrDiff(items: shapes) && allItemsEqualOrDiff(items: shades)
    }
    
    private func allItemsEqualOrDiff<T: Hashable>(items:[T]) -> Bool {
        return Set(items).count == 1 || Set(items).count == 3
    }
    
    private mutating func unSelectCards() {
        for card in selectedCards {
            if let cardIndex = dealtCards.firstIndex(of: card) {
                dealtCards[cardIndex].isSelected = false
            }
        }
    }
    
    private mutating func unMatchCards() {
        for card in matchedCards {
            if let cardIndex = dealtCards.firstIndex(of: card) {
                dealtCards[cardIndex].isMatch = 0
            }
        }
    }
    
    private mutating func throwAwayCards(){
        for card in matchedCards {
            if let cardIndex = dealtCards.firstIndex(of: card) {
                dealtCards.remove(at: cardIndex)
            }
        }
    }
    mutating func dealCards(numberOfCards: Int){
        if isMatched {
            isMatched.toggle()
            throwAwayCards()
        }
        for _ in 0..<numberOfCards {
            dealtCards.append(deck.removeLast())
        }
    }
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> Features) {
        deck = Array<Card>()
        dealtCards = Array<Card>()
        score = 0
        setsFound = 0
        for cardIndex in 0..<numberOfCards {
            deck.append(Card(features: cardContentFactory(cardIndex), id: cardIndex))
        }
        deck.shuffle()
        //dealCards(numberOfCards: 12)
        //dealtCards.append(deck.remove(at: 0))
        //dealtCards.append(deck.remove(at: 26))
        //dealtCards.append(deck.remove(at: 52))
        //dealCards(numberOfCards: 9)

    }
    
    struct Card: Identifiable, Equatable {
        var features: Features
        var isSelected: Bool = false
        var isMatch: Int = 0
        var id: Int
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            lhs.id == rhs.id
        }
    }
}
