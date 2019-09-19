//
//  TimerViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-09-17.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    //From user input
    var steps = 0
    var timerTime = 0
    var restTime = 0
    
    //Timer
    var stepsComplete = 0
    var timerNumber = 1
    var seconds = 3
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.stepLabel.text = "Workout starting in"
        
        self.timerLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        self.timerLabel.text = "00:0\(seconds)"
        
        self.pauseButton.setTitle("Pause", for: .normal)
        
        self.doneButton.setTitle("Done", for: .normal)
        self.doneButton.isEnabled = false
        self.doneButton.isHidden = true
        
        runTimer()

    }
    
    //MARK: Functions
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector:
            (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        seconds -= 1
        updateLabel()
        
        if seconds == 0 {
            if stepsComplete == steps {
                workoutComplete()
            }
            else {
                timerDone()
            }
        }
    }
    
    func updateLabel() {
        if (timerNumber == 1) {
            timerLabel.text = "00:0\(seconds)"
            return
        }
        if (seconds >= 10) {
            timerLabel.text = "00:\(seconds)"
        } else {
            timerLabel.text = "00:0\(seconds)"
        }
        
        if (restTime > 0) && (timerNumber % 2 != 0) {
            stepLabel.text = "Next exercise starting in"
        }
        else {
            stepLabel.text = "Exercise \(stepsComplete)"
        }
    }
    
    func timerDone() {
        if (restTime > 0) && (timerNumber % 2 == 0) {
            seconds = restTime + 1
            timerNumber += 1
        }
        else {
            seconds = timerTime + 1
            timerNumber += 1
            stepsComplete += 1
        }
    }
    
    func workoutComplete() {
        timer.invalidate()
        isTimerRunning = false
        
        stepLabel.text = "Workout complete"
        timerLabel.isHidden = true
        
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        doneButton.isEnabled = true
        doneButton.isHidden = false
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("button pressed")
        if isTimerRunning == true {
            timer.invalidate()
            isTimerRunning = false
            pauseButton.setTitle("Resume", for: .normal)
        }
        
        else if isTimerRunning == false && stepsComplete < steps {
            runTimer()
            pauseButton.setTitle("Pause", for: .normal)
        }
    }
    

}
