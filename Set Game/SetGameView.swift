//
//  SetGameView.swift
//  SetGame
//
//  Created by Leozítor Floro on 02/08/20.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    // creating a random spot out of which cards fly in/out
    private var randomOffset: CGSize {
        let signs: [CGFloat] = [-1, 1]
        let size = UIScreen.main.bounds.size
        let width = (.random(in: 2 * 0..<size.width) + size.width) * signs.randomElement()!
        let height = (.random(in: 2 * 0..<size.height) + size.height) * signs.randomElement()!
        return CGSize(width: width, height: height)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(viewModel.score)")
                    .font(Font.largeTitle.bold())
                Spacer()
                VStack(alignment: .leading) {
                    Text("Sets Found: \(viewModel.setsFound) ")
                    Text("Cards Remaining: \(viewModel.remainingCards)")
                }
            }.padding(.horizontal, 20)
            Divider()
            if viewModel.isGameFinished {
                Text("Congratulations!")
                    .font(.title)
            } else {
                Grid(viewModel.dealtCards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation() {
                            viewModel.choose(card: card)
                        }
                    }.padding(5)
                    .transition(.offset(randomOffset))
                }.padding(5)
                .foregroundColor(Color.black)
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 2)) {
                        viewModel.newGame()
                    }
                })
            }
            HStack {
                Button(action: {
                    withAnimation(.linear(duration: 0.5)) { viewModel.dealCards() }
                }, label: {
                    Text("Deal 3 Cards")
                        .font(.headline)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }).disabled(viewModel.deckEmpty)
                Spacer()
                Button(action: {
                    withAnimation(.linear(duration: 0.5)) { viewModel.newGame() }
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
        VStack {
            ForEach(0..<card.features.number.rawValue) {_ in
                switch card.features.shape {
                case .diamond:
                    ZStack {
                        Diamond().fill(Color.white)
                        Diamond().fill(color).opacity(shading) //TODO: DEBUG HERE THE COLOR
                        Diamond().stroke(lineWidth: 1.5)
                    }
                case .oval:
                    ZStack {
                        Capsule().fill(Color.white)
                        Capsule().fill(color).opacity(shading)
                        Capsule().stroke(lineWidth: 1.5)
                    }
                case .squiggle:
                    ZStack {
                        Squiggle().fill(Color.white)
                        Squiggle().fill(color).opacity(shading)
                        Squiggle().stroke(lineWidth: 1.5)
                    }
                }
            }.aspectRatio(self.aspectRatio, contentMode: .fit)
            .foregroundColor(color)
        }.cardify(isSelected: card.isSelected, isMatch: card.isMatch)
    }
        
    
    var color: Color {
        switch card.features.color {
        case .red:
            return Color.pink
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
    private let aspectRatio: CGFloat = 2.5 / 1
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return SetGameView(viewModel: game)
    }
}

