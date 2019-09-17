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
    
    @IBOutlet weak var startButton: UIButton!
    
    var steps = 5
    var time = 10
    var restTime = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Labels
        self.instructions1Label.text = "Number of exercises"
        self.stepsLabel.text = "\(GlobalConstants.defaultSteps)"
        self.stepsLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        self.instructions2Label.text = "Time for each exercise"
        self.timeLabel.text = "\(GlobalConstants.minTimePerStep) sec"
        self.timeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        self.instructions3Label.text = "Time between each exercise"
        self.restTimeLabel.text = "\(GlobalConstants.minRestTime) sec"
        self.restTimeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        //Sliders
        self.timeSlider.minimumValue = Float(GlobalConstants.minTimePerStep)
        self.timeSlider.maximumValue = Float(GlobalConstants.maxTimePerStep)
        
        self.restTimeSlider.minimumValue = Float(GlobalConstants.minRestTime)
        self.restTimeSlider.maximumValue = Float(GlobalConstants.maxRestTime)
        
        //Buttons
        self.startButton.setTitle("Start", for: .normal)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        steps = Int(sender.value)
        stepsLabel.text = "\(steps)"
    }
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        time = Int(sender.value)
        timeLabel.text = "\(time) sec"
    }

    @IBAction func restTimeSliderValueChanged(_ sender: UISlider) {
        restTime = Int(sender.value)
        restTimeLabel.text = "\(restTime) sec"
    }
    
}

