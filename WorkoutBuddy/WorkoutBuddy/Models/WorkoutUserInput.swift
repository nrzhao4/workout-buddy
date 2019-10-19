//
//  WorkoutUserInput.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-09-17.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class WorkoutUserInput {
    
    //MARK: Properties
    
    var exerciseName: String
    var time: Int
    var reps: Int
    var restTime: Int
    
    //MARK: Initialization
    
    init?(exerciseName: String, time: Int, reps: Int, restTime: Int) {
        
        guard exerciseName != "" else {
            return nil
        }
        
        guard (time <= 600) && (time >= 1) else {
            return nil
        }
        
        guard reps >= 1 && reps <= 10 else {
            return nil
        }
        
        guard (restTime <= 600) && (restTime >= 0) else {
            return nil
        }
        
        self.exerciseName = exerciseName
        self.time = time
        self.reps = reps
        self.restTime = restTime
    }
    
    func countTime() {
        
    }
}
