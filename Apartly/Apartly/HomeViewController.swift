//
//  HomeViewController.swift
//  Apartly
//
//  Created by Tommy Kim on 5/8/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var happyLabel: UILabel!
    
    @IBOutlet weak var readingImg: UIImageView!
    
    @IBOutlet weak var writingImg: UIImageView!
    
    @IBOutlet weak var homeworkImg: UIImageView!

    @IBOutlet weak var musicImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset.jpg")!)
        
        self.happyLabel.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
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
