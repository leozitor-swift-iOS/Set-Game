//
//  SetGameViewModel.swift
//  SetGameViewModel
//
//  Created by Leozítor Floro on 02/08/20.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var model: SetGame<Features> = SetGameViewModel.createSetGame()
    
    private static func createSetGame() -> SetGame<Features> {
        var features = [Features]()
        for number in Features.Number.allCases {
            for shape in Features.Shape.allCases {
                for color in Features.Color.allCases {
                    for shading in Features.Shading.allCases {
                        features.append(Features(number: number, shape: shape, color: color, shading: shading))
                    }
                }
            }
        }
        let numberOfCards = features.count
            let game = SetGame<Features>(numberOfCards: numberOfCards) { cardIndex in
                features[cardIndex]
            }
        
        return game
    }
    
    // MARK: - Access to the Model
    var deck: Array<SetGame<Features>.Card> {
        model.deck
    }
    var dealtCards: Array<SetGame<Features>.Card> {
        model.dealtCards
    }
    var score: Int {
        model.score
    }
    var setsFound: Int {
        model.setsFound
    }
    var remainingCards: Int {
        model.deck.count
    }
    var deckEmpty: Bool {
        model.deck.count == 0
    }
    var isGameFinished: Bool {
        model.isGameFinished
    }
    // MARK: - Intent(s)
    // things the view can do to change the model
    func choose(card: SetGame<Features>.Card) {
        withAnimation(.linear(duration: 0.3)){
            model.choose(card: card)
        }
    }
    func newGame() {
        model = SetGameViewModel.createSetGame()
        model.dealCards(numberOfCards: 12)
    }
    func dealCards() {
        model.dealCards(numberOfCards: 3)
    }
}
