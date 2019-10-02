//
//  TimerColourView.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-09-29.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class TimerColourView: UIView {
    var shouldSetupConstraints = true
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    var width = 0.0
    var widthPerSecond = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startTimerBackground(isRestTime: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            shouldSetupConstraints = false
        }
       super.updateConstraints()
    }
    
    func startTimerBackground(isRestTime: Bool) {
        if (isRestTime) {
            backgroundColor = UIColor.green
        } else {
            backgroundColor = UIColor.red
        }
        
        frame.size.width = CGFloat(width)
        frame.size.height = UIScreen.main.bounds.height
    }
    
    func setUpdateValues(timerSeconds: Int) {
        widthPerSecond = Double(screenWidth) / Double(timerSeconds)
    }
    
    func clear() {
        width = 0
        frame.size.width = CGFloat(width)
    }
    
    //Deprecated
    /*
    func updateWidth() {
        width += widthPerSecond
        frame.size.width = CGFloat(width)
    }*/
    

}
