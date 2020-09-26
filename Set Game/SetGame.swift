//
//  SetGame.swift
//  SetGame
//
//  Created by Leozítor Floro on 02/08/20.
//

import Foundation

struct SetGame<Features> {
    private(set) var deck: Array<Card>
    private(set) var dealtCards: Array<Card>
    private(set) var selectedCardIds: Set<Int>
    private(set) var score: Int
    private(set) var setsFound: Int
    
    mutating func choose(card: Card) {
        print("card chosen: id:\(card.id) selected: \(card.isSelected) \(card.features)")
        if let chosenIndex = dealtCards.firstIndex(matching: card) {
            if dealtCards[chosenIndex].isSelected {
                dealtCards[chosenIndex].isSelected = false
                selectedCardIds.remove(chosenIndex)
            } else {
                selectedCardIds.insert(chosenIndex)
                dealtCards[chosenIndex].isSelected = true
            }
            if selectedCardIds.count == 3 {
                
                dealtCards[chosenIndex].
                
                //verifyPlay(selectedCardIds) // TERMINAR O VERIFY PLAY AQUI
                while !selectedCardIds.isEmpty {
                    if let cardIndex = selectedCardIds.popFirst() {
                        
                        dealtCards[cardIndex].isSelected = false
                    }
                }
            }
        }
    }
    
   
    init(numberOfCards: Int, cardContentFactory: (Int) -> Features) {
        deck = Array<Card>()
        dealtCards = Array<Card>()
        selectedCardIds = Set<Int>()
        score = 0
        setsFound = 0
        for cardIndex in 0..<numberOfCards {
            deck.append(Card(features: cardContentFactory(cardIndex), id: cardIndex))
        }
        deck.shuffle()
        for _ in  0..<12 {
            dealtCards.append(deck.removeFirst())
        }
    }
    
    struct Card: Identifiable {
        var features: Features
        var isSelected: Bool = false
        var isMatched: Bool = false
        var id: Int
    }
}
