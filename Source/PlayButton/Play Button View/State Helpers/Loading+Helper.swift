//
//  Loading+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit


// MARK: Loading View Definition

/// `UIView` that draws the arc for loading indicaton.
final class LoadingArcView: UIView {
    
    /// The main color used for drawing this symbol.
    var foregroundColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        foregroundColor.setFill()
        foregroundColor.setStroke()
        
        let path = UIBezierPath.loadArc(center: center, radius: bounds.width * 0.45, lineWidth: bounds.width * 0.1)
        path.stroke()
    }
}

// MARK: - Loading Arc

extension UIBezierPath {
    
    /// Creates the `UIBezierPath` for the circular loading indicator that goes around the button.
    ///
    /// - Parameters:
    ///   - center: pass here the center of the arc.
    ///   - radius: controls how far away from the center should the arc go in every direction.
    ///   - lineWidth: controls how thich the line is.
    /// - Returns: the prepared `UIBezierPath`.
    static fileprivate func loadArc(center: CGPoint, radius: CGFloat, lineWidth: CGFloat) -> UIBezierPath {
        let polarAngle1 = CGFloat(0)
        let polarAngle2 = CGFloat.pi / 6
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: polarAngle1, endAngle: polarAngle2, clockwise: false)
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        return path
    }
}
