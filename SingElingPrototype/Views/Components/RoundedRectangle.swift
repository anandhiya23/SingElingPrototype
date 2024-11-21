//
//  RoundedRectangle.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI

struct RoundedTriangle: Shape {
    var cornerRadius: CGFloat = 20.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: CGPoint(x: top.x, y: top.y))
        
        path.addArc(
            tangent1End: top,
            tangent2End: bottomLeft,
            radius: cornerRadius
        )

        path.addArc(
            tangent1End: bottomLeft,
            tangent2End: bottomRight,
            radius: cornerRadius
        )
        
        path.addArc(
            tangent1End: bottomRight,
            tangent2End: top,
            radius: cornerRadius
        )
        
        path.addArc(
            tangent1End: top,
            tangent2End: bottomLeft,
            radius: cornerRadius
        )
        
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    RoundedTriangle(cornerRadius: 8)
}
