//
//  Cardify.swift
//  Memorize
//
//  Created by Leozítor Floro on 12/07/20.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    var isSelected: Bool
    var isMatch: Int
    
    init(isSelected: Bool, isMatch: Int) {
        rotation = true ? 0 : 180
        self.isSelected = isSelected
        self.isMatch = isMatch
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation}
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack{
            if isMatch == 1 {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.gray).opacity(0.7)
            } else if isMatch == 2 {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.green).opacity(0.7)
            } else if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidthSelected)
                    .fill(Color.red)// TODO: improve the color selection
            }
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: edgeLineWidth)
            content.padding(.vertical, 5)
        }.rotation3DEffect(Angle.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 2
    private let edgeLineWidthSelected: CGFloat = 5
}

extension View {
    func cardify(isSelected: Bool, isMatch: Int) -> some View {
        self.modifier(Cardify(isSelected: isSelected, isMatch: isMatch))
    }
}
