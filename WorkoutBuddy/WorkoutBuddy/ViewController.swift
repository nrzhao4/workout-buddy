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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.instructions1Label.text = "Number of exercises"
        self.stepsLabel.text = "5"
        self.stepsLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        self.instructions2Label.text = "Time for each exercise"
        self.timeLabel.text = "10 sec"
        self.timeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        self.instructions3Label.text = "Time between each exercise"
        self.restTimeLabel.text = "0 sec"
        self.restTimeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let steps = Int(sender.value)
        stepsLabel.text = "\(steps)"
    }
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        let time = Int(sender.value)
        timeLabel.text = "\(time) sec"
    }
    
    @IBAction func restTimeSliderValueChanged(_ sender: UISlider) {
        let restTime = Int(sender.value)
        restTimeLabel.text = "\(restTime)"
    }
    
}

