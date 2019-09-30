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
    @IBOutlet weak var pauseButton: RoundPrimaryButton!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    var timerColourBackground: TimerColourView!
    
    //From user input
    var steps = 0
    var timerTime = 0
    var restTime = 0
    
    //Timer
    var stepsComplete = 0
    var timerNumber = 1
    var secondsDisplay = 3
    var timer = Timer()
    var isTimerRunning = false
    
    var minutes = 0
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepLabel.font = UIFont.systemFont(ofSize: 20.0)
        self.stepLabel.text = "Workout starting in"
        
        self.timerLabel.font = UIFont(name: "Avenir", size: 62.0)
        self.timerLabel.text = "00:0\(secondsDisplay)"
        
        self.pauseButton.setTitle("Pause", for: .normal)
        
        self.doneButton.setTitle("Done", for: .normal)
        self.doneButton.isEnabled = false
        self.doneButton.isHidden = true
        
        timerColourBackground = TimerColourView(frame: CGRect.zero)
        timerColourBackground.setUpdateValues(timerSeconds: 2)
        self.view.addSubview(timerColourBackground)
        self.view.sendSubviewToBack(timerColourBackground)
        
        runTimer()

    }
    
    //MARK: Functions
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector:
            (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        timerColourBackground.updateWidth()
        secondsDisplay -= 1
        updateLabel()
        
        if secondsDisplay == 0 {
            if stepsComplete == steps {
                workoutComplete()
            }
            else {
                timerDone()
            }
        }
    }
    
    func updateLabel() {
        
        //Countdown to start
        if (timerNumber == 1) {
            timerLabel.text = "00:0\(secondsDisplay)"
            return
        }
        
        //Displaying time format
        if secondsDisplay >= 60 {
            minutes = secondsDisplay / 60
            seconds = secondsDisplay - (minutes * 60)
        } else {
            minutes = 0
            seconds = secondsDisplay
        }
        
        if seconds == 0 {
            timerLabel.text = "0\(minutes):00"
        } else if seconds < 10 {
            timerLabel.text = "0\(minutes):0\(seconds)"
        } else {
            timerLabel.text = "0\(minutes):\(seconds)"
        }
        
        //Label if exercise or rest time
        if (restTime > 0) && (timerNumber % 2 != 0) {
            stepLabel.text = "Next exercise starting in"
        }
        else {
            stepLabel.text = "Exercise \(stepsComplete)"
        }
    }
    
    func timerDone() {
        //Every other timer is a rest timer
        if (restTime > 0) && (timerNumber % 2 == 0) {
            secondsDisplay = restTime + 1
            timerNumber += 1
            timerColourBackground.clear()
            timerColourBackground.setUpdateValues(timerSeconds: restTime)
            timerColourBackground.startTimerBackground(isRestTime: true)
        }
        //If no rest timers needed
        else {
            secondsDisplay = timerTime + 1
            timerNumber += 1
            stepsComplete += 1
            timerColourBackground.clear()
            timerColourBackground.setUpdateValues(timerSeconds: timerTime)
            timerColourBackground.startTimerBackground(isRestTime: false)
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
        
        timerColourBackground.clear()
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("button pressed")
        if isTimerRunning == true {
            timer.invalidate()
            isTimerRunning = false
            pauseButton.setTitle("Resume", for: .normal)
        }
        
        else if isTimerRunning == false && stepsComplete <= steps {
            print("resume timer")
            runTimer()
            pauseButton.setTitle("Pause", for: .normal)
        }
    }
    

}
