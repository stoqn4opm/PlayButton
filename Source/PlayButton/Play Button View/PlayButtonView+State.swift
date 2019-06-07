//
//  PlayButtonView+State.swift
//  PlayButton
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import Foundation

// MARK: - Animation States

extension PlayButtonView {
    
    /// All possible states of the PlayButtonView.
    ///
    /// At all time `PlayButtonView`s are in one of these states.
    ///
    /// - play: displays a play symbol.
    /// - pause: displays a pause symbol.
    /// - loadPlay: displays a play symbol with a loding indication.
    /// - loadPause: displays a pause symbol with a loding indication.
    public enum State {
        
        /// displays a play symbol.
        case play

        /// displays a pause symbol.
        case pause
        
        // displays a play symbol with a loding indication.
        case loadPlay

        // displays a pause symbol with a loding indication.
        case loadPause
    }
}

// MARK: - Entering States

extension PlayButtonView {
    
    /// Makes the `PlayButtonView` enter new state.
    ///
    /// - Parameters:
    ///   - state: the state you want the `PlayButtonView` to enter.
    ///   - animated: true for animated transition, false for no animation.
    public func enterState(_ state: State, animated: Bool = true) {
        guard state != currentState else { return }
        currentState = state
        forcefullyEnterState(state, animated: animated)
    }
    
    /// Makes the view enter state without making any prior checks.
    ///
    /// - Parameters:
    ///   - state: the state you want the button to enter.
    ///   - animated: true for animated transition, false for no animation.
    func forcefullyEnterState(_ state: State, animated: Bool = true) {
        
        switch state {
        case .play:      show(playButton: true,  loading: false, animated: animated)
        case .pause:     show(playButton: false, loading: false, animated: animated)
        case .loadPlay:  show(playButton: true,  loading: true,  animated: animated)
        case .loadPause: show(playButton: false, loading: true,  animated: animated)
        }
    }
    
    /// Updates the button in regards to the state it is in.
    ///
    /// Used intearnally as a part of other routines.
    ///
    /// - Parameters:
    ///   - playButton: show play symbol if true, pause button if false.
    ///   - loading: shows loading indicator if true, boundary circle if false.
    ///   - animated: true for animated transition, false for no animation.
    private func show(playButton: Bool, loading: Bool, animated: Bool) {
        
        if animated {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: stateSwitchDuration, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
                self?.updateSymbols(playButton: playButton, loading: loading)
            })
        } else {
            updateSymbols(playButton: playButton, loading: loading)
        }
    }
    
    /// Performs the direct updates of symbol views during state changes.
    ///
    /// Used intearnally as a part of other routines.
    ///
    /// - Parameters:
    ///   - playButton: show play symbol if true, pause button if false.
    ///   - loading: shows loading indicator if true, boundary circle if false.
    private func updateSymbols(playButton: Bool, loading: Bool) {
        
        playSymbol.foregroundColor = loading ? playLoadColor : playRestColor
        playSymbol.alpha = playButton ? 1 : 0
        
        pauseSymbol.foregroundColor = loading ? pauseLoadColor : pauseRestColor
        pauseSymbol.alpha = playButton ? 0 : 1
        
        loadingSymbol.foregroundColor = loadRestColor
        loadingSymbol.alpha = loading ? 1 : 0
        
        boundaryCircle.foregroundColor = boundaryRestColor
        boundaryCircle.alpha = loading ? 0 : 1
    }
}
