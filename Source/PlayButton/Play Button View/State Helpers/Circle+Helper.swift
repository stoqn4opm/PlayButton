//
//  Circle+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

// MARK: Loading View Definition

/// `UIView` that draws the boundary circle for the button.
final class BoundaryCircleView: UIView {
    
    /// The main color used for drawing this symbol.
    var foregroundColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        foregroundColor.setFill()
        foregroundColor.setStroke()
        
        let scale = CGFloat(0.9)
        let circleSize = bounds.size.applying(CGAffineTransform(scaleX: scale, y: scale))
        let circleOrigin = CGPoint(x: center.x - (circleSize.width / 2), y: center.y - (circleSize.height / 2))
        let path = UIBezierPath.boundaryCircle(in: CGRect(origin: circleOrigin, size: circleSize), lineWidth: bounds.width * 0.1)
        path.stroke()
    }
}

// MARK: - Loading Arc

extension UIBezierPath {
    
    
    /// Creates the `UIBezierPath` for the boundary circle that goes around the button.
    ///
    /// - Parameters:
    ///   - rect: the rect in which you want to put the circle
    ///   - lineWidth: controls how thich the line is.
    /// - Returns: the prepared `UIBezierPath`.
    static fileprivate func boundaryCircle(in rect: CGRect, lineWidth: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        return path
    }
}
