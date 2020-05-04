//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft":300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    //Function that runs when you select the hardness
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //======RESET THE VALUES========
        progressBar.progress = 0.0
        secondsPassed = 0
        
        titleLabel.text = sender.currentTitle!
        
        //Everytime you select an egg you reset the timer
        timer.invalidate()
        
        //======RESET THE VALUES========
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        //Timer runs repeatedly every second and calls the function UpdateTime each time
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
      
    }
    //Objective C function that gets called
    @objc func UpdateTime(){
        if(secondsPassed < totalTime) {
            secondsPassed += 1
             progressBar.progress = Float(secondsPassed) / Float(totalTime) //convert each values to float before dividing
        }
        else {
            //shut the timer add a title to Done and play the sound function
            timer.invalidate();
            titleLabel.text="Done!"
            playSound(soundName: "alarm_sound")
        }
    }
    //Sound function that reads the file and the extension to play once triggered
    func playSound(soundName: String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
    
