//
//  SignUpViewController.swift
//  Apartly
//
//  Created by Mubarek Mussa on 4/28/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func onSignUp(_ sender: Any) {
        var user = PFUser()
        user.username = emailTextField.text;
        user.password = passwordTextField.text;
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier:"signUpToHome", sender:nil)
            }
            else{
                print("Error:\(error?.localizedDescription)")
            }
            
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
