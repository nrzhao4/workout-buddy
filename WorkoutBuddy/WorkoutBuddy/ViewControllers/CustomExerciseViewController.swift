//
//  CustomeExerciseViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-13.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

protocol WorkoutDelegate {
    func workoutData(workoutExercises: [WorkoutUserInput])
}

class CustomExerciseViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var exerciseName: UITextField!
    @IBOutlet weak var timerPickerView: TimerPickerView!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var repsStepper: UIStepper!
    @IBOutlet weak var addRestLabel: UILabel!
    @IBOutlet weak var addRestSwitch: UISwitch!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var addNextButton: RoundSecondaryButton!

    
    var delegate: WorkoutDelegate?

    var restPickerView = TimerPickerView()
    
    var exerciseNumber = 1
    var name = ""
    var time = 0
    var reps = GlobalConstants.defaultReps
    var restTime = 0
    var userInput = [WorkoutUserInput]()
    var exerciseSaved = false
    
    override func viewDidLoad() {

        addRestLabel.text = "Add rest time"
        repsLabel.text = "Reps: \(reps)"
        repsStepper.minimumValue = 1
        repsStepper.maximumValue = 10
        
        addNextButton.setTitle("Add another exercise", for: .normal)
        self.exerciseName.delegate = self
        
    }
    
    func addRestTimePicker() {
        //Show rest time picker if user toggles rest time switch
        restPickerView.translatesAutoresizingMaskIntoConstraints = false
        restPickerView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
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
    
    //Get user input values and add to array of workout data
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
        
        guard time > 0 else {return}
        //Add to array of user inputs
        userInput.append(WorkoutUserInput(exerciseName: name, time: time, reps: reps, restTime: restTime)!)
        exerciseSaved = true
        exerciseNumber += 1
        reset()
    }
    
    func reset() {
        //Reset the page for user to enter next exercise
        //Clear stored data
        exerciseSaved = false
        name = ""
        timerPickerView.clearPickerValues()
        restPickerView.clearPickerValues()
        
        //Clear textfield and update placeholder text
        exerciseName.text = nil
        exerciseName.placeholder = "Exercise \(exerciseNumber)"
        
        //Set times to 0, reps to 1, rest time to off
        timerPickerView.selectRow(0, inComponent: 0, animated: true)
        timerPickerView.selectRow(0, inComponent: 2, animated: true)
        restPickerView.selectRow(0, inComponent: 0, animated: true)
        restPickerView.selectRow(0, inComponent: 2, animated: true)
        repsStepper.value = 1
        reps = 1
        repsLabel.text = "Reps: \(reps)"
        addRestSwitch.isOn = false
        restSwitchChanged(addRestSwitch)
    }
    
    //Bring down keyboard when user done editing exercise name
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If current exercise has not been added, add to array
        if exerciseSaved == false && timerPickerView.getTotalSeconds() > 0 {
            getWorkoutValues()
            print("done")
        }
        if userInput.count == 0 {
            let alert = UIAlertController(title: "Empty Workout", message: "Your workout must have at least one exercise", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Add exercise", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        if segue.identifier == "TO_WORKOUT_REVIEW" {
            let workoutReview = segue.destination as! ReviewViewController
            workoutReview.workoutData(workoutExercises: userInput)
        }
    }
    
    @IBAction func repsStepperChanged(_ sender: UIStepper) {
        reps = Int(sender.value)
        repsLabel.text = "Reps: \(reps)"
    }
    
    @IBAction func addNextButtonClick(_ sender: RoundSecondaryButton) {
        if timerPickerView.getTotalSeconds() == 0 {
            let alert = UIAlertController(title: "Exercise incomplete", message: "Exercise duration must be longer than 0 seconds to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            getWorkoutValues()
        }
    }
}

