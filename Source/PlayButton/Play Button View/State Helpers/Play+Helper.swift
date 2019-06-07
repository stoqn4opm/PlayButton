//
//  Play+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

// MARK: - Play View Definition

/// `UIView` that draws the play symbol for the button.
final class PlayView: UIView {
    
    /// The main color used for drawing this symbol.
    var foregroundColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        foregroundColor.setFill()
        foregroundColor.setStroke()

        let commonPart = bounds.height * 0.8
        let path = UIBezierPath.playSymbolInCircle(withRadius: commonPart * 0.37, center: center, cornerRadius: commonPart * 0.05)
        path.stroke()
        path.fill()
    }
}

// MARK: - Play Button UIBezierPath

extension UIBezierPath {
    
    /// Creates the `UIBezierPath` for the play symbol, needed for the play button.
    ///
    /// - Parameters:
    ///   - radius: pass here the radius of the boundary circle, that has the play symbol inscribed.
    ///   - center: pass here where you want the center of the play symbol to be.
    ///   - cornerRadius: pass here how much you want the edges of the play triangle to be rounded.
    /// - Returns: the prepared `UIBezierPath`.
    static fileprivate func playSymbolInCircle(withRadius radius: CGFloat, center: CGPoint, cornerRadius: CGFloat) -> UIBezierPath {
        // Points of the triangle
        let points = center.circumscribedTriangle(InRadius: radius)
        let cgPath = CGMutablePath()
        guard points.count == 4 else { return UIBezierPath(cgPath: cgPath) }
        
        cgPath.move(to: points[0])
        cgPath.addArc(tangent1End: points[0], tangent2End: points[2], radius: cornerRadius)
        cgPath.addArc(tangent1End: points[2], tangent2End: points[3], radius: cornerRadius)
        cgPath.addArc(tangent1End: points[3], tangent2End: points[1], radius: cornerRadius)
        cgPath.addArc(tangent1End: points[1], tangent2End: points[0], radius: cornerRadius)
    
        cgPath.closeSubpath()
        
        let bezierPath = UIBezierPath(cgPath: cgPath)
        return bezierPath
    }
}

// MARK: - Points Of Triangle

extension CGPoint {
    
    /// Gives back four points of triangle in the shape of play button.
    ///
    /// Let the play triangle be with edges ABC, where A is the edge on the right of the play button,
    /// B is the edge on the bottom of the play button and C is the edge on top of the play button.
    ///
    /// The returned 4 points are:
    ///
    /// - point 1: the middle point of the side AB
    /// - point 2: edge B
    /// - point 3: edge C
    /// - point 4: edge A
    ///
    /// - Parameter radius: the radius of the the boundary circle for this play triangle.
    /// - Returns: the 4 points as described above.
    fileprivate func circumscribedTriangle(InRadius radius: CGFloat) -> [CGPoint] {
        
        let polarAngle1 = 0 * (2 * CGFloat.pi / 3)
        let polarAngle2 = 1 * (2 * CGFloat.pi / 3)
        let polarAngle3 = 2 * (2 * CGFloat.pi / 3)
        
        let angle1 = polarToCartesianCoords(radius: radius, angle: polarAngle1, translation: self)
        let angle2 = polarToCartesianCoords(radius: radius, angle: polarAngle2, translation: self)
        let angle3 = polarToCartesianCoords(radius: radius, angle: polarAngle3, translation: self)
        
        /// the middle point on the line passing through angle1 and angle2
        let midOnSide12 = CGPoint(x: (angle1.x + angle2.x) / 2, y: (angle1.y + angle2.y) / 2)
        
        let result = [midOnSide12, angle1, angle2, angle3]
        return result
    }
}
