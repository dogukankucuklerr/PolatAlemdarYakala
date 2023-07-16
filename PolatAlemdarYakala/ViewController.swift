//
//  ViewController.swift
//  PolatAlemdarYakala
//
//  Created by Doğukan Küçükler on 15.07.2023.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var score = 0
   var timer = Timer()
    var counter = 0
    var polatArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    

    //Views
  
   
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var polat1: UIImageView!
    
    @IBOutlet weak var polat2: UIImageView!
    
    @IBOutlet weak var polat3: UIImageView!
    
    @IBOutlet weak var polat4: UIImageView!
    
    @IBOutlet weak var polat5: UIImageView!
    
    @IBOutlet weak var polat6: UIImageView!
    
    @IBOutlet weak var polat7: UIImageView!
    
    @IBOutlet weak var polat8: UIImageView!
    
    @IBOutlet weak var polat9: UIImageView!
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
       
        //Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        //Images
        polat1.isUserInteractionEnabled = true
        polat2.isUserInteractionEnabled = true
        polat3.isUserInteractionEnabled = true
        polat4.isUserInteractionEnabled = true
        polat5.isUserInteractionEnabled = true
        polat6.isUserInteractionEnabled = true
        polat7.isUserInteractionEnabled = true
        polat8.isUserInteractionEnabled = true
        polat9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        polat1.addGestureRecognizer(recognizer1)
        polat2.addGestureRecognizer(recognizer2)
        polat3.addGestureRecognizer(recognizer3)
        polat4.addGestureRecognizer(recognizer4)
        polat5.addGestureRecognizer(recognizer5)
        polat6.addGestureRecognizer(recognizer6)
        polat7.addGestureRecognizer(recognizer7)
        polat8.addGestureRecognizer(recognizer8)
        polat9.addGestureRecognizer(recognizer9)
        
        
        polatArray = [polat1,polat2,polat3,polat4,polat5,polat6,polat7,polat8,polat9]
        
        //Timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hidePolat), userInfo: nil, repeats: true)
        hidePolat()
    }
    @objc func hidePolat() {
        
        for polat in polatArray {
            polat.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(polatArray.count - 1)))
        polatArray[random].isHidden = false
        
    }
    @objc func increaseScore() {
       score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countdown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
           
            for polat in polatArray {
                polat.isHidden = true
            }
           //HighScore
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            //Alert
            
            let alert = UIAlertController(title: "Time is over.", message: "Do you want to play again ? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePolat), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
        
    }
   
    
    
   
    
    
    
    
    
    
   
}

