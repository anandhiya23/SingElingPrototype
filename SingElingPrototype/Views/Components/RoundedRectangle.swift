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
        
        // Define the points of the triangle
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        // Move to the initial point (top of the triangle)
        path.move(to: CGPoint(x: top.x, y: top.y))
        
        // Draw a line from the top to the bottom-left with a corner radius
        path.addArc(
            tangent1End: top,
            tangent2End: bottomLeft,
            radius: cornerRadius
        )
        
        // Draw a line from the bottom-left to the bottom-right with a corner radius
        path.addArc(
            tangent1End: bottomLeft,
            tangent2End: bottomRight,
            radius: cornerRadius
        )
        
        // Draw a line from the bottom-right back to the top with a corner radius
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
