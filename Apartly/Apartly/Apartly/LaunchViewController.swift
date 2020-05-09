//
//  LaunchViewController.swift
//  Apartly
//
//  Created by Tommy Kim on 5/6/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var sunsetLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sunsetLogo.image = UIImage(named: "sunsetLogo.jpg")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset.jpg")!)
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
