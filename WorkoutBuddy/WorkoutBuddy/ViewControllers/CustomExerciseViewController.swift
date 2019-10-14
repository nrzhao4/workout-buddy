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
    @IBOutlet weak var addNextButton: RoundSecondaryButton!
    @IBOutlet weak var startWorkoutButton: RoundPrimaryButton!
    var restPickerView = TimerPickerView()
    var timerPickerView = TimerPickerView()
    
    var exerciseNumber = 1
    var name = ""
    var time = 0
    var restTime = 0
    var userInput = [WorkoutUserInput]()
    
    override func viewDidLoad() {
        
        timerPickerView = TimerPickerView(frame: CGRect.zero)
        timerPickerView.translatesAutoresizingMaskIntoConstraints = false
        timerPickerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        timerPickerView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        stackView.addArrangedSubview(timerPickerView)
        
        addRestLabel.text = "Add rest time"
        
        addNextButton.setTitle("Add another exercise", for: .normal)
        startWorkoutButton.setTitle("Start workout", for: .normal)
        self.exerciseName.delegate = self
        
    }
    
    func addRestTimePicker() {
        //Show rest time picker if user toggles rest time switch
        restPickerView.translatesAutoresizingMaskIntoConstraints = false
        restPickerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        restPickerView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        stackView2.addArrangedSubview(restPickerView)
    }
    
    //When user toggles rest time switch
    @IBAction func restSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            //If user turns switch ON, show rest time picker
            addRestTimePicker()
        } else {
            //If user turns switch OFF, remove rest time picker
            restPickerView.removeFromSuperview()
        }

    }
    
    func reset() {
        //Reset the page for user to enter next exercise
        //Clear stored data
        name = ""
        timerPickerView.clearPickerValues()
        restPickerView.clearPickerValues()
        
        //Clear textfield and update placeholder text
        exerciseName.text = nil
        exerciseName.placeholder = "Exercise \(exerciseNumber)"
        
        //Set times to 0, set rest time to off
        timerPickerView.selectRow(0, inComponent: 0, animated: true)
        timerPickerView.selectRow(0, inComponent: 2, animated: true)
        restPickerView.selectRow(0, inComponent: 0, animated: true)
        restPickerView.selectRow(0, inComponent: 2, animated: true)
        addRestSwitch.isOn = false
        restSwitchChanged(addRestSwitch)
    }
    
    func getWorkoutValues() {
        name = exerciseName.text ?? ""
        if name == "" {
            name = "Exercise \(exerciseNumber)"
        }
        time = timerPickerView.getTotalSeconds()
        
        if addRestSwitch.isOn == false {
            restTime = 0
        } else {
            restTime = restPickerView.getTotalSeconds()
        }
        
        //Add to array of user inputs
        userInput.append(WorkoutUserInput(exerciseName: name, time: time, restTime: restTime)!)
    }
    
    
    //Bring down keyboard when user done editing exercise name
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func addNextButtonClick(_ sender: RoundSecondaryButton) {
        getWorkoutValues()
        exerciseNumber += 1
        reset()
    }
    @IBAction func doneButtonClick(_ sender: RoundPrimaryButton) {
    }
}

