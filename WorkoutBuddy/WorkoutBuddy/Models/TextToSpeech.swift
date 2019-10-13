//
//  TextToSpeech.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-12.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import AVFoundation

class TextToSpeech {
    
    init() {
    }
    
    func speak(string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        print("Hello world")
    }
    
    
}
