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
    var pickerMinutes = 0
    var pickerSeconds = 0
    
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
            if i <= 10 {
                minutes += [String(i)]
            }
            seconds += [String(i)]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 11
        } else if component == 1 {
            return 1
        } else {
            return 60
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerMinutes = Int(minutes[row])!
        } else if component == 1 {
        } else {
            pickerSeconds = Int(seconds[row])!
        }
    }
    
    func getTotalSeconds() -> Int {
        return (pickerMinutes * 60) + pickerSeconds
    }
    
    func clearPickerValues() {
        pickerMinutes = 0
        pickerSeconds = 0
    }
}
