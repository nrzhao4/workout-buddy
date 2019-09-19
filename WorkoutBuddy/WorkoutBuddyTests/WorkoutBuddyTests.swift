//
//  WorkoutBuddyTests.swift
//  WorkoutBuddyTests
//
//  Created by Pluto on 2019-09-15.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import XCTest
@testable import WorkoutBuddy

class WorkoutBuddyTests: XCTestCase {

    //WorkoutUserInput tests
    
    func testWorkoutUserInputInit() {
        
        let maxInput = WorkoutUserInput(steps: 5, time: GlobalConstants.maxTimePerStep, restTime: GlobalConstants.maxRestTime)
        XCTAssertNotNil(maxInput)
        
        let minInput = WorkoutUserInput(steps: 1, time: GlobalConstants.minTimePerStep, restTime: GlobalConstants.minRestTime)
        XCTAssertNotNil(minInput)
        
        let exceedsMaxInput = WorkoutUserInput(steps: 5, time: (GlobalConstants.maxTimePerStep + 1), restTime: (GlobalConstants.maxRestTime + 1))
        XCTAssertNil(exceedsMaxInput)
        
        let lessThanMinInput = WorkoutUserInput(steps: 0, time: (GlobalConstants.minTimePerStep - 1), restTime: (GlobalConstants.minRestTime - 1))
        XCTAssertNil(lessThanMinInput)
    }
    
}
