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
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let list = ["Tommy Kim", "Michael Kim", "Johnny Kim", "Tammy Kim", "Bobby Kim", "Tommy Kim", "Michael Kim", "Johnny Kim", "Tammy Kim", "Bobby Kim"]
    
    
    var test = true
    var breakMinutes: Int = 0
    var breakSeconds: Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset.jpg")!)
        
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        progressBar.transform = transform
   
        self.timeLabel.layer.cornerRadius = 20
        self.workUntilLabel.layer.cornerRadius = 20
        self.chatButton.layer.cornerRadius = 25
        
        
        
        
        updateView()
        
    }

    
    func updateView() {
        let date = Date()
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if (minutes >= 50 && test) {
            timeLabel.text = String(breakMinutes) + ":" + String("00")
            timeLabel.frame.origin = CGPoint(x: 113, y: 250)
            
            let workHour = hour % 12 + 1
            workUntilLabel.text = "Work: \(workHour):00"
            
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound (systemSoundID)
            createAlert(title: "Break Time", message: "\nCome back in 10 minutes!")
            
            breakMinutes = 60 - minutes
            breakSeconds = 60 - calendar.component(.second, from:date)
            
            createBreakScreen()
        } else {
            var checkDay = "AM";
            if (hour >= 12) {
                checkDay = "PM"
            }
            
            if (hour == 0 || hour == 12) {
                hour = 12
            } else {
                hour = hour % 12
            }

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
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
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


extension TimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = list[indexPath.row]
        cell.imageView?.tintColor = UIColor.orange
        cell.imageView?.image = imageWithImage(image: UIImage(named: "userPicture.png")!, scaledToSize: CGSize(width: 25, height: 25))
        
        cell.contentView.backgroundColor = UIColor.systemFill
        
        return cell
    }
}
