//
//  MyProfileVC.swift
//  SocialMediaApp
//
//  Created by mohamed ahmed on 25/01/2025.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = UserManager.loggedInUser{
            if let image = user.image{
                self.image.setImageFromStringUrl(stringUrl: image)
            }
            
            
            self.gender.text = user.gender
            self.fullname.text = user.firstName + " " + user.lastName
            
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func editClickedButton(_ sender: Any) {
        
        if var user = UserManager.loggedInUser{
            
            user.gender = self.gender.text!
            user.age = Int(self.age.text!)
            UserAPI.updateUserInfo(userId: user.id, user: user) { userresponse, error in
                if let userresponse = userresponse{
               
                    self.gender.text = userresponse.gender
                    self.age.text = "\( userresponse.age!)"
                }
                
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
