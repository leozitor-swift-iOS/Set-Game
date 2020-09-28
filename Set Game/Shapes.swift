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
        let upPoint = CGPoint(
            x: center.x,
            y: rect.maxY
        )
        let rightPoint = CGPoint(
            x: rect.maxX,
            y: center.y
        )
        let downPoint = CGPoint(
            x: center.x,
            y: rect.minY
        )
        let leftPoint = CGPoint(
            x: rect.minX,
            y: center.y
        )
        
        var p = Path()
        p.move(to: upPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: downPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: upPoint)
        return p
    }
}

struct Squiggle : Shape {
    
    func path(in rect : CGRect) -> Path { // rect is the space offered for drawing
        let leftArcStart = CGPoint (x: rect.minX + rect.height/4, y: rect.maxY)
        let leftArcStop = CGPoint (x: rect.minX + 3 * rect.height/4, y: rect.minY)
        let rightArcStart = CGPoint (x: rect.maxX - rect.height/4, y: rect.minY)
        let rightArcStop = CGPoint (x: rect.maxX - 3 * rect.height/4, y: rect.maxY)
        
        var p = Path()        
        // draw Squiggle
        // draw left arc
        p.move(to:leftArcStart)
        p.addCurve(to: leftArcStop, control1: CGPoint(x: rect.minX, y: rect.maxY), control2: CGPoint(x: rect.minX, y: rect.minY))
        //draw upper connection curve
        p.addCurve(to: rightArcStart, control1: CGPoint(x: rect.midX + rect.height/4, y: rect.minY), control2: CGPoint(x: rect.midX+rect.height/4, y: rect.midY))
        // draw right arc
        p.addCurve(to: rightArcStop, control1: CGPoint(x: rect.maxX, y: rect.minY), control2: CGPoint(x: rect.maxX, y: rect.maxY))
        //draw lower connection curve
        p.addCurve(to: leftArcStart, control1: CGPoint(x: rect.midX-rect.height/2, y: rect.midY), control2: CGPoint(x: rect.midX-rect.height/2, y: rect.maxY))
        return p
    }
}
