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
    
    //From user input
    var timerTime = 5
    var steps = 2
    var restTime = 2
    
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
        updateStepLabel()
        timerLabel.text = "00:0\(seconds)"
        
        if seconds == 0 {
            if stepsComplete == steps {
                workoutComplete()
            }
            else {
                timerDone()
            }
        }
    }
    
    func updateStepLabel() {
        if (timerNumber == 1) {
            return
        }
        else if (restTime > 0) && (timerNumber % 2 != 0) {
            stepLabel.text = "Next exercise starting in"
        }
        else {
            stepLabel.text = "Exercise \(stepsComplete)"
        }
    }
    
    func timerDone() {
        if (restTime > 0) && (timerNumber % 2 == 0) {
            seconds = restTime
            timerNumber += 1
        }
        else {
            seconds = timerTime
            timerNumber += 1
            stepsComplete += 1
        }
    }
    
    func workoutComplete() {
        timer.invalidate()
        isTimerRunning = false
        
        pauseButton.setTitle("Create another workout", for: .normal)
        stepLabel.text = "Workout complete"
        timerLabel.isHidden = true
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("button pressed")
        if isTimerRunning == true {
            timer.invalidate()
            isTimerRunning = false
            print("pause timer")
        }
        
        else if isTimerRunning == false && stepsComplete < steps {
            runTimer()
            print("resume timer")
        }
    }
    

}
