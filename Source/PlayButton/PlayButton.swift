//
//  PlayButton.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit

/// `UIButton` that can enter several states with play/pause/load symbol indication.
@IBDesignable
public final class PlayButton: UIButton {
    
    
    
    // MARK: Configuration
    
    /// The time it takes for the `PlayButtonView` to switch from one state to another.
    ///
    /// Default value is: 0.3.
    @IBInspectable public var stateSwitchDuration: TimeInterval = 0.3 { didSet { playButtonView.stateSwitchDuration = stateSwitchDuration } }
    
    /// The time it takes for the `PlayButtonView` to switch from one state to another.
    ///
    /// Default value is: 0.5.
    @IBInspectable public var highlightDuration: TimeInterval = 0.5 { didSet { playButtonView.highlightDuration = highlightDuration } }
    
    /// The scale factor of the boundary symbol and load symbol during touch interaction.
    ///
    /// Default value is: 1.4.
    @IBInspectable public var  maxBoundaryScale: CGFloat = 1.4 { didSet { playButtonView.maxBoundaryScale = maxBoundaryScale } }
    
    /// The color used for the play symbol during no loading, no interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playRestColor: UIColor = .black { didSet { playButtonView.playRestColor = playRestColor } }
    
    /// The color used for the play symbol during tap interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playTapColor: UIColor = .black { didSet { playButtonView.playTapColor = playTapColor } }
    
    /// The color used for the play symbol during loading.
    ///
    /// Default color: `.black`.
    @IBInspectable public var playLoadColor: UIColor = .black { didSet { playButtonView.playLoadColor = playLoadColor } }
    
    /// The color used for the pause symbol during no loading, no interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseRestColor: UIColor = .black { didSet { playButtonView.pauseRestColor = pauseRestColor } }
    
    /// The color used for the pause symbol during tap interaction.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseTapColor: UIColor = .black { didSet { playButtonView.pauseTapColor = pauseTapColor } }
    
    /// The color used for the pause symbol during loading.
    ///
    /// Default color: `.black`.
    @IBInspectable public var pauseLoadColor: UIColor = .black { didSet { playButtonView.pauseLoadColor = pauseLoadColor } }
    
    /// The color used for the boundary circle.
    ///
    /// Default color: `.black`.
    @IBInspectable public var boundaryRestColor: UIColor = .black { didSet { playButtonView.boundaryRestColor = boundaryRestColor } }
    
    /// The color used for the loading indicator circle.
    ///
    /// Default color: `.black`.
    @IBInspectable public var loadRestColor: UIColor = .black { didSet { playButtonView.loadRestColor = loadRestColor } }
    
    
    
    // MARK: Public Properties
    
    /// Holds the in what state currently the button is.
    public var currentState: PlayButtonView.State { return playButtonView.currentState }
    
    
    
    // MARK: Internal Properties
    
    /// `UIView` that can enter several states, with or without animation and resembles play/pause/load symbol indication.
    ///
    /// This is what handles the UI appearance.
    let playButtonView: PlayButtonView
    
    
    override init(frame: CGRect) {
        playButtonView = PlayButtonView(frame: frame)
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        playButtonView = PlayButtonView(frame: .zero)
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @available(*, unavailable)
    private init(type: UIButton.ButtonType) {
        fatalError("do not use it")
    }
    
    /// Loads all symbols and prepares the button for presentation.
    private func commonInit() {
        addSubview(playButtonView)
        playButtonView.translatesAutoresizingMaskIntoConstraints = false
        playButtonView.isUserInteractionEnabled = false
        embed(playButtonView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        playButtonView.stateSwitchDuration = stateSwitchDuration
        playButtonView.maxBoundaryScale = maxBoundaryScale
        playButtonView.playRestColor = playRestColor
        playButtonView.playTapColor = playTapColor
        playButtonView.playLoadColor = playLoadColor
        playButtonView.pauseRestColor = pauseRestColor
        playButtonView.pauseTapColor = pauseTapColor
        playButtonView.pauseLoadColor = pauseLoadColor
        playButtonView.boundaryRestColor = boundaryRestColor
        playButtonView.loadRestColor = loadRestColor
    }
}


// MARK: - Entering States

extension PlayButton {
    
    /// Makes the `PlayButton` enter new state.
    ///
    /// - Parameters:
    ///   - state: the state you want the `PlayButton` to enter.
    ///   - animated: true for animated transition, false for no animation.
    public func enterState(_ state: PlayButtonView.State, animated: Bool = true) {
        playButtonView.enterState(state, animated: animated)
    }
}

// MARK: - Shrink/Grow Circles

extension PlayButton {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first?.location(in: self) else { return }
        guard touch.x > 0 && touch.x < bounds.width   else { return }
        guard touch.y > 0 && touch.y < bounds.height  else { return }
        playButtonView.highlight(true)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        playButtonView.highlight(false)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        playButtonView.highlight(false)
    }
}
