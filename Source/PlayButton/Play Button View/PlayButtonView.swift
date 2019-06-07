//
//  PlayButtonView.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

// MARK: - Class Definition

/// `UIView` that can enter several states, with or without animation and resembles play/pause/load symbol indication.
@IBDesignable
public final class PlayButtonView: UIView {
 
    
    
    // MARK: Configuration
    
    /// The time it takes for the `PlayButtonView` to switch from one state to another.
    ///
    /// Default value is: 0.7.
    @IBInspectable public var stateSwitchDuration: TimeInterval = 0.7
    
    /// The scale factor of the boundary symbol and load symbol during touch interaction.
    ///
    /// Default value is: 1.4.
    @IBInspectable public var  maxBoundaryScale: CGFloat = 1.4
    
    /// The color used for the play symbol during no loading, no interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playRestColor: UIColor = .black
    
    /// The color used for the play symbol during tap interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playTapColor: UIColor = .black
    
    /// The color used for the play symbol during loading.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playLoadColor: UIColor = .black
    
    /// The color used for the pause symbol during no loading, no interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseRestColor: UIColor = .black
    
    /// The color used for the pause symbol during tap interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseTapColor: UIColor = .black
    
    /// The color used for the pause symbol during loading.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseLoadColor: UIColor = .black
    
    /// The color used for the boundary circle.
    ///
    /// Default color: `.black`.
    @IBInspectable public var boundaryRestColor: UIColor = .black
    
    /// The color used for the loading indicator circle.
    ///
    /// Default color: `.black`.
    @IBInspectable public var loadRestColor: UIColor = .black

    
    
    // MARK: Public Properties
    
    /// Holds the in what state currently the view is.
    public internal(set) var currentState: State = .play
    
    
    
    // MARK: Internal Properties
    
    /// UIView representing the Play symbol from the button.
    let playSymbol: PlayView
    
    /// UIView representing the Pause symbol from the button.
    let pauseSymbol: PauseView
    
    /// UIView representing the loading indication from the button.
    let loadingSymbol: LoadingArcView
    
    /// UIView representing the boundary circle from the button.
    let boundaryCircle: BoundaryCircleView


    public override init(frame: CGRect) {
        playSymbol = PlayView(frame: frame)
        pauseSymbol = PauseView(frame: frame)
        loadingSymbol = LoadingArcView(frame: frame)
        boundaryCircle = BoundaryCircleView(frame: frame)
        super.init(frame: frame)
        putSymbols()
    }
    
    required init?(coder aDecoder: NSCoder) {
        playSymbol = PlayView(frame: .zero)
        pauseSymbol = PauseView(frame: .zero)
        loadingSymbol = LoadingArcView(frame: .zero)
        boundaryCircle = BoundaryCircleView(frame: .zero)
        super.init(coder: aDecoder)
        putSymbols()
    }
    
    /// Loads all symbols and prepares the view for presentation.
    private func putSymbols() {
        embed(playSymbol)
        embed(pauseSymbol)
        embed(loadingSymbol)
        embed(boundaryCircle)
        loadingSymbol.rotate()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        forcefullyEnterState(.play, animated: false)
    }
}

// MARK: - User Intraction Tracking

extension PlayButtonView {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first?.location(in: self) else { return }
        guard touch.x > 0 && touch.x < bounds.width   else { return }
        guard touch.y > 0 && touch.y < bounds.height  else { return }
        highlight(true)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        highlight(false)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        highlight(false)
    }
}

// MARK: - Boundary Grow Highlight

extension PlayButtonView {
    
    /// Animates the view between highlighted and not highlited states.
    ///
    /// - Parameter isHighlighted: the state in which you want the view in.
    func highlight(_ isHighlighted: Bool) {
        
        let colorFlipTime = stateSwitchDuration * 0.5
        let transformTime = stateSwitchDuration
        let transform = isHighlighted ? CGAffineTransform.identity.scaledBy(x: maxBoundaryScale, y: maxBoundaryScale) : .identity
        
        let animator1 = UIViewPropertyAnimator(duration: transformTime, dampingRatio: 0.6) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadingSymbol.transform = transform
            strongSelf.boundaryCircle.transform = transform
        }
        animator1.startAnimation()
        
        
        UIView.transition(with: playSymbol, duration: colorFlipTime, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.playSymbol.foregroundColor = isHighlighted ? strongSelf.playTapColor : strongSelf.playRestColor
            strongSelf.playSymbol.setNeedsDisplay()
        })
        
        UIView.transition(with: pauseSymbol, duration: colorFlipTime, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.pauseSymbol.foregroundColor = isHighlighted ? strongSelf.pauseTapColor : strongSelf.pauseRestColor
            strongSelf.pauseSymbol.setNeedsDisplay()
        })
    }
}
