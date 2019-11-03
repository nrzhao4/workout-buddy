//
//  TimerViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-09-17.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController, WorkoutDelegate {
    
    //MARK: Propertie
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var newWorkoutButton: RoundPrimaryButton!
    @IBOutlet weak var pauseButton: RoundPrimaryButton!
    
    //Data
    var workout = [WorkoutUserInput]()
    var timeLeft = 0
    var exerciseNumber = 0
    var maxExerciseNumber = 0
    var repsLeft = 0
    var restTime = 0
    var restsLeft = 0
    var repNumber = 1
    var restCompleted = false
    var timerRunning = false
    var isRestTimer = false
    
    //System sound ID
    //let soundID = 1008
    
    var timer: Timer?
    var restTimer: Timer?
    var backgroundColour: TimerColourView!
    var animator: UIViewPropertyAnimator!
    var textToSpeech: TextToSpeech!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.font = UIFont(name: "Avenir", size: 60.0)
        
        pauseButton.setTitle("Pause", for: .normal)
        newWorkoutButton.isEnabled = false
        newWorkoutButton.isHidden = true

        maxExerciseNumber = workout.count
        setUpTimer(exercise: workout[0])
    }
    
    //Receive the workout data
    func workoutData(workoutExercises: [WorkoutUserInput]) {
        workout = workoutExercises
    }
    
    //Read and setup timers for one exercise at a time
    func setUpTimer(exercise: WorkoutUserInput) {
        repsLeft = exercise.reps
        timeLeft = exercise.time
        restsLeft = exercise.reps - 1
        restTime = exercise.restTime
        
        nameLabel.text = exercise.exerciseName + ": \(repNumber) of \(repsLeft + repNumber)"
        formatTimeLabel(time: timeLeft)
        
        runTimer()
        //animateBackground(time: timeLeft)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerRunning = true
        isRestTimer = false
    }
    @objc func updateTimer() {
        timeLeft -= 1
        formatTimeLabel(time: timeLeft)
        if timeLeft == 0 && restTime > 0 {
            timer?.invalidate()
            timerRunning = false
            formatTimeLabel(time: restTime)
            runRestTime()
            nameLabel.text = "Rest"
        } else if timeLeft == 0 && restTime == 0 {
            timer?.invalidate()
            timerRunning = false
            repsLeft -= 1
            if repsLeft > 0 {
                //reset timer for current exercise
                repNumber += 1
                workout[exerciseNumber].reps -= 1
                setUpTimer(exercise: workout[exerciseNumber])
            } else if exerciseNumber == maxExerciseNumber - 1 {
                workoutComplete()
                return
            } else {
                //move on to next exercise
                exerciseNumber += 1
                setUpTimer(exercise: workout[exerciseNumber])
            }
        }
    }
    
    func runRestTime() {
        restTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRestTime), userInfo: nil, repeats: true)
        timerRunning = true
        isRestTimer = true
    }
    @objc func updateRestTime() {
        restTime -= 1
        formatTimeLabel(time: restTime)
        if restTime == 0 {
            restTimer?.invalidate()
            timerRunning = false
            repsLeft -= 1
            if repsLeft > 0 {
                //reset timer for current exercise
                repNumber += 1
                workout[exerciseNumber].reps -= 1
                setUpTimer(exercise: workout[exerciseNumber])
            } else if exerciseNumber == maxExerciseNumber - 1 {
                workoutComplete()
                return
            } else {
                //move on to next exercise
                exerciseNumber += 1
                setUpTimer(exercise: workout[exerciseNumber])
            }
        }
    }
    
    //Changing timer label to show how much time left
    func formatTimeLabel(time: Int) {
        let mins = time / 60
        let secs = time % 60
        
        if mins < 10 {
            if secs < 10 {
                timeLabel.text = "0\(mins):0\(secs)"
            } else {
                timeLabel.text = "0\(mins):\(secs)"
            }
        } else if secs < 10 {
            timeLabel.text = "\(mins):0\(secs)"
        } else {
            timeLabel.text = "\(mins):\(secs)"
        }
    }
    
    func workoutComplete() {
        nameLabel.text = "Woohoo!"
        timeLabel.font = UIFont(name: "Avenir", size: 30.0)
        timeLabel.text = "Workout complete"
        
        newWorkoutButton.isHidden = false
        newWorkoutButton.isEnabled = true
        newWorkoutButton.setTitle("Done", for: .normal)
        
        pauseButton.isEnabled = false
        pauseButton.isHidden = true
    }
    
    @IBAction func pauseButtonClick(_ sender: RoundPrimaryButton) {
        if timerRunning == true {
            timer?.invalidate()
            restTimer?.invalidate()
            pauseButton.setTitle("Resume", for: .normal)
            timerRunning = false
        } else if timerRunning == false {
            if isRestTimer == true {
                runRestTime()
            } else {
                runTimer()
            }
            pauseButton.setTitle("Pause", for: .normal)
            timerRunning = true
        }
    }
}
