//
//  ViewController.swift
//  EggTimer
//
//  Created by Saul Rivera on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    var timer: Timer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle ?? "N/A"
        let timerLapse = Float((eggTimes[hardness] ?? 0)) * 60
        var timeRemain = timerLapse
        
        if let timer = timer {
            timer.invalidate()
        }
        
        progressBar.progress = 0.0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.progressBar.progress = 1.0 - (timeRemain / timerLapse)
            timeRemain -= 1
            if timeRemain < 0 {
                timer.invalidate()
                self.titleLabel.text = "Done!"
            }
        }
    }
    
}
