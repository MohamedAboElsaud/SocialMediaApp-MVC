//
//  SignInVC.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 24/01/2025.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var signinPassword: UITextField!
    @IBOutlet weak var signinUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        signinUsername.text = "emilys"
        signinPassword.text = "emilyspass"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinClickedButton(_ sender: Any) {
        
        UserAPI.signInUser(username: signinUsername.text!, password: signinPassword.text!) { user, errorResponse in
            if let message = errorResponse {
                let alert = UIAlertController(title: "Failing signin", message: message, preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert,animated: true)
            }else{
                if let user = user {
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainTabBarController")
                    UserManager.loggedInUser = user
                    self.present(vc!,animated: true)
                    
                }
            }
        }
        
    }
    /*
    // MARK: - Navigation

     @IBAction func signinClickedButton(_ sender: Any) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
