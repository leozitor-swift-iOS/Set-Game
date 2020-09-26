//
//  SetGameView.swift
//  SetGame
//
//  Created by Leozítor Floro on 02/08/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            Grid(viewModel.dealtCards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding(5)
            .foregroundColor(Color.black)
            HStack {
                VStack(alignment: .leading) {
                    Text("Score: \(viewModel.score)")
                        .font(Font.largeTitle.bold())
                    Text("Sets Found: \(viewModel.setsFound) ")
                    Text("Cards Remaining: \(viewModel.remainingCards)")
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) { viewModel.newGame() }
                }, label: {
                    Text("New Game")
                        .font(Font.title.italic())
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }.padding([.horizontal,.bottom], 15)
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct CardView: View {
    var card: SetGame<Features>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        ZStack {
            VStack {
                ForEach(0..<card.features.number.rawValue) {_ in
                    switch card.features.shape {
                    case .diamond:
                        ZStack {
                            Diamond().fill(color).opacity(shading)
                            Diamond().stroke(lineWidth: 1.5)
                        }
                        .aspectRatio(self.aspectRatio, contentMode: .fit)
                    case .oval:
                        ZStack {
                            Capsule().fill(color).opacity(shading)
                            Capsule().stroke(lineWidth: 1.5)
                        }
                        .aspectRatio(self.aspectRatio, contentMode: .fit)
                    case .squiggle:
                        ZStack {
                            RoundedRectangle(cornerRadius: 0.0).fill(color).opacity(shading)
                            RoundedRectangle(cornerRadius: 0.0).stroke(lineWidth: 1.5)
                        }
                        .aspectRatio(self.aspectRatio, contentMode: .fit)
                    }
                }
            }
            .padding(5)
            .foregroundColor(color)
        }
        .cardify(isSelected: card.isSelected)
    }
    
    
    var color: Color {
        switch card.features.color {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .purple:
            return Color.purple
        }
    }
    
    var shading: Double {
        switch(card.features.shading) {
        case .solid:
            return 1.0
        case .striped:
            return 0.3
        case .open:
            return 0.0
        }
    }
    
    // MARK: Drawing constants
    private let aspectRatio: CGFloat = 4 / 2
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return SetGameView(viewModel: game)
    }
}

