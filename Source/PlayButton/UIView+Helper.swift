//
//  UIView+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

// MARK: - View Layout

extension UIView {
    
    /// Inserts view into this one with top, bottom, left, right constaints with 0 distance to the parent.
    ///
    /// - Parameter view: the view you want embedded.
    func embed(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        let top    = NSLayoutConstraint(item: view, attribute: .top,    relatedBy: .equal, toItem: self, attribute: .top,    multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let left   = NSLayoutConstraint(item: view, attribute: .left,   relatedBy: .equal, toItem: self, attribute: .left,   multiplier: 1, constant: 0)
        let right  = NSLayoutConstraint(item: view, attribute: .right,  relatedBy: .equal, toItem: self, attribute: .right,  multiplier: 1, constant: 0)
        
        addConstraints([top, bottom, left, right])
    }
}

// MARK: - View Rotation

extension UIView {
    
    /// Rotation animation identifier.
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    /// Rotates the view around itself continuously.
    ///
    /// Stop the rotation with`.stopRotating()`.
    ///
    /// - Parameter duration: the time it takes for single spin to happen.
    func rotate(duration: TimeInterval = 1) {
        guard layer.animation(forKey: UIView.kRotationAnimationKey) == nil else { return }
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = Float.infinity
        
        layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
    }
    
    /// Stops the endless rotation of `UIView`, started from `.rotate(duration:)` call.
    func stopRotating() {
        guard layer.animation(forKey: UIView.kRotationAnimationKey) != nil else { return }
        layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
    }
}
