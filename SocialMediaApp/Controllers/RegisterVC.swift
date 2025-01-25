//
//  RegisterVC.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 23/01/2025.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var registerLastName: UITextField!
    
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerFirstName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signinButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func registerClickedButton(_ sender: Any) {
        
        
        UserAPI.registerNewUser(FName: registerFirstName.text!, LName: registerLastName.text!, Email: registerEmail.text!) { userResponse, failerResponse in
            
            if (failerResponse != nil) {
                let alert = UIAlertController(title: "Failing process", message: failerResponse, preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert,animated: true)
            }else{
                let alert = UIAlertController(title: "Success process", message: userResponse?.email, preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(action)
                self.present(alert,animated: true)
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
