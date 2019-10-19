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
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        setData()
        //fatalError("init(coder:) has not been implemented")
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
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 11
        } else if component == 1 || component == 3 {
            return 1
        } else {
            return 60
        }
    }
    
    /*func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(minutes[row])
        } else if component == 1 {
            return "m:"
        } else if component == 2 {
            return String(seconds[row])
        } else {
            return "s"
        }
    }*/
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Avenir", size: 48.0)
        }
        if component == 0 {
            pickerLabel?.text = minutes[row]
            pickerLabel?.textAlignment = .right
        } else if component == 1 {
            pickerLabel?.text = "m"
            pickerLabel?.textAlignment = .left
        } else if component == 2 {
            pickerLabel?.text = seconds[row]
            pickerLabel?.textAlignment = .right
        } else {
            pickerLabel?.text = "s"
            pickerLabel?.textAlignment = .left
        }
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerMinutes = Int(minutes[row])!
        } else if component == 2 {
            pickerSeconds = Int(seconds[row])!
        } else {
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
