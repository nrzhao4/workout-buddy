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
    var restTime: Int
    
    //MARK: Initialization
    
    init?(exerciseName: String, time: Int, restTime: Int) {
        
        guard exerciseName != "" else {
            return nil
        }
        
        guard (time <= GlobalConstants.maxTimePerStep) && (time >= GlobalConstants.minTimePerStep) else {
            return nil
        }
        
        guard (restTime <= GlobalConstants.maxRestTime) && (restTime >= GlobalConstants.minRestTime) else {
            return nil
        }
        
        self.exerciseName = exerciseName
        self.time = time
        self.restTime = restTime
    }
    
    func countTime() {
        
    }
}
