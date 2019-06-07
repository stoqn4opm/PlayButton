//
//  ViewController.swift
//  PlayButtonExample
//
//  Created by Stoyan Stoyanov on 06/06/2019.
//  Copyright © 2019 Stoyan Stoyanov. All rights reserved.
//

import UIKit
import PlayButton

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: PlayButton!

    let states: [PlayButtonView.State] = [.play, .loadPlay, .pause, .loadPause]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.playButton.enterState(self.states[0])
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.playButton.enterState(self.states[1])
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.playButton.enterState(self.states[2])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.playButton.enterState(self.states[3])
                    }
                }
            }
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        print("tap")
        
    }
}
