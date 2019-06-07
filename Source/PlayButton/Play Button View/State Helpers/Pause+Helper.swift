//
//  Pause+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

// MARK: - Pause View Definition

/// `UIView` that draws the pause symbol for the button.
final class PauseView: UIView {
    
    /// The main color used for drawing this symbol.
    var foregroundColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        foregroundColor.setFill()
        foregroundColor.setStroke()
        
        let path = UIBezierPath.pauseButton(center: center, height: bounds.height / 2.3, delta: bounds.width / 4)
        path.lineWidth = bounds.width * 0.15
        path.lineCapStyle = .round
        path.stroke()
    }
}

// MARK: - Loading Arc

extension UIBezierPath {
    
    /// Creates the `UIBezierPath` for the pause symbol, needed for the play button.
    ///
    /// - Parameters:
    ///   - center: pass here the center of the arc.
    ///   - height: controls the height of the pause lines.
    ///   - delta: controls the distance from the two pause lines. The center stays in the middle of this distance.
    /// - Returns: the prepared `UIBezierPath`.
    static fileprivate func pauseButton(center: CGPoint, height: CGFloat, delta: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let pointL1 = CGPoint(x: -delta / 2 + center.x, y: -height / 2 + center.y)
        let pointL2 = CGPoint(x: -delta / 2 + center.x, y: height / 2 + center.y)
        
        let pointR1 = CGPoint(x: delta / 2 + center.x, y: -height / 2 + center.y)
        let pointR2 = CGPoint(x: delta / 2 + center.x, y: height / 2 + center.y)
        
        path.move(to: pointL1)
        path.addLine(to: pointL2)
        path.move(to: pointR1)
        path.addLine(to: pointR2)
        return path
    }
}
