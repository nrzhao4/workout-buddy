//
//  CustomeExerciseViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-13.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class CustomExerciseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var addRestLabel: UILabel!
    @IBOutlet weak var addRestSwitch: UISwitch!
    
    @IBOutlet weak var stackView2: UIStackView!
    
    let restPickerView = TimerPickerView()
    
    override func viewDidLoad() {
        
        let timerPickerView = TimerPickerView()
        timerPickerView.translatesAutoresizingMaskIntoConstraints = false
        timerPickerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        timerPickerView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        stackView.addArrangedSubview(timerPickerView)
        
        addRestLabel.text = "Add rest time"
        self.exerciseName.delegate = self
        
    }
    
    func addRestTimePicker() {
        restPickerView.translatesAutoresizingMaskIntoConstraints = false
        restPickerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        restPickerView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        stackView2.addArrangedSubview(restPickerView)
    }

    @IBAction func restSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            addRestTimePicker()
        } else {
            restPickerView.removeFromSuperview()
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

