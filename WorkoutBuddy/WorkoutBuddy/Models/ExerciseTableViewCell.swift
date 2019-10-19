//
//  ExerciseTableViewCell.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-17.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func setUpCell(exercise: WorkoutUserInput) {
        nameLabel.text = exercise.exerciseName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        infoLabelFormat(exercise: exercise)
    }
    
    func infoLabelFormat(exercise: WorkoutUserInput) {
        let time = exercise.time
        let restTime = exercise.restTime
        let reps = exercise.reps
        
        let seconds = time % 60
        let minutes = (time - seconds) / 60
        
        let restSeconds = restTime % 60
        let restMinutes = (restTime - restSeconds) / 60
        
        if restTime == 0 {
            if seconds < 10 {
                infoLabel.text = "\(reps) x \(minutes):0\(seconds)"
            } else {
                infoLabel.text = "\(reps) x \(minutes):\(seconds)"
            }
            
        } else {
            if seconds < 10 {
                if restSeconds < 10 {
                   infoLabel.text = "\(reps) x \(minutes):0\(seconds), rest \(restMinutes):0\(restSeconds)"
                } else {
                    infoLabel.text = "\(reps) x \(minutes):0\(seconds), rest \(restMinutes):\(restSeconds)"
                }
            } else {
                if restSeconds < 10 {
                    infoLabel.text = "\(reps) x \(minutes):\(seconds), rest \(restMinutes):0\(restSeconds)"
                } else {
                    infoLabel.text = "\(reps) x \(minutes):\(seconds), rest \(restMinutes):\(restSeconds)"
                }
            }
        }
        
    }

}
