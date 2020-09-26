//
//  Shapes.swift
//  SetGame
//
//  Created by Leozítor Floro on 09/08/20.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let bigSide = rect.width
        let smallSide = rect.height
        let upPoint = CGPoint(
            x: center.x,
            y: center.y + ( smallSide / 2 )
        )
        let rightPoint = CGPoint(
            x: center.x + ( bigSide / 2 ),
            y: center.y
        )
        let downPoint = CGPoint(
            x: center.x,
            y: center.y - ( smallSide / 2 )
        )
        let leftPoint = CGPoint(
            x: center.x - ( bigSide / 2 ),
            y: center.y
        )
        
        var p = Path()
        p.move(to: upPoint)
        p.addLine(to: rightPoint)
        p.move(to: rightPoint)
        p.addLine(to: downPoint)
        p.move(to: downPoint)
        p.addLine(to: leftPoint)
        p.move(to: leftPoint)
        p.addLine(to: upPoint)
        return p
    }
}
