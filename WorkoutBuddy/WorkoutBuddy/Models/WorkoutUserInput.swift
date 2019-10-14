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
    
    var steps: Int
    var time: Int
    var restTime: Int
    
    //MARK: Initialization
    
    init?(steps: Int, time: Int, restTime: Int) {
        
        guard steps >= 1 else {
            return nil
        }
        
        guard (time <= GlobalConstants.maxTimePerStep) && (time >= GlobalConstants.minTimePerStep) else {
            return nil
        }
        
        guard (restTime <= GlobalConstants.maxRestTime) && (restTime >= GlobalConstants.minRestTime) else {
            return nil
        }
        
        self.steps = steps
        self.time = time
        self.restTime = restTime
    }
    
    func countTime() {
        
    }
}
