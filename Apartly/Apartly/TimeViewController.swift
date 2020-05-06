//
//  TimeViewController.swift
//  Apartly
//
//  Created by Tommy Kim on 4/19/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import AVFoundation

class TimeViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var workUntilLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var secondDayLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var test = true
    var breakMinutes = 1
    var breakSeconds = 10
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset.jpg")!)
        
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        progressBar.transform = transform
   
        
        updateView()
        
    }
    
    func updateView() {
        let date = Date()
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if (minutes >= 50 && test) {
            timeLabel.text = String(breakMinutes) + ":" + String("00")
            timeLabel.frame.origin = CGPoint(x: 113, y: 270)
            
            let workHour = hour % 12 + 1
            workUntilLabel.text = "Work: \(workHour):00"
            
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound (systemSoundID)
            createAlert(title: "Break Time", message: "\nCome back in 10 minutes!")
            
            createBreakScreen()
        } else {
            var checkDay = "AM";
            if (hour > 12) {
                checkDay = "PM"
            }
            
            hour = hour % 12

            var minuteDisplay: String
            
            if (minutes < 10) {
                minuteDisplay = "0" + "\(minutes)"
            } else {
                minuteDisplay = "\(minutes)"
            }
            
            progressBar.setProgress(Float(minutes) as Float / 50, animated: true)
            progressBar.trackTintColor = UIColor.red
            progressBar.progressTintColor = UIColor.green
            
            timeLabel.text = ("\(hour)" + ":" + minuteDisplay)
            dayLabel.text = checkDay
            secondDayLabel.text = checkDay
            workUntilLabel.text = "Break: \(hour):50"
        
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.viewDidLoad()
            }
        }
    }
    
    func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func createBreakScreen () {
        dayLabel.isHidden = true
        secondDayLabel.isHidden = true
        progressBar.isHidden = true
        
        
        breakMinutes-=1
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimeViewController.counter), userInfo: nil, repeats: true)
        
    }
    
    @objc func counter() {
        breakSeconds-=1

        if (breakSeconds == 0) {
            if (breakMinutes == 0) {
                timer.invalidate()
                
                let systemSoundID: SystemSoundID = 1016
                AudioServicesPlaySystemSound (systemSoundID)
                
                createAlert(title: "Work Time", message: "\nTime to work!")
                
                workUntilLabel.isHidden = false
                dayLabel.isHidden = false
                secondDayLabel.isHidden = false
                progressBar.isHidden = false
                //test = false
                
                timeLabel.frame.origin = CGPoint(x: 113, y: 228)
              
                updateView()
            } else {
                timeLabel.text = String(breakMinutes) + ":" + String("00")
                breakMinutes-=1
                breakSeconds = 60
            }
        } else if (breakSeconds < 10) {
            timeLabel.text = String(breakMinutes) + ":" + "0" + String(breakSeconds)
        } else {
            timeLabel.text = String(breakMinutes) + ":" + String(breakSeconds)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
