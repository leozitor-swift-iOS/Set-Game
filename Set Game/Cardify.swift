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
    
    init(isSelected: Bool) {
        rotation = true ? 0 : 180
        self.isSelected = isSelected
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
            if isSelected {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidthSelected)
                    .fill(Color.red)// TODO: improve the color selection
           }
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: edgeLineWidth)
            content
        }.rotation3DEffect(Angle.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 2
    private let edgeLineWidthSelected: CGFloat = 7
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        self.modifier(Cardify(isSelected: isSelected))
    }
}
