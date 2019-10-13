//
//  TimerPickerView.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-13.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class TimerPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var minutes = [String]()
    var seconds = [String]()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        setData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        for i in 0...59 {
            minutes += [String(i) + "m"]
            seconds += [String(i) + "s"]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 || component == 2 {
            return minutes.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(minutes[row])
        } else if component == 1 {
            return ":"
        } else {
            return String(seconds[row])
        }
    }
}
