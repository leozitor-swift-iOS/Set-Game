//
//  Features.swift
//  SetGame
//
//  Created by Leozítor Floro on 07/08/20.
//

import Foundation
import SwiftUI

struct Features {
    let number: Number
    let shape: Shape
    let color: Color
    let shading: Shading
    

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
