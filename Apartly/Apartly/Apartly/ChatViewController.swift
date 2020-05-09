//
//  ChatViewController.swift
//  Apartly
//
//  Created by Tommy Kim on 5/5/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let list = ["Tommy Kim: Hi", "Michael Kim: What's up!", "Johnny Kim: Nothing much"]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableContentInset()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset.jpg")!)
        self.timeLabel.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        updateView()
    }
    
    func updateView() {
        let date = Date()
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if (minutes >= 50) {
            let breakMinutes = 60 - minutes
            let breakSeconds = 60 - calendar.component(.second, from:date)
            
            if (breakSeconds == 60) {
                let tempMinutes = breakMinutes + 1
                timeLabel.text = String(tempMinutes) + ":00"
            } else if (breakSeconds < 10) {
                timeLabel.text = String(breakMinutes) + ":0" + String(breakSeconds)
            } else {
                timeLabel.text = String(breakMinutes) + ":" + String(breakSeconds)
            }
            
        } else {
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
            
            timeLabel.text = ("\(hour)" + ":" + minuteDisplay)

        }
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.viewDidLoad()
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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.imageView?.image = imageWithImage(image: UIImage(named: "userPicture.png")!, scaledToSize: CGSize(width: 35, height: 35))
        
        cell.contentView.backgroundColor = UIColor.systemFill
        
        return cell
    }
    
    func updateTableContentInset() {
        let numRows = self.tableView.numberOfRows(inSection: 0)
        var contentInsetTop = self.tableView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.tableView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
            }
        }
        self.tableView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }
    
}
