//
//  Features.swift
//  SetGame
//
//  Created by Leozítor Floro on 07/08/20.
//

import Foundation
import SwiftUI

struct Features: FeaturesProtocol {
    
    var number: Number
    var shape: Shape
    var color: Color
    var shading: Shading
    

    enum Number: Int, CaseIterable {
        case one = 1
        case two
        case three
    }
    
    enum Shape: CaseIterable {
        case diamond
        case squiggle
        case oval
    }
    
    enum Color: CaseIterable {
        case red
        case green
        case purple
    }
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
}

protocol FeaturesProtocol {
    var number: Features.Number { get set }
    var shape: Features.Shape { get set }
    var color: Features.Color { get set }
    var shading: Features.Shading { get set }
}
