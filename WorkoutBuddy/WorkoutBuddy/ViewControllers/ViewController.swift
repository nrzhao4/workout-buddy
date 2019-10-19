//
//  ViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-09-15.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var instructions1Label: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsStepper: UIStepper!
    
    @IBOutlet weak var instructions2Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var instructions3Label: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var restTimeSlider: UISlider!
    
    @IBOutlet weak var startButton: RoundPrimaryButton!
    
    var steps = 5
    var time = 10
    var restTime = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Labels
        self.instructions1Label.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.instructions1Label.text = "Number of exercises"
        
        self.stepsLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.stepsLabel.text = "\(GlobalConstants.defaultReps)"
       
        self.instructions2Label.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.instructions2Label.text = "Time for each exercise"
        
        self.timeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.timeLabel.text = "0:00"
       
        self.instructions3Label.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.instructions3Label.text = "Time between each exercise"
        
        self.restTimeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.restTimeLabel.text = "0:00"
       
        //Sliders
        /*self.timeSlider.minimumValue = Float(GlobalConstants.minTimeInSeconds)
        self.timeSlider.maximumValue = Float(GlobalConstants.maxTimeInSeconds)
        
        self.restTimeSlider.minimumValue = Float(GlobalConstants.minRestTimeInSeconds)
        self.restTimeSlider.maximumValue = Float(GlobalConstants.maxRestTimeInSeconds)*/
        
        //Buttons
        startButton.setTitle("Start workout", for: .normal)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        steps = Int(sender.value)
        stepsLabel.text = "\(steps)"
    }
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        time = Int(sender.value)
        
        let minutes = time / 60
        let seconds = time - (60 * minutes)
        
        if seconds == 0 {
            timeLabel.text = "\(minutes):00"
        } else if seconds < 10 {
            timeLabel.text = "\(minutes):0\(seconds)"
        } else {
            timeLabel.text = "\(minutes):\(seconds)"
        }
    }

    @IBAction func restTimeSliderValueChanged(_ sender: UISlider) {
        restTime = Int(sender.value)
        let minutes = restTime / 60
        let seconds = restTime - (60 * minutes)
        if seconds == 0 {
            restTimeLabel.text = "\(minutes):00"
        } else if seconds < 10 {
            restTimeLabel.text = "\(minutes):0\(seconds)"
        } else {
            restTimeLabel.text = "\(minutes):\(seconds)"
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let workout = segue.destination as? TimerViewController {
            workout.steps = steps
            workout.timerSeconds = time
            workout.restTimeSeconds = restTime
        }
    }
}

