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
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pauseButton: RoundPrimaryButton!
    @IBOutlet weak var timerDescriptionLabel: UILabel!
    @IBOutlet weak var doneButton: RoundPrimaryButton!
    
    var timerColourBackground: TimerColourView!
    var timerAnimate: UIViewPropertyAnimator!
    
    //From user input
    var steps = 0
    var timerSeconds = 0
    var restTimeSeconds = 0
    
    //Timer
    //Initial timer has 3 second countdown
    var totalSeconds = 3
    var minutes = 0
    var seconds = 0
    var initialTimerDone = false
    
    var timersNeeded = 0
    var restTimersNeeded = 0
    var stepNumber = 0
    var timerPaused = false
    
    var timer = Timer()
    var firstTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timersNeeded = steps
        if restTimeSeconds > 0 {
            restTimersNeeded = steps - 1
        }
        
        self.timerDescriptionLabel.font = UIFont.systemFont(ofSize: 20.0)
        self.timerDescriptionLabel.text = "Workout starting in"
        
        self.timeLabel.font = UIFont(name: "Avenir", size: 62.0)
        self.timeLabel.text = "00:03"
        
        self.pauseButton.setTitle("Pause", for: .normal)
        
        self.doneButton.setTitle("Done", for: .normal)
        self.doneButton.isEnabled = false
        self.doneButton.isHidden = true
        
        timerColourBackground = TimerColourView(frame: CGRect.zero)
        
        self.view.addSubview(timerColourBackground)
        self.view.sendSubviewToBack(timerColourBackground)
        
        initialTimer()
    }
    
    //MARK: Functions
    
    //Initial countdown of 3 seconds before workout begins
    func initialTimer() {
        firstTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector:
            (#selector(updateInitialTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateInitialTimer() {
        totalSeconds -= 1
        timeLabel.text = "00:0\(totalSeconds)"
        
        //initial timer done
        if totalSeconds == 0 {
            firstTimer.invalidate()
            setupTimer(isRestTime: false)
            initialTimerDone = true
        }
    }
    
    //Workout timers
    func setupTimer(isRestTime: Bool) {
        if isRestTime == false {
            stepNumber += 1
            timersNeeded -= 1
            totalSeconds = timerSeconds
            timerDescriptionLabel.text = "Exercise \(steps - timersNeeded)"
            timerColourBackground.startTimerBackground(isRestTime: false)
        } else {
            stepNumber += 1
            restTimersNeeded -= 1
            totalSeconds = restTimeSeconds
            timerDescriptionLabel.text = "Next exercise starting in"
            timerColourBackground.startTimerBackground(isRestTime: true)
        }
        updateLabel()
        runTimer()
        animateBackground(time: totalSeconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector:
            (#selector(updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        totalSeconds -= 1
        if totalSeconds >= 1 {
            updateLabel()
        } else {
            timer.invalidate()
            timerDone()
        }
    }
    
    func updateLabel() {
        //calculation of display minutes and seconds
        if totalSeconds < 60 {
            minutes = 0
            seconds = totalSeconds
        } else if totalSeconds > 60 {
            seconds = totalSeconds % 60
            minutes = (totalSeconds - seconds) / 60
        }
        
        //formatting of minutes and seconds
        if minutes < 10 && seconds < 10 {
            timeLabel.text = "0\(minutes):0\(seconds)"
        } else if minutes < 10 && seconds >= 10 {
            timeLabel.text = "0\(minutes):\(seconds)"
        } else if minutes >= 10 && seconds < 10 {
            timeLabel.text = "\(minutes):0\(seconds)"
        } else if minutes >= 10 && seconds >= 10 {
            timeLabel.text = "\(minutes):\(seconds)"
        }

    }
    
    func timerDone() {
        if timersNeeded == 0 {
            workoutComplete()
        } else if (restTimersNeeded != 0) && (stepNumber % 2 != 0) {
            //If need rest timer, every other timer will be a rest timer
            setupTimer(isRestTime: true)
        } else {
            setupTimer(isRestTime: false)
        }
    }
    
    func workoutComplete() {
        timerColourBackground.isHidden = true
        timerColourBackground = nil
        
        timeLabel.text = "00:00"
        timerDescriptionLabel.text = "Workout complete!"
        
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
        
        doneButton.isHidden = false
        doneButton.isEnabled = true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if timerPaused == false {
            if initialTimerDone == false {
                firstTimer.invalidate()
            } else {
                timer.invalidate()
            }
            timerAnimate.pauseAnimation()
            pauseButton.setTitle("Resume", for: .normal)
            timerPaused = true
        } else {
            if initialTimerDone == false {
                initialTimer()
            } else {
                runTimer()
            }
            timerAnimate.startAnimation()
            pauseButton.setTitle("Pause", for: .normal)
            timerPaused = false
        }
    }
    
    func animateBackground(time: Int) {
        timerAnimate = UIViewPropertyAnimator(
            duration: Double(time),
            curve: .linear) {
                print("animating")
                self.timerColourBackground.frame.size.width += self.timerColourBackground.screenWidth
        }
        timerAnimate.startAnimation()
    }
}
