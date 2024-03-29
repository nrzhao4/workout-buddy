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
    
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    var width = 0.0
    var widthPerSecond = 0.0
    var timerDuration = 0
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
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
    
    //Deprecated
    /*
     
     func setUpdateValues(timerSeconds: Int) {
     widthPerSecond = Double(screenWidth) / Double(timerSeconds)
     }
     
     func clear() {
     backgroundColor = UIColor.white
     width = 0
     frame.size.width = CGFloat(width)
     }
     
    func updateWidth() {
        width += widthPerSecond
        frame.size.width = CGFloat(width)
    }*/
    

}
