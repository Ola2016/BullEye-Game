//
//  ViewController.swift
//  Bull-eye-blind
//
//  Created by Zhiyong Huang on 01/03/16.
//  Copyright © 2016 Zhiyong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GenerateRandomValue()
        UpdateSetting()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var randomValue:Int = 0
    var totalScore:Int = 0
    var round:Int = 0
    
    
    @IBOutlet weak var targetDisplay: UILabel!
    @IBOutlet weak var slideMove: UISlider!
    
    
    @IBOutlet weak var averagedScoreDisplay: UILabel!
    @IBOutlet weak var roundDisplay: UILabel!
    
    
    @IBAction func HitMeButton(sender: UIButton) {
        round += 1
        totalScore += 100 - abs(randomValue - lroundf(slideMove.value))
        
        
        averagedScoreDisplay.text = "\(Double(totalScore)/Double(round))"
        roundDisplay.text = "\(round)"
        
        let alert = UIAlertController(title:"Bull Eye Game", message: OutputMessage(),
            preferredStyle:.Alert)
        let action = UIAlertAction(title:"Ok",style: .Default, handler:nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:nil)
    }

    
    @IBAction func RestartButton(sender: UIButton) {
        GenerateRandomValue()
        UpdateSetting()
    }
    
    func GenerateRandomValue() {
        randomValue = Int(arc4random_uniform(100)) + 1
    }
    
    func UpdateSetting(){
        targetDisplay.text = "\(randomValue)"
        slideMove.value = 50
    }
    
    func OutputMessage() ->String {
        var message = " The target value is \(randomValue), and your hit is \(lroundf(slideMove.value)) \n"
        
        if abs(randomValue - lroundf(slideMove.value)) == 0 {
            message += " Perfect hit!"
        }
        else if abs(randomValue - lroundf(slideMove.value)) <= 3 {
            message += " Very close!"
        }
        else if abs(randomValue - lroundf(slideMove.value)) <= 10 {
            message += " Not bad, try again!"
        }
        else {
            message += " Obs, it is a bad hit!"
        }
        
        return message
    }

    
    
    
}

