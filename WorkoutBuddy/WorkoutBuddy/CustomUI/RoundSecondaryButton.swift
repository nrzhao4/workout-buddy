//
//  RoundSecondaryButton.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-14.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class RoundSecondaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    private func setUpButton() {
        
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        backgroundColor = UIColor.clear
        
        layer.cornerRadius = frame.height / 2
        //layer.shadowColor = UIColor.black.cgColor
        //layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        //layer.shadowRadius = 5
        //layer.shadowOpacity = 0.5
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(red: 245/255.0, green: 179/255.0, blue: 66/255.0, alpha: 1.0).cgColor
    }
}
