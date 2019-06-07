//
//  Coordinates+Helper.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import Foundation


/// Translates polar coordinates into cartesian coordinates.
///
/// - Parameters:
///   - r: the radius component of the polar coordinate.
///   - angle: the angle component of the polar coordinate.
///   - translation: optional cartesian translation that can be applied during the translation.
/// - Returns: the same point but in cartesian coordinates.
func polarToCartesianCoords(radius r: CGFloat, angle: CGFloat, translation: CGPoint = .zero) -> CGPoint {
    let x = r * cos(angle) + translation.x
    let y = r * sin(angle) + translation.y
    return CGPoint(x: x, y: y)
}
