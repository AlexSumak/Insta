//
//  LoginViewController.swift
//  instaclient
//
//  Created by  Alex Sumak on 3/27/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var passwordField: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  @IBAction func onSignIn(_ sender: Any) {
   
    
    PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) -> Void in
      if user != nil{
        print("you're logged in")
        self.performSegue(withIdentifier: "loginSeque", sender: nil)
      }
    }
    
  }
 
  
  
  @IBAction func onSignUp(_ sender: Any) {
    let newUser = PFUser()
    newUser.username = usernameField.text
    newUser.password = passwordField.text
    newUser.signUpInBackground() {
      (succeeded: Bool?, error: Error? ) -> Void in
      if error == nil {
        print("success in log in")
        self.performSegue(withIdentifier: "loginSeque", sender: nil)
      } else {
        print(error?.localizedDescription)
        
      }
    }
  }
  


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
